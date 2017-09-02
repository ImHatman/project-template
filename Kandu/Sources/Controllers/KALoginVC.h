//
//  KALoginVC.h
//  Kandu
//
//  Created by Cyril's Mac on 30/08/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "KALayoutResponderView.h"

@interface KALoginVC : UIViewController <UITextFieldDelegate, TTTAttributedLabelDelegate, UIViewLayoutDelegate>

#pragma mark - Properties -

@property (nonatomic) BOOL isDisplayedModally;

#pragma mark - Methods -

+ (KALoginVC *)controller;
+ (UINavigationController *)navigatedController;

#pragma mark - Linked From Storyboard -
#pragma mark IBOutlets

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *titleSeparatorView;

@property (weak, nonatomic) IBOutlet UILabel *loginFailedLbl;
@property (weak, nonatomic) IBOutlet UIView *emailTfContainerView;
@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UIView *passwordTfContainerView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *forgottenPasswordBtn;

@property (weak, nonatomic) IBOutlet KALayoutResponderView *submitView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *linkLbl;

#pragma mark IBActions

- (IBAction)forgottenPasswordBtnAction:(id)sender;
- (IBAction)loginBtnAction:(id)sender;

@end
