//
//  NSString+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)isValidString {
    return ([self isEqualToString:@""] == NO);
}

@end
