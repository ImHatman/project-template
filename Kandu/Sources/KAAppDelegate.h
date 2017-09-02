//
//  AppDelegate.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHOULD_ERASE_LOCAL_USER 0
#define SHOULD_SKIP_AUTHENTICATION 1

@interface KAAppDelagate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
