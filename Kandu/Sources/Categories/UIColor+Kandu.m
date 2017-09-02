//
//  UIColor+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 28/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIColor+Kandu.h"

@implementation UIColor (Kandu)

+ (UIColor *)primaryColor {
    return [UIColor turquoiseColor];
}

+ (UIColor *)lightYellowColor {
    return [UIColor colorWithHexaString:@"#EBE05F"];
}

+ (UIColor *)errorColor {
    return [UIColor colorWithHexaString:@"#FF6468"];
}

+ (UIColor *)turquoiseColor {
    return [UIColor colorWithHexaString:@"#009C98"];
}

+ (UIColor *)darkLabelColor {
    return [UIColor colorWithHexaString:@"#003039"];
}

+ (UIColor *)lightLabelColor {
    return [UIColor colorWithHexaString:@"#7F979B"];
}

+ (UIColor *)backgroundColor {
    return [UIColor colorWithHexaString:@"#FBFCFC"];
}

+ (UIColor *)separatorViewsColor {
    return [UIColor colorWithHexaString:@"#D9E0E1"];
}

+ (UIColor *)textfieldBackgroundColor {
    return [UIColor colorWithHexaString:@"#F6F8F9"];
}

+ (UIColor *)grayF6 {
    return [UIColor colorWithHexaString:@"#F6F6F6"];
}

+ (UIColor *)grayEE {
    return [UIColor colorWithHexaString:@"#EEEEEE"];
}

+ (UIColor *)grayE0 {
    return [UIColor colorWithHexaString:@"#E0E0E0"];
}

+ (UIColor *)grayCB {
    return [UIColor colorWithHexaString:@"#CBCBCB"];
}

+ (UIColor *)gray97 {
    return [UIColor colorWithHexaString:@"#979797"];
}

+ (UIColor *)gray4A {
    return [UIColor colorWithHexaString:@"#4A4A4A"];
}

+ (UIColor *)gray30 {
    return [UIColor colorWithHexaString:@"#303030"];
}

+ (UIColor *)colorWithHexaString:(NSString *)hexString {
    
    @try {
        
        /* convert the string into a int */
        unsigned int colorValueR,colorValueG,colorValueB,colorValueA;
        NSString *hexStringCleared = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
        if(hexStringCleared.length == 3) {
            /* short color form */
            /* im lazy, maybe you have a better idea to convert from #fff to #ffffff */
            hexStringCleared = [NSString stringWithFormat:@"%@%@%@%@%@%@", [hexStringCleared substringWithRange:NSMakeRange(0, 1)],[hexStringCleared substringWithRange:NSMakeRange(0, 1)],
                                [hexStringCleared substringWithRange:NSMakeRange(1, 1)],[hexStringCleared substringWithRange:NSMakeRange(1, 1)],
                                [hexStringCleared substringWithRange:NSMakeRange(2, 1)],[hexStringCleared substringWithRange:NSMakeRange(2, 1)]];
        }
        if(hexStringCleared.length == 6) {
            hexStringCleared = [hexStringCleared stringByAppendingString:@"ff"];
        }
        
        NSString *red = [hexStringCleared substringWithRange:NSMakeRange(0, 2)];
        NSString *green = [hexStringCleared substringWithRange:NSMakeRange(2, 2)];
        NSString *blue = [hexStringCleared substringWithRange:NSMakeRange(4, 2)];
        NSString *alpha = [hexStringCleared substringWithRange:NSMakeRange(6, 2)];
        
        [[NSScanner scannerWithString:red] scanHexInt:&colorValueR];
        [[NSScanner scannerWithString:green] scanHexInt:&colorValueG];
        [[NSScanner scannerWithString:blue] scanHexInt:&colorValueB];
        [[NSScanner scannerWithString:alpha] scanHexInt:&colorValueA];
        
        return [UIColor colorWithRed:((colorValueR)&0xFF)/255.0
                               green:((colorValueG)&0xFF)/255.0
                                blue:((colorValueB)&0xFF)/255.0
                               alpha:((colorValueA)&0xFF)/255.0];
        
        
    } @catch (NSException *exception) {
        return [UIColor blackColor];
    }
}

@end
