//
//  KAAPIClient.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KARequestOperator.h"

@class KAUser;

typedef void(^KAAPIBlock)(BOOL success, id result, NSString *errorMessage);

@protocol KAMapping <NSObject>

+ (NSDictionary *)mapping;

@optional
- (NSDictionary *)serialized;
- (void)deserializationDidEnd;

@end

@interface KAAPIClient : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) KARequestOperator *requestOperator;

+ (KAAPIClient *)sharedClient;
- (void)useAccessToken:(NSString *)accessToken;

// User
- (void)authenticateUserWithEmail:(NSString *)email andPassword:(NSString *)password withCompletion:(KAAPIBlock)completion;
- (void)disconnect;

@end
