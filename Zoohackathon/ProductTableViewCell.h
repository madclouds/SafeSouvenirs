//
//  ProductTableViewCell.h
//  Zoohackathon
//
//  Created by Erik Bye on 10/8/16.
//  Copyright © 2016 Zoohackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productLabel;


- (void)isGood:(BOOL)isGood;

+ (CGFloat)heightForProduct;

@end

extern NSString * const ProductTableViewCellIdentifier;
