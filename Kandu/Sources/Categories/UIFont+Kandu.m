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
    return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

+ (UIFont *)mainBoldFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

+ (UIFont *)titleBoldFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

+ (UIFont *)titleLightFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

@end
