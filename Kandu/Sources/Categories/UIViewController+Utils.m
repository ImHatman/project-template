//
//  UIViewController+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 10/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

#pragma mark - Showing Alerts

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Fermer" style:UIAlertActionStyleDefault handler:nil];
    [self showAlertWithTitle:title andMessage:message actions:@[action]];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (UIAlertAction *anAction in actions) {
        [alertController addAction:anAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Nav Bar

- (void)setNavigationBarAppearence:(BOOL)isDisplayedModally titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font action:(SEL)action {
    NSString *backBtnImageName;
    UIButton *backBtn;
    
    if (backgroundColor != nil) {
        self.navigationController.navigationBar.barTintColor = backgroundColor;
    }
    
    if (isDisplayedModally == YES) {
        backBtnImageName = @"blackCross";
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(3, 10, 18, 18)];
    } else {
        backBtnImageName = @"blackLeftArrow";
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 9, 18, 20)];
    }
    
    if (action != nil) {
        UIColor *backButtonColor = [UIColor whiteColor];
        [backBtn setImage:[UIImage filledImageNamed:backBtnImageName withColor:backButtonColor] forState:UIControlStateNormal];
        backBtn.contentMode = UIViewContentModeScaleAspectFit;
        [backBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, titleColor, NSForegroundColorAttributeName, nil]];
}

- (void)setNavBarWithBackButtonAction:(SEL)action isModal:(BOOL)isModal {
    [self setNavBarWithBackButtonAction:action backgroundColor:nil isModal:isModal];
}

- (void)setNavBarWithBackButtonAction:(SEL)action backgroundColor:(UIColor *)backgroundColor isModal:(BOOL)isModal {
    [self setNavigationBarAppearence:isModal titleColor:[UIColor whiteColor] backgroundColor:backgroundColor font:[UIFont mainFontWithSize:15] action:action];
}

@end
