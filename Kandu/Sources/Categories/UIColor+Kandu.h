//
//  UIColor+Kandu.h
//  Kandu
//
//  Created by Cyril's Mac on 28/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (Kandu)

+ (UIColor *)primaryColor;
+ (UIColor *)lightYellowColor;
+ (UIColor *)turquoiseColor;
+ (UIColor *)errorColor;
+ (UIColor *)darkLabelColor;
+ (UIColor *)lightLabelColor;
+ (UIColor *)backgroundColor;
+ (UIColor *)separatorViewsColor;
+ (UIColor *)textfieldBackgroundColor;

+ (UIColor *)grayF6;
+ (UIColor *)grayEE;
+ (UIColor *)grayE0;
+ (UIColor *)grayCB;
+ (UIColor *)gray97;
+ (UIColor *)gray4A;
+ (UIColor *)gray30;

+ (UIColor *)colorWithHexaString:(NSString *)hexString;

@end
