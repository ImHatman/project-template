//
//  KAUser.h
//  WeaveTime
//
//  Created by Cyril's Mac on 26/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAAPIClient.h"

@interface KAUser : NSObject <KAMapping>

@property (strong, nonatomic) NSNumber *userID;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *job;
@property (strong, nonatomic) NSString *entity;
@property (strong, nonatomic) NSString *mission;
@property (strong, nonatomic) NSURL *thumbnailImageURL;
@property (strong, nonatomic) NSURL *profilePictureURL;
@property (strong, nonatomic) NSNumber *creditsToGive;
@property (strong, nonatomic) NSNumber *creditsToSpend;

- (BOOL)hasMissingInfo;
- (BOOL)isMe;

- (NSString *)fullName;

@end
