//
//  KAEnvManager.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAEnvManager.h"

@implementation KAEnvManager

+ (KAEnvManager *)activeEnv {
    static KAEnvManager *activeEnv= nil;
    if (activeEnv == nil) {
        activeEnv = [[KAEnvManager alloc] init];
    }
    return activeEnv;
}

- (id)init {
    self = [super init];
    if (self) {
        self.config = [[NSMutableDictionary alloc] init];
        [self.config setValue:@"https://weave.geoks-dev.fr/" forKey:@"base_api_url"];
    }
    return self;
}

@end
