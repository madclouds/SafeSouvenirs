//
//  ProductDetailsViewController.m
//  Zoohackathon
//
//  Created by Erik Bye on 10/8/16.
//  Copyright © 2016 Zoohackathon. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "HeroSliderView.h"

@interface ProductDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *legalLabel;
@property (nonatomic, strong) UIColor *dividerColor;

@property (nonatomic, strong) UIImageView *displayView;

@end

typedef NS_ENUM(NSInteger, ProductDetailsSections) {
    ProductDetailsSectionCopy         = 0,
    ProductDetailsSectionActions      = 1,
    ProductDetailsSectionCount        = 2
};

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setProduct:(NSDictionary *)product {
    _product = product;
    
    HeroSliderView *view = [[HeroSliderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 300.0)];
    UIImage *image = [UIImage imageNamed:product[@"image"]];
    view.imageView.image = image;
    self.tableView.tableHeaderView = view;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleImageTapped)];
    [view addGestureRecognizer:tgr];
    
    NSString *isGoodString = product[@"isGood"];
    BOOL isGood = [isGoodString isEqualToString:@"YES"];
    if (isGood) {
        self.dividerColor = UIColorFromRGB(0x26CAD3);
        NSString *string = @"LEGAL";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        
        float spacing = 5.0f;
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(spacing)
                                 range:NSMakeRange(0, [string length])];
        self.legalLabel.attributedText = attributedString;
        self.legalLabel.backgroundColor = UIColorFromRGB(0x26CAD3);
    } else {
        self.dividerColor = UIColorFromRGB(0xFF4612);
        NSString *string = @"ILLEGAL";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        
        float spacing = 5.0f;
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(spacing)
                                 range:NSMakeRange(0, [string length])];
        self.legalLabel.attributedText = attributedString;
        self.legalLabel.backgroundColor = UIColorFromRGB(0xFF4612);
    }
    
    
    
    self.title = product[@"name"];
    [self.tableView reloadData];
}


- (void)handleImageTapped {
    CGRect headerFrame = self.tableView.tableHeaderView.frame;
    headerFrame.origin.y += 64.0;
    self.displayView = [[UIImageView alloc] initWithFrame:headerFrame];
    UIImage *image = [UIImage imageNamed:self.product[@"image"]];
    self.displayView.image = image;
//    self.displayView.clipsToBounds = YES;
    self.displayView.userInteractionEnabled = YES;
    self.displayView.contentMode = UIViewContentModeScaleAspectFill;
    [self.navigationController.view addSubview:self.displayView];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDisplayImageTapped)];
    [self.displayView addGestureRecognizer:tgr];
    
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^{
        self.displayView.frame = self.navigationController.view.bounds;
    } completion:^(BOOL finished) {
       
    }];
}

- (void)handleDisplayImageTapped {
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^{
        CGRect headerFrame = self.tableView.tableHeaderView.frame;
        headerFrame.origin.y += 64.0;
        self.displayView.frame = headerFrame;
    } completion:^(BOOL finished) {
        [self.displayView removeFromSuperview];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ProductDetailsSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == ProductDetailsSectionCopy) {
        NSString *copy = self.product[@"description"];
        
        CGRect rect = [copy boundingRectWithSize:CGSizeMake(CGRectGetWidth(tableView.frame)-65, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular]} context:nil];
        return CGRectGetHeight(rect)+10.0;
        
    }
    return 190.0;
    
}

- (void)handleActionTap {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.bangkok.com/shopping-market/popular-markets.htm"] options:0 completionHandler:^(BOOL success) {
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEST"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TEST"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.section == ProductDetailsSectionCopy) {
        
        UILabel *copyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        copyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:copyLabel];
        
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:copyLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:copyLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:copyLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:copyLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        
        copyLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:18.0];
        copyLabel.textColor = UIColorFromRGB(0x582931);
        copyLabel.numberOfLines = 0;
        copyLabel.text = self.product[@"description"];
    } else {
       
        
        UILabel *action = [[UILabel alloc] initWithFrame:CGRectZero];
        action.translatesAutoresizingMaskIntoConstraints = NO;
        action.text = @"Find out more information";
        NSString *isGoodString = self.product[@"isGood"];
        BOOL isGood = [isGoodString isEqualToString:@"YES"];
        if (isGood) {
            action.text = @"Find where to buy products";
        }
        action.backgroundColor = UIColorFromRGB(0x582931);
        action.userInteractionEnabled = YES;
        action.textColor = [UIColor whiteColor];
        action.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:action];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTap)];
        [action addGestureRecognizer:tgr];
        
        UILabel *action2 = [[UILabel alloc] initWithFrame:CGRectZero];
        action2.translatesAutoresizingMaskIntoConstraints = NO;
        action2.text = @"U.S. Declaration Form 6059B";
        if (isGood) {
            action2.text = @"U.S. Declaration Form 6059B";
        }
        action2.backgroundColor = UIColorFromRGB(0x582931);
        action2.userInteractionEnabled = YES;
        action2.textColor = [UIColor whiteColor];
        action2.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:action2];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:action attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
        
    
        UILabel *action3 = [[UILabel alloc] initWithFrame:CGRectZero];
        action3.translatesAutoresizingMaskIntoConstraints = NO;
        action3.text = @"Permits to import";
        if (isGood) {
            action3.text = @"Permits to import";
        }
        action3.backgroundColor = UIColorFromRGB(0x582931);
        action3.userInteractionEnabled = YES;
        action3.textColor = [UIColor whiteColor];
        action3.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:action3];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:action2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:action3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
        
        

    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == ProductDetailsSectionCopy) {
        return 0;
    }
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == ProductDetailsSectionCopy) {
        return nil;
    }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 20.0)];
        view.backgroundColor = self.dividerColor;
        return view;

}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = UIColorFromRGB(0xF9E0A4);
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.separatorColor = [UIColor clearColor];
        
        [self.view addSubview:view];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        _tableView = view;
    }
    return _tableView;
}

- (UILabel *)legalLabel {
    if (!_legalLabel) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.textColor = [UIColor whiteColor];
        view.font = [UIFont fontWithName:@"RubikOne-Regular" size:20.0];
        view.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:view];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:140.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view  attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0]];
        
        _legalLabel = view;
    }
    return _legalLabel;
}

@end
