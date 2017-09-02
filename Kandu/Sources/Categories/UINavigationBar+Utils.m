//
//  UINavigationBar+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 02/09/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UINavigationBar+Utils.h"

@implementation UINavigationBar (Utils)

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, NAV_BAR_HEIGHT);
    [self setTitleVerticalPositionAdjustment:(DEFAULT_NAV_BAR_HEIGHT - NAV_BAR_HEIGHT) / 2 forBarMetrics:UIBarMetricsDefault];
    return newSize;
}

@end
