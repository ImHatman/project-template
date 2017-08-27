//
//  KAUser.m
//  WeaveTime
//
//  Created by Cyril's Mac on 26/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAUser.h"
#import "KAUserManager.h"

@interface KAUser()

@property (strong, nonatomic) NSString *thumbnailImageURLAsString;
@property (strong, nonatomic) NSString *profilePictureURLAsString;

@end

@implementation KAUser

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary new];
    
    mapping[@"id"] = @{@"name" : @"userID", @"type" : @"integer"};
    mapping[@"email"] = @{@"name" : @"email", @"type" : @"string"};
    mapping[@"firstname"] = @{@"name" : @"firstName", @"type" : @"string"};
    mapping[@"lastname"] = @{@"name" : @"lastName", @"type" : @"string"};
    mapping[@"job"] = @{@"name" : @"job", @"type" : @"string"};
    mapping[@"entity"] = @{@"name" : @"entity", @"type" : @"string"};
    mapping[@"mission"] = @{@"name" : @"mission", @"type" : @"string"};
    mapping[@"image_name"] = @{@"name" : @"profilePictureURLAsString", @"type" : @"string"};
    mapping[@"small"] = @{@"name" : @"thumbnailImageURLAsString", @"type" : @"string", @"path" : @"image_thumbs"};
    mapping[@"wt_to_give"] = @{@"name" : @"creditsToGive", @"type" : @"integer"};
    mapping[@"wt_to_spend"] = @{@"name" : @"creditsToSpend", @"type" : @"integer"};

    return mapping;
}

- (BOOL)hasMissingInfo {
    return ([self.job isValidString] == NO || [self.entity isValidString] == NO || [self.mission  isValidString] == NO);
}

#pragma mark - User Default Storage Compliance

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.userID forKey:@"userID"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.job forKey:@"job"];
    [encoder encodeObject:self.entity forKey:@"entity"];
    [encoder encodeObject:self.mission forKey:@"mission"];
    [encoder encodeObject:self.thumbnailImageURLAsString forKey:@"thumbnailImageURLAsString"];
    [encoder encodeObject:self.profilePictureURLAsString forKey:@"profilePictureURLAsString"];
    [encoder encodeObject:self.creditsToGive forKey:@"creditsToGive"];
    [encoder encodeObject:self.creditsToSpend forKey:@"creditsToSpend"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.userID = [decoder decodeObjectForKey:@"userID"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.job = [decoder decodeObjectForKey:@"job"];
        self.entity = [decoder decodeObjectForKey:@"entity"];
        self.mission = [decoder decodeObjectForKey:@"mission"];
        self.thumbnailImageURLAsString = [decoder decodeObjectForKey:@"thumbnailImageURLAsString"];
        self.profilePictureURLAsString = [decoder decodeObjectForKey:@"profilePictureURLAsString"];
        self.creditsToGive = [decoder decodeObjectForKey:@"creditsToGive"];
        self.creditsToSpend = [decoder decodeObjectForKey:@"creditsToSpend"];
    }
    return self;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (BOOL)isMe {
    return ([[KAUserManager sharedManager].user.userID integerValue] == [self.userID integerValue]);
}

#pragma mark - Setters -

- (void)setThumbnailImageURLAsString:(NSString *)thumbnailImageURLAsString {
    _thumbnailImageURLAsString = thumbnailImageURLAsString;
    self.thumbnailImageURL = [NSURL URLWithString:thumbnailImageURLAsString];
}

- (void)setProfilePictureURLAsString:(NSString *)profilePictureURLAsString {
    _profilePictureURLAsString = profilePictureURLAsString;
    self.profilePictureURL = [NSURL URLWithString:profilePictureURLAsString];
}

@end
