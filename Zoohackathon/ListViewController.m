//
//  ListViewController.m
//  Zoohackathon
//
//  Created by Erik Bye on 10/8/16.
//  Copyright © 2016 Zoohackathon. All rights reserved.
//

#import "ListViewController.h"
#import "ProductTableViewCell.h"
#import "ProductDetailsViewController.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *illegalTableView;
@property (nonatomic, strong) UITableView *legalTableView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, assign) BOOL isIllegal;
@property (nonatomic, strong) UILabel *illegalLabel;
@property (nonatomic, strong) UILabel *legalLabel;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.isIllegal = YES;
    
    
    
    [self.stackView addArrangedSubview:self.illegalLabel];
    [self.stackView addArrangedSubview:self.legalLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isIllegal) {
        [self showIllegal];
    } else {
        [self showLegal];
    }
    
    _illegalTableView = nil;
    _legalTableView = nil;
    
        UIView *legalContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100.0)];
    UILabel *legalDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    legalDescription.text = @"Look for these sustainably sourced goods from local merchants.";
    legalDescription.translatesAutoresizingMaskIntoConstraints = NO;
    legalDescription.textColor = UIColorFromRGB(0x582931);
    legalDescription.numberOfLines = 0;
    legalDescription.textAlignment = NSTextAlignmentCenter;
    legalDescription.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    [legalContainerView addSubview:legalDescription];
    
    self.legalTableView.tableHeaderView = legalContainerView;
    
    [legalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:legalDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:legalContainerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.0]];
    [legalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:legalDescription attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:legalContainerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
    [legalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:legalDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:legalContainerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0]];
    [legalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:legalDescription attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:legalContainerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    
    UIView *illegalContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100.0)];
    UILabel *illegalDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    illegalDescription.text = @"Avoid these illegal products.  They will be confiscated by the United States.";
    illegalDescription.translatesAutoresizingMaskIntoConstraints = NO;
    illegalDescription.textColor = UIColorFromRGB(0x582931);
    illegalDescription.textAlignment = NSTextAlignmentCenter;
    illegalDescription.numberOfLines = 0;
    illegalDescription.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    [illegalContainerView addSubview:illegalDescription];
    
    self.illegalTableView.tableHeaderView = illegalContainerView;
    
    [illegalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:illegalDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:illegalContainerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.0]];
    
    [illegalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:illegalDescription attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:illegalContainerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
    [illegalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:illegalDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:illegalContainerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0]];
    [illegalContainerView addConstraint:[NSLayoutConstraint constraintWithItem:illegalDescription attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:illegalContainerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    

    
    [self.illegalTableView reloadData];
    [self.legalTableView reloadData];
    
    
    
    
    
}

- (void)showLegal {
    self.illegalTableView.hidden = YES;
    self.legalTableView.hidden = NO;
    self.isIllegal = NO;
    [self.illegalTableView reloadData];
    [self.legalTableView reloadData];
    
    self.illegalLabel.textColor = UIColorFromRGB(0x582931);
    self.legalLabel.textColor = [UIColor whiteColor];
    
    UIColor *bgColor = UIColorFromRGB(0x26CAD3);
    
    self.navigationController.navigationBar.barTintColor = bgColor;
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x0f7480);
}

- (void)showIllegal {
    [self.illegalTableView reloadData];
    [self.legalTableView reloadData];
    self.illegalTableView.hidden = NO;
    self.legalTableView.hidden = YES;
    self.isIllegal = YES;
   
    self.legalLabel.textColor = UIColorFromRGB(0x0f7480);
    self.illegalLabel.textColor = [UIColor whiteColor];
    
    UIColor *bgColor = UIColorFromRGB(0xec4b2f);
    
    self.navigationController.navigationBar.barTintColor = bgColor;
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x582931);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isIllegal) {
        
        return [[Constants badStuff] count];
    }
    return [[Constants goodStuff] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ProductTableViewCell heightForProduct];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductTableViewCellIdentifier];
    }
    
    ProductTableViewCell *productCell = (ProductTableViewCell *)cell;
    
    
    NSDictionary *product = nil;
    
    if (self.isIllegal) {
        product = [Constants badStuff][indexPath.row];
    } else {
        product = [Constants goodStuff][indexPath.row];
    }
    
    UIImage *productImage = [UIImage imageNamed:product[@"image"]];
    productCell.productImageView.image = productImage;
    
    productCell.productLabel.text = product[@"name"];
    NSString *isGoodString = product[@"isGood"];
    BOOL isGood = [isGoodString isEqualToString:@"YES"];
    [productCell isGood:isGood];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showProductAtIndexPath:indexPath];
}


- (void)showProductAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailsViewController *product = [[ProductDetailsViewController alloc] initWithNibName:nil bundle:nil];
    NSDictionary *prod = nil;
    if (self.isIllegal) {
        prod = [Constants badStuff][indexPath.row];
    } else {
        prod = [Constants goodStuff][indexPath.row];
    }
    
    product.product = prod;
    [self.navigationController pushViewController:product animated:YES];
}

// MARK: - Lazy Loaders

- (UITableView *)illegalTableView {
    if (!_illegalTableView) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = UIColorFromRGB(0xF9E0A4);
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.separatorColor = [UIColor clearColor];
        [view registerClass:[ProductTableViewCell class] forCellReuseIdentifier:ProductTableViewCellIdentifier];
        
        [self.view addSubview:view];
        
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.stackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        _illegalTableView = view;
    }
    return _illegalTableView;
}
- (UITableView *)legalTableView {
    if (!_legalTableView) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = UIColorFromRGB(0xF9E0A4);
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.separatorColor = [UIColor clearColor];
        [view registerClass:[ProductTableViewCell class] forCellReuseIdentifier:ProductTableViewCellIdentifier];
        
        [self.view addSubview:view];
        
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.stackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        
        
        _legalTableView = view;
    }
    return _legalTableView;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        UIStackView *view = [[UIStackView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.axis = UILayoutConstraintAxisHorizontal;
        view.alignment = UIStackViewAlignmentFill;
        view.distribution = UIStackViewDistributionFillEqually;
        [self.view addSubview:view];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
        
        _stackView = view;
    }
    return _stackView;
}

- (UILabel *)illegalLabel {
    if (!_illegalLabel) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
        view.text = @"Illegal";
        view.backgroundColor = UIColorFromRGB(0xec4b2f);
        view.textColor = [UIColor whiteColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.userInteractionEnabled = YES;
        view.font = [UIFont fontWithName:@"Raleway-SemiBold" size:18.0];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIllegal)];
        [view addGestureRecognizer:tgr];
        
        _illegalLabel = view;
    }
    return _illegalLabel;
}

- (UILabel *)legalLabel {
    if (!_legalLabel) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
        view.text = @"Legal";
        view.backgroundColor = UIColorFromRGB(0x26CAD3);
        view.textColor = UIColorFromRGB(0x0f7480);
        view.textAlignment = NSTextAlignmentCenter;
        view.userInteractionEnabled = YES;
        view.font = [UIFont fontWithName:@"Raleway-SemiBold" size:18.0];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLegal)];
        [view addGestureRecognizer:tgr];
        
        _legalLabel = view;
    }
    return _legalLabel;
}


@end
