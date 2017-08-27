//
//  KARequestOperator.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface KARequestOperator : AFHTTPRequestOperationManager

- (id)initWithBaseURL:(NSURL *)url;

@end
