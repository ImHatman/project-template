//
//  KAUserDefaultsManager.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAUserDefaultsManager.h"

#define ACCESS_TOKEN_KEY @"accessToken"
#define USER_KEY @"user"
#define SETTINGS_KEY @"settings"

@implementation KAUserDefaultsManager

+ (KAUserDefaultsManager *)sharedManager {
    static KAUserDefaultsManager *sharedManager= nil;
    if (sharedManager == nil) {
        sharedManager = [[KAUserDefaultsManager alloc] init];
    }
    return sharedManager;
}

#pragma mark - Access Token

- (NSString *)readAccessToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN_KEY];
}

- (void)storeAccessToken:(NSString *)accessToken {
    if ([accessToken isValidString] == NO) {
        [self eraseAccessToken];
        return;
    }

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:accessToken forKey:ACCESS_TOKEN_KEY];
    [userDefaults synchronize];
}

- (void)eraseAccessToken {
    [self eraseObjectWithKey:ACCESS_TOKEN_KEY];
}

#pragma mark - User

- (KAUser *)fetchStoredUser {
    KAUser *user = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [userDefaults objectForKey:USER_KEY];
    if (encodedObject != nil) {
        user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    }
    
    return user;
}

- (void)storeUser:(KAUser *)user {
    if (user == nil) {
        [self eraseUser];
        return;
    }
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:encodedObject forKey:USER_KEY];
    [userDefaults synchronize];
}

- (void)eraseUser {
    [self eraseObjectWithKey:USER_KEY];
}

#pragma mark - General -

- (void)eraseObjectWithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

@end
