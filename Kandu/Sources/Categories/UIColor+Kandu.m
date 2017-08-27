//
//  UIColor+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 28/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIColor+Kandu.h"

@implementation UIColor (Kandu)

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

+ (UIColor *)darkBlue {
    return [UIColor colorWithHexaString:@"#0F4873"];
}

+ (UIColor *)lightBlue {
    return [UIColor colorWithHexaString:@"#00B6DA"];
}

+ (UIColor *)veryLightBlue {
    return [UIColor colorWithHexaString:@"#45D9F6"];
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

+ (UIColor *)giveCreditsColor {
    return [UIColor colorWithHexaString:@"#00E885"];
}

+ (UIColor *)spendCreditsColor {
    return [UIColor colorWithHexaString:@"#7AE7EA"];
}

+ (UIColor *)placeholderColor {
    return [UIColor colorWithHexaString:@"#C7C7CD"];
}

+ (UIColor *)keyboardColor {
    return [UIColor colorWithHexaString:@"#D1D5DB"];
}

@end
