//
//  NSAttributedString+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 16/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "NSAttributedString+Kandu.h"

@implementation NSAttributedString (Kandu)

+ (NSAttributedString *)navBarTitleAttributedStringWithBoldString:(NSString *)boldString lightString:(NSString *)lightString andFontSize:(CGFloat)fontSize {
    NSString *fullString = [NSString stringWithFormat:@"%@ %@", boldString, lightString];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullString];
    [attr addAttribute:NSFontAttributeName value:[UIFont titleBoldFontWithSize:fontSize] range:[fullString rangeOfString:boldString]];
    [attr addAttribute:NSFontAttributeName value:[UIFont titleLightFontWithSize:fontSize] range:[fullString rangeOfString:lightString]];
    return attr;
}

//+ (NSAttributedString *)defaultTitleAttributedString {
//    return [NSAttributedString navBarTitleAttributedStringWithBoldString:@"JOHN" lightString:@"DOE" andFontSize:22];
//}


@end
