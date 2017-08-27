//
//  UIViewController+Utils.h
//  Kandu
//
//  Created by Cyril's Mac on 10/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Utils)

// Alerts
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions;

// Nav Bar
- (void)setNavigationBarAppearence:(BOOL)isDisplayedModally titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font action:(SEL)action;
- (void)setNavBarWithBackButtonAction:(SEL)action isModal:(BOOL)isModal;
- (void)setNavBarWithBackButtonAction:(SEL)action backgroundColor:(UIColor *)color isModal:(BOOL)isModal;

@end
