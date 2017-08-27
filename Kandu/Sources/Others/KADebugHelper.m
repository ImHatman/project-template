//
//  KADebugHelper.m
//  Kandu
//
//  Created by Cyril's Mac on 13/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KADebugHelper.h"
#import "KAAppDelegate.h"

@implementation KADebugHelper

+ (BOOL)shouldEraseLocalUser {
#ifdef DEBUG
    return SHOULD_ERASE_LOCAL_USER;
#else
    return NO;
#endif
}

@end
