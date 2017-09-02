//
//  KAWebVC.h
//  Kandu
//
//  Created by Cyril's Mac on 11/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KAWebVC : UIViewController <UIWebViewDelegate>

#pragma mark - Properties -

@property (nonatomic) BOOL isDisplayedModally;
@property (nonatomic, strong) NSURL *URLToLoad;

#pragma mark - Methods -

+ (KAWebVC *)controller;
+ (UINavigationController *)navigatedController;

#pragma mark - Linked From XIB -
#pragma mark IBOutlets

@property (weak, nonatomic) IBOutlet UIWebView *webView;

#pragma mark IBActions

@end
