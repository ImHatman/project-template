//
//  AppDelegate.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAAppDelegate.h"
#import "KAUserManager.h"
#import "KAAPIClient.h"
#import "KADebugHelper.h"

@interface KAAppDelagate ()

@end

@implementation KAAppDelagate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initalizeProgressHUD];
    [self initalizeNavBarAppearance];
 
    if ([KADebugHelper shouldEraseLocalUser]) {
        [[KAUserManager sharedManager] deleteCurrentUser];
    }
    
    // Initialization (fetching info from NSUserDefault)
    [KAAPIClient sharedClient];
    [KAUserManager sharedManager];
    
    
    
    return YES;
}

- (void)initalizeProgressHUD {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.85]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

- (void)initalizeNavBarAppearance {
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor darkLabelColor], NSForegroundColorAttributeName,
                                                           [UIFont mainFontWithSize:26], NSFontAttributeName, nil]];
}

#pragma mark - App Life Cycle

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
