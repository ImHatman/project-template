//
//  KAWebVC.m
//  Kandu
//
//  Created by Cyril's Mac on 11/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAWebVC.h"

@interface KAWebVC ()

@property (nonatomic) BOOL isFirstLayout;

@end

@implementation KAWebVC

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
    
    [SVProgressHUD dismiss];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self initWebView];
}

- (void)initNavigationBar {
//    [self setNavBarWithBackButtonAction:@selector(backBtnAction) backgroundColor:[UIColor lightBlue] isModal:self.isDisplayedModally];
}

- (void)initWebView {
    [SVProgressHUD showWithStatus:@"Chargement" maskType:SVProgressHUDMaskTypeNone];

    self.webView.delegate = self;
    if (self.URLToLoad != nil)
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.URLToLoad]];
}

#pragma mark - Buttons Actions -

- (void)backBtnAction {
    if (self.isDisplayedModally == YES) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Protocols & Notifications -
#pragma mark UIWebViewDelefate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}


#pragma mark - Misc -
#pragma mark Controller Instantiation

+ (KAWebVC *)controller {
    return [[KAWebVC alloc] initWithNibName:@"KAWebVC" bundle:nil];
}

//+ (UINavigationController *)navigatedController {
//    KANavigationController *nc = [KANavigationController new];
//    KAWebVC *webVC = [KAWebVC controller];
//    [nc setViewControllers:@[webVC] animated:NO];
//    return nc;
//}

#pragma mark Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
