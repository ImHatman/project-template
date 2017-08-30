//
//  KASplashScreenVC.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KASplashScreenVC.h"
#import "KAUserManager.h"
#import "KALoginVC.h"

@interface KASplashScreenVC ()

@property (nonatomic) BOOL isFirstLayout;

@end

@implementation KASplashScreenVC

#pragma mark - Lifecycle -
#pragma mark IN

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self preferredStatusBarStyle];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    [self loadRelevantController];
}

#pragma mark OUT

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

#pragma mark - Initialization -
#pragma mark UI

- (void)loadRelevantController {
    BOOL hasAccount = [[KAUserManager sharedManager] hasLoggedInUser];
    
    NSLog(@"KASplashScreenVC : hasAccount = %@", (hasAccount) ? @"YES" : @"NO");
    
    if (hasAccount == NO) {
        [self loadLoginScreen];
    } else {
        [self loadHome];
    }
}

- (void)loadLoginScreen {
    UINavigationController *loginNC = [KALoginVC navigatedController];
    [[UIApplication sharedApplication].keyWindow setRootViewController:loginNC];
}

- (void)loadHome {
//    [[UIApplication sharedApplication].keyWindow setRootViewController:containerVC];
}

#pragma mark Data & Variables

- (void)initVariables {
    self.isFirstLayout = YES;
}

#pragma mark - Misc -
#pragma mark Controller Instantiation

+ (KASplashScreenVC *)controller {
    return [[UIStoryboard storyboardWithName:@"Onboarding" bundle:nil] instantiateViewControllerWithIdentifier:@"KASplashScreenVC"];
}

#pragma mark Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
