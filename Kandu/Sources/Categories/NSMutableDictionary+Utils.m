//
//  NSMutableDictionary+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 09/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "NSMutableDictionary+Utils.h"

@implementation NSMutableDictionary (Utils)

- (void)safelySetObject:(id)object forKey:(id)key {
    
    // This method is meant to avoid crash for setting nil objet in NSDictionary

    if (object != nil && key != nil && !([object isKindOfClass:[NSString class]] == YES && [(NSString *)object isValidString] == NO)) {
        [self setObject:object forKey:key];
    } else {
        NSLog(@"CRASH AVOIDED : [NSMutableDictionary] Tryed to set nil object for key %@", key);
    }
}

@end
