//
//  KALoginVC.h
//  Kandu
//
//  Created by Cyril's Mac on 30/08/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KALoginVC : UIViewController

#pragma mark - Properties -

@property (nonatomic) BOOL isDisplayedModally;

#pragma mark - Methods -

+ (KALoginVC *)controller;
+ (UINavigationController *)navigatedController;

#pragma mark - Linked From Storyboard -
#pragma mark IBOutlets

#pragma mark IBActions

@end
