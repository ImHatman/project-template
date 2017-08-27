//
//  AppDelegate.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHOULD_ERASE_LOCAL_USER 0
#define SHOULD_FORCE_UPDATE_PROFILE_VC_DISPLAY_AFTER_LOGIN 0

@interface KAAppDelagate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
