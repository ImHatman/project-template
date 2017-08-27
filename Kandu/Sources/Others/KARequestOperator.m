//
//  KARequestOperator.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KARequestOperator.h"

@implementation KARequestOperator

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return self;
}

@end
