//
//  KAEnvManager.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KAEnvManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *config;
@property (nonatomic, strong) NSString *name;

+ (KAEnvManager *)activeEnv;

@end
