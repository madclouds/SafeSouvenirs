//
//  ProductTableViewCell.m
//  Zoohackathon
//
//  Created by Erik Bye on 10/8/16.
//  Copyright © 2016 Zoohackathon. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Constants.h"

@interface ProductTableViewCell()

@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, strong) UIView *strokeView;
@property (nonatomic, strong) UIView *productLabelContainer;

@property (nonatomic, strong) UILabel *legalLabel;
@property (nonatomic, strong) UILabel *disclosureLabel;

@end

@implementation ProductTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xF9E0A4);
    }
    return self;
}

+ (CGFloat)heightForProduct {
    return 250.0;
}

- (void)isGood:(BOOL)isGood {
    self.disclosureLabel.text = @">>";
    if (isGood) {
        self.badgeView.backgroundColor = UIColorFromRGB(0x26cad3);
        self.strokeView.backgroundColor = UIColorFromRGB(0x26cad3);
        NSString *string = @"LEGAL";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        
        float spacing = 5.0f;
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(spacing)
                                 range:NSMakeRange(0, [string length])];
        self.legalLabel.attributedText = attributedString;
        self.legalLabel.backgroundColor = UIColorFromRGB(0x26cad3);
    } else {
        self.badgeView.backgroundColor = UIColorFromRGB(0xec4b2f);
        self.strokeView.backgroundColor = UIColorFromRGB(0xec4b2f);
        NSString *string = @"ILLEGAL";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        
        float spacing = 5.0f;
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(spacing)
                                 range:NSMakeRange(0, [string length])];
        self.legalLabel.attributedText = attributedString;
        self.legalLabel.backgroundColor = UIColorFromRGB(0xec4b2f);
    }
}

- (UIImageView *)productImageView {
    if (!_productImageView) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:view];
        view.clipsToBounds = YES;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        _productImageView = view;
    }
    return _productImageView;
}

- (UILabel *)productLabel {
    if (!_productLabel) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.textColor = UIColorFromRGB(0x572931);
        view.font = [UIFont fontWithName:@"Raleway-SemiBold" size:20.0];
        
        [self.productLabelContainer addSubview:view];
        
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.0]];
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        
        _productLabel = view;
    }
    return _productLabel;
}

- (UILabel *)disclosureLabel {
    if (!_disclosureLabel) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.textColor = UIColorFromRGB(0x572931);
        view.textAlignment = NSTextAlignmentRight;
        view.font = [UIFont fontWithName:@"Raleway-SemiBold" size:20.0];
        
        [self.productLabelContainer addSubview:view];
        
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        [self.productLabelContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        
        _disclosureLabel = view;
    }
    return _disclosureLabel;
}

- (UIView *)productLabelContainer {
    if (!_productLabelContainer) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.backgroundColor = [UIColor colorWithRed:247/255.0 green:224/255.0 blue:165/255.0 alpha:1.0];
        [self addSubview:view];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
        
        _productLabelContainer = view;
    }
    return _productLabelContainer;
}

- (UIView *)badgeView {
    if (!_badgeView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.productLabelContainer attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        
        
        
        _badgeView = view;
    }
    return _badgeView;
}

- (UIView *)strokeView {
    if (!_strokeView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:2.0]];
        
        
        
        _strokeView = view;
    }
    return _strokeView;
}

- (UILabel *)legalLabel {
    if (!_legalLabel) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.textColor = [UIColor whiteColor];
        view.font = [UIFont fontWithName:@"RubikOne-Regular" size:20.0];
        view.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:view];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:140.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0]];
        
        _legalLabel = view;
    }
    return _legalLabel;
}

@end

NSString * const ProductTableViewCellIdentifier = @"ProductTableViewCellIdentifier";
