//
//  KAUserDefaultsManager.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAUser.h"

@interface KAUserDefaultsManager : NSObject

+ (KAUserDefaultsManager *)sharedManager;

#pragma mark - Access Token

- (NSString *)readAccessToken;
- (void)storeAccessToken:(NSString *)accessToken;
- (void)eraseAccessToken;

// User
- (KAUser *)fetchStoredUser;
- (void)storeUser:(KAUser *)user;
- (void)eraseUser;

@end
