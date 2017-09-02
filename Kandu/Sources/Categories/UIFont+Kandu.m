//
//  UIFont+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 14/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIFont+Kandu.h"

@implementation UIFont (Kandu)

+ (UIFont *)mainFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"DINOT" size:fontSize];
}

+ (UIFont *)mainBoldFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"DINOT-Bold" size:fontSize];
}

+ (UIFont *)mainMediumFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"DINOT-Medium" size:fontSize];
}

+ (UIFont *)mainLightFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"DINOT-Light" size:fontSize];
}

@end
