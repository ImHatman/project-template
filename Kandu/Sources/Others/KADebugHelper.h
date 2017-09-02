//
//  KADebugHelper.h
//  Kandu
//
//  Created by Cyril's Mac on 13/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KADebugHelper : NSObject

+ (BOOL)shouldEraseLocalUser;
+ (BOOL)shouldSkipAuthentication;

@end
