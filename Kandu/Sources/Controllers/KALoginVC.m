//
//  KALoginVC.m
//  Kandu
//
//  Created by Cyril's Mac on 30/08/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KALoginVC.h"
//#import "UIViewController+NavBar.h"

/** Most frequently used Classes */
//#import "UIColor+Loyalty.h"
//#import "UIImage+Loyalty.h"
//#import "FMAPIClient.h"
//#import <SDWebImage/UIImageView+WebCache.h>

@interface KALoginVC ()

@property (nonatomic) BOOL isFirstLayout;

@end

@implementation KALoginVC

#pragma mark - Lifecycle -
#pragma mark IN

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark OUT

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

#pragma mark - Initialization -
#pragma mark Data & Variables

- (void)initVariables {
    self.isFirstLayout = YES;
}

#pragma mark UI

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.isFirstLayout == YES) {
        [self initUI];
        self.isFirstLayout = NO;
    }
    [self.view layoutIfNeeded];
}

- (void)initUI {
	[self initNavigationBar];
}

- (void)initNavigationBar {
	[self setNavBarWithBackButtonAction:@selector(backBtnAction) isModal:self.isDisplayedModally];
	self.title = @"KALoginVC";
}


#pragma mark - Buttons Actions -

- (void)backBtnAction {
    if (self.isDisplayedModally == YES) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Protocols Implementations -

// UITableViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate ... etc

#pragma mark - Misc -
#pragma mark Controller Instantiation

+ (KALoginVC *)controller {
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"KALoginVC"];
}

+ (UINavigationController *)navigatedController {
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"KALoginNC"];
}

@end
