//
//  KAAPIClient.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAAPIClient.h"
#import "KAUserDefaultsManager.h"
#import "KAEnvManager.h"
#import "KAUserManager.h"
#import "Reachability.h"

#define NO_CONNECTION_ERROR_MESSAGE @"Serveur injoignable... En panne de réseau ?"
#define DEFAULT_ERROR_MESSAGE @"Une erreur est survenue. Réessayez ultérieurement"

@implementation KAAPIClient

- (instancetype)init {
    self = [super init];
    if (self) {
        [self useAccessToken:[[KAUserDefaultsManager sharedManager] readAccessToken] isNeKAoken:NO];
        self.requestOperator = [[KARequestOperator alloc] initWithBaseURL:[NSURL URLWithString:[[KAEnvManager activeEnv].config objectForKey:@"base_api_url"]]];
    }
    return self;
}

+ (KAAPIClient *)sharedClient {
    static KAAPIClient *sharedClient = nil;
    if (sharedClient == nil) {
        sharedClient = [[KAAPIClient alloc] init];
    }
    return sharedClient;
}

#pragma mark - API Calls -
#pragma mark User

- (void)authenticateUserWithEmail:(NSString *)email andPassword:(NSString *)password withCompletion:(KAAPIBlock)completion {
    
    NSString *path = @"/api/v1/sessions/login";
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params safelySetObject:email forKey:@"email"];
    [params safelySetObject:password forKey:@"password"];
    
    [self.requestOperator POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion != nil) {
            
            NSString *accessToken = [responseObject objectForKey:@"access_token"];
            [self useAccessToken:accessToken];
            
            KAUser *user = [self deserializeObject:responseObject[@"user"] withClass:[KAUser class]];
            if (user != nil) {
                [[KAUserManager sharedManager] saveUser:user];
                completion(YES, user, nil);
            } else {
                completion(NO, nil, [self buildErrorMessageFromResponse:responseObject]);
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion != nil) {
            completion(NO, nil, [self buildErrorMessageFromResponse:operation.responseObject]);
        }
    }];
}

- (void)disconnect {
    [self useAccessToken:nil];
    [[KAUserManager sharedManager] deleteCurrentUser];
}

#pragma mark - Misc -
#pragma mark Access Token

- (void)useAccessToken:(NSString *)accessToken {
    [self useAccessToken:accessToken isNeKAoken:YES];
}

- (void)useAccessToken:(NSString *)accessToken isNeKAoken:(BOOL)isNeKAoken {
    NSLog(@"Using Access Token : %@", accessToken);
    self.accessToken = accessToken;
    
    if (isNeKAoken == YES) {
        [[KAUserDefaultsManager sharedManager] storeAccessToken:accessToken];
    }
}

- (NSString *)generateAuthenticatedPathFrom:(NSString *)path {
    NSString *authenticatedPath = [NSString stringWithFormat:@"%@?access_token=%@", path, self.accessToken];
    return authenticatedPath;
}

#pragma mark Error Message Generation

- (NSString *)buildErrorMessageFromResponse:(id)responseObject {
    NSString *message = ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) ? NO_CONNECTION_ERROR_MESSAGE : responseObject[@"message"];
    return (message != nil) ? message : DEFAULT_ERROR_MESSAGE;
}

#pragma mark Serialization

- (id)deserializeObjects:(id)objects withClass:(Class<KAMapping>)class {
    return [self deserializeObjects:objects withClass:class withRootName:YES];
}

- (id)deserializeObjects:(id)objects withClass:(Class<KAMapping>)class withRootName:(BOOL)withRootName {
    NSMutableArray *collection = nil;
    if ([objects isKindOfClass:[NSDictionary class]]) {
        return [self deserializeObject:[[objects allValues] lastObject] withClass:class];
    } else {
        collection = [NSMutableArray array];
        for (id object in objects) {
            if (withRootName)
                [collection addObject:[self deserializeObject:[[object allValues] lastObject] withClass:class]];
            else
                [collection addObject:[self deserializeObject:object withClass:class]];
        }
    }
    return collection;
}

- (id)deserializeObject:(id)object inEntity:(id<KAMapping>)entity {
    NSDictionary *mapping;
    mapping = [[entity class] mapping];
    
    id instance = entity;
    for (id remoteKey in [mapping allKeys]) {
        NSString *type = mapping[remoteKey][@"type"];
        id value = nil;
        id remoteValue;
        NSString *path;
        path = mapping[remoteKey][@"path"];
        if (path == nil) {
            remoteValue = object[remoteKey];
        } else {
            remoteValue = object[path][remoteKey];
        }
        if ([type isEqualToString:@"string"]) {
            if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                value = remoteValue;
            }
        } else if ([type isEqualToString:@"date"]) {
            if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                if (remoteValue)
                {
                    struct tm tm;
                    time_t t;
                    strptime([remoteValue cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%Z", &tm);
                    tm.tm_isdst = -1;
                    t = mktime(&tm);
                    value = [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
                    
                }
            }
        } else if ([type isEqualToString:@"integer"]) {
            if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                value = [NSNumber numberWithInteger:[remoteValue integerValue]];
            }
        } else if ([type isEqualToString:@"integer_array"]) {
            if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                value = [NSArray arrayWithArray:remoteValue];
            }
        } else if ([type isEqualToString:@"float"]) {
            if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                value = [NSNumber numberWithFloat:[remoteValue floatValue]];
            }
        } else if ([type isEqualToString:@"has_one"]) {
            Class relation = NSClassFromString([mapping valueForKey:remoteKey][@"class"]);
            value = [self deserializeObject:[object valueForKey:remoteKey]
                                 withClass:relation];
        } else if ([type isEqualToString:@"has_many"]) {
            Class relation = NSClassFromString([mapping valueForKey:remoteKey][@"class"]);
            NSMutableArray *a = [NSMutableArray array];
            for (id object in remoteValue) {
                
                id v = [self deserializeObject:object
                                     withClass:relation];
                
                [a addObject:v];
            }
            
            value = [NSMutableArray arrayWithArray:[a copy]];
            
        } else if ([type isEqualToString:@"dictionary"]) {
            if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                value = [remoteValue valueForKey:remoteKey];
            }
        }
        
        if (value != nil)
            [instance setValue:value forKey:[mapping valueForKey:remoteKey][@"name"]];
    }
    return instance;
}

- (id)deserializeObject:(id)object withClass:(Class)class {
    return [self deserializeObject:object withClass:class withChildPath:nil];
}


- (id)deserializeObject:(id)object withClass:(Class)class withChildPath:(NSString*)childPath {
    
    NSDictionary *mapping = [class mapping];
    id instance = nil;
    
    if (object != nil && ![object isKindOfClass:[NSNull class]]) {
        instance = [[class alloc] init];
        for (id remoteKey in [mapping allKeys]) {
            @try {
                NSString *type = mapping[remoteKey][@"type"];
                id value = nil;
                id remoteValue;
                NSString *path;
                path = childPath ? childPath : mapping[remoteKey][@"path"];
                if (path == nil) {
                    remoteValue = object[remoteKey];
                } else {
                    id pathObject = object[path];
                    if (![pathObject isKindOfClass:[NSNull class]])
                        remoteValue = object[path][remoteKey];
                }
                if ([type isEqualToString:@"string"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        value = remoteValue;
                    }
                } else if ([type isEqualToString:@"string_array"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        value = [NSArray arrayWithArray:remoteValue];
                    }
                } else if ([type isEqualToString:@"date"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        if (remoteValue)
                        {
                            
                            struct tm tm;
                            time_t t;
                            strptime([remoteValue cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%Z", &tm);
                            tm.tm_isdst = -1;
                            t = mktime(&tm);
                            value = [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
                        }
                    }
                } else if ([type isEqualToString:@"integer"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        value = [NSNumber numberWithInteger:[remoteValue integerValue]];
                    }
                } else if ([type isEqualToString:@"integer_array"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        value = [NSArray arrayWithArray:remoteValue];
                    }
                } else if ([type isEqualToString:@"float"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        value = [NSNumber numberWithFloat:[remoteValue floatValue]];
                    }
                } else if ([type isEqualToString:@"has_one"]) {
                    Class relation = NSClassFromString([mapping valueForKey:remoteKey][@"class"]);
                    NSString *childPath = [mapping valueForKey:remoteKey][@"child_path"];
                    if ([remoteValue isKindOfClass:[NSNull class]] == false)
                        value = [self deserializeObject:remoteValue withClass:relation withChildPath:childPath];
                    else
                        value = [self deserializeObject:[object valueForKey:remoteKey]
                                             withClass:relation withChildPath:childPath];
                } else if ([type isEqualToString:@"has_many"]) {
                    Class relation = NSClassFromString([mapping valueForKey:remoteKey][@"class"]);
                    NSString *childPath = [mapping valueForKey:remoteKey][@"child_path"];
                    NSMutableArray *a = [NSMutableArray array];
                    
                    for (id object in remoteValue) {
                        id v = object;
                        if (relation != [NSString class] && relation != [NSNumber class])
                            v = [self deserializeObject:object withClass:relation withChildPath:childPath];
                        [a addObject:v];
                    }
                    
                    value = [NSMutableArray arrayWithArray:[a copy]];
                    
                } else if ([type isEqualToString:@"dictionary"]) {
                    if ([remoteValue isKindOfClass:[NSNull class]] == false) {
                        value = [remoteValue valueForKey:remoteKey];
                    }
                }
                [instance setValue:value forKey:[mapping valueForKey:remoteKey][@"name"]];
                
                if ([instance respondsToSelector:@selector(deserializationDidEnd)]) {
                    [instance deserializationDidEnd];
                }
            }
            @catch (NSException *exception) {}
            @finally {}
        }
    }
    return instance;
}

- (NSArray *)serializedArrayWithClass:(Class)class andArray:(NSArray *)array
{
    NSAssert([class instancesRespondToSelector:@selector(serialized)], @"Trying to serialize an Array of non-serializable objects of class %@", class);
    NSMutableArray *serializedArray = [@[] mutableCopy];
    for (id object in array)
    {
        [serializedArray addObject:[object serialized]];
    }
    return serializedArray;
}

@end
