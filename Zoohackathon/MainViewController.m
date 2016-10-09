//
//  MainViewController.m
//  Zoohackathon
//
//  Created by Erik Bye on 10/8/16.
//  Copyright © 2016 Zoohackathon. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"
#import "HeroSliderView.h"

CGFloat const padding = 20.0;

@interface MainViewController () <UITextFieldDelegate>

@property (nonatomic, strong) HeroSliderView *heroSlider;
@property (nonatomic, strong) HeroSliderView *heroSlider2;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIView *searchFieldContainer;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *splashImageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.heroSlider];
    int i = arc4random() % 4 + 1;
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
    self.heroSlider.imageView.image = image;
    
    i = arc4random() % 4 + 1;
    UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
    self.heroSlider2.imageView.image = image2;
    
    self.searchField.delegate = self;
    
    self.splashImageView.image = [UIImage imageNamed:@"splash.png"];
    
    [UIView animateWithDuration:1 delay:3 options:0 animations:^{
        self.splashImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self changeImage];
    }];
}

- (void)changeImage {
    HeroSliderView *showSlider = nil;
    HeroSliderView *hideSlider = nil;
    if (self.heroSlider2.alpha == 0) {
        showSlider = self.heroSlider2;
        hideSlider = self.heroSlider;
        
    } else {
        showSlider = self.heroSlider;
        hideSlider = self.heroSlider2;
    }
    
    [self.view insertSubview:showSlider belowSubview:self.searchFieldContainer];
    int i = arc4random() % 4 + 1;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
    showSlider.imageView.image = image;
    
    
    [UIView animateWithDuration:1.0 delay:3.0 options:0 animations:^{
        showSlider.alpha = 1.0;
    } completion:^(BOOL finished) {
        hideSlider.alpha = 0;
        [self changeImage];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchField.text = @"";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.activityView stopAnimating];
}


- (void)handleGoToListAction:(id)sender {
    ListViewController *list = [[ListViewController alloc] initWithNibName:nil bundle:nil];
    list.title = self.searchField.text;
    [self.navigationController pushViewController:list animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.activityView startAnimating];
    
    [self performSelector:@selector(handleGoToListAction:) withObject:nil afterDelay:2];
    
    return NO;
}

// MARK: - lazy loaders

- (HeroSliderView *)heroSlider {
    if (!_heroSlider) {
        HeroSliderView *view = [[HeroSliderView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGoToListAction:)];
        
        [view addGestureRecognizer:tgr];
        
        _heroSlider = view;
    }
    return _heroSlider;
}
- (HeroSliderView *)heroSlider2 {
    if (!_heroSlider2) {
        HeroSliderView *view = [[HeroSliderView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGoToListAction:)];
        
        [view addGestureRecognizer:tgr];
        view.alpha = 0;
        _heroSlider2 = view;
    }
    return _heroSlider2;
}


- (UITextField *)searchField {
    if (!_searchField) {
        UITextField *view = [[UITextField alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.placeholder = @"Enter your destination";
        view.textColor = [UIColor whiteColor];
        view.autocorrectionType = UITextAutocorrectionTypeNo;
        view.font = [UIFont fontWithName:@"Raleway-SemiBold" size:22.0];
        view.attributedPlaceholder = [[NSAttributedString alloc] initWithString:view.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [self.searchFieldContainer addSubview:view];
        
        [self.searchFieldContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.searchFieldContainer attribute:NSLayoutAttributeLeft multiplier:1.0 constant:70.0]];
        [self.searchFieldContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.searchFieldContainer attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.searchFieldContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.searchFieldContainer attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        
        [self.searchFieldContainer addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.searchFieldContainer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        _searchField = view;
    }
    return _searchField;
}

- (UIView *)searchFieldContainer {
    if (!_searchFieldContainer) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.layer.borderColor = [[UIColor whiteColor] CGColor];
        view.layer.borderWidth = 5.0;
        view.layer.cornerRadius = 35.0;
        [self.view addSubview:view];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:padding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-padding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:padding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.0]];
        _searchFieldContainer = view;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.image = [UIImage imageNamed:@"mag-glass.png"];
        [view addSubview:imageView];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
    }
    return _searchFieldContainer;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        UIStackView *view = [[UIStackView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.axis = UILayoutConstraintAxisHorizontal;
        view.alignment = UIStackViewAlignmentFill;
        view.distribution = UIStackViewDistributionFillEqually;
        view.spacing = 10.0;
        [self.view addSubview:view];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:padding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-padding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-padding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
        
        _stackView = view;
    }
    return _stackView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:view];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.searchFieldContainer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40.0]];
        
        view.hidesWhenStopped = YES;
        [view startAnimating];
        
        _activityView = view;
    }
    return _activityView;
}

- (UIImageView *)splashImageView {
    if (!_splashImageView) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
        
        _splashImageView = view;
    }
    return _splashImageView;
}

@end
