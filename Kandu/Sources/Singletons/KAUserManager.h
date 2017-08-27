//
//  KAUserManager.h
//  Kandu
//
//  Created by Cyril's Mac on 26/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAUser.h"

@interface KAUserManager : NSObject

@property (strong, nonatomic) KAUser *user;

+ (KAUserManager *)sharedManager;
- (BOOL)hasLoggedInUser;

- (void)saveUser:(KAUser *)user;
- (void)deleteCurrentUser;
- (void)userGaveCredits:(NSNumber *)creditsGiven;
- (void)userSpentCredits:(NSNumber *)creditsSpent;

@end
