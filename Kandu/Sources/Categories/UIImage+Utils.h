//
//  UIImage+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 28/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (Utils)

+ (UIImage *)filledImageNamed:(NSString *)imageName withColor:(UIColor *)color;
+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color;

@end
