//
//  KAUserManager.m
//  Kandu
//
//  Created by Cyril's Mac on 26/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAUserManager.h"
#import "KAUserDefaultsManager.h"

@implementation KAUserManager

+ (KAUserManager *)sharedManager {
    static KAUserManager *sharedManager = nil;
    if (sharedManager == nil) {
        sharedManager = [[KAUserManager alloc] init];
    }
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadStoredUser];
    }
    return self;
}

- (void)loadStoredUser {
    self.user = [[KAUserDefaultsManager sharedManager] fetchStoredUser];
}

- (void)saveUser:(KAUser *)user {
    self.user = user;
    [[KAUserDefaultsManager sharedManager] storeUser:user];
}

- (void)deleteCurrentUser {
    self.user = nil;
    [[KAUserDefaultsManager sharedManager] eraseUser];
}

- (BOOL)hasLoggedInUser {
    if (self.user == nil) {
        [self loadStoredUser];
    }
    
    BOOL hasUser = self.user != nil;
    BOOL hasAccessToken = [[KAAPIClient sharedClient].accessToken isValidString];
    
    NSLog(@"hasLoggedInUser : hasUser = %@ && hasAccessToken = %@", (hasUser) ? @"YES" : @"NO", (hasAccessToken) ? @"YES" : @"NO");
    
    return (hasUser && hasAccessToken);
}

- (void)userGaveCredits:(NSNumber *)creditsGiven {
    self.user.creditsToGive = [NSNumber numberWithInteger:[self.user.creditsToGive integerValue] - [creditsGiven integerValue]];
}

- (void)userSpentCredits:(NSNumber *)creditsSpent {
    self.user.creditsToSpend = [NSNumber numberWithInteger:[self.user.creditsToSpend integerValue] - [creditsSpent integerValue]];
}

@end
