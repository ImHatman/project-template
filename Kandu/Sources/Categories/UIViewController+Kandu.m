//
//  UIViewController+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 31/08/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIViewController+Kandu.h"

@implementation UIViewController (Kandu)

- (void)showNavigationBarWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
//    self.navigationController.navigationBar.barStyle = UIBarSt
    self.title = title;
}

- (void)showNavigationBarWithTitle:(NSString *)title {
    [self showNavigationBarWithTitle:title subtitle:nil];
}

@end
