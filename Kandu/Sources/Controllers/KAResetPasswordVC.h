//
//  KAResetPasswordVC.h
//  Kandu
//
//  Created by Cyril's Mac on 02/09/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KAResetPasswordVC : UIViewController <UITextFieldDelegate>

#pragma mark - Properties -

@property (nonatomic) BOOL isDisplayedModally;

#pragma mark - Methods -

+ (KAResetPasswordVC *)controller;
+ (UINavigationController *)navigatedController;

#pragma mark - Linked From Storyboard -
#pragma mark IBOutlets

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *firstSectionTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *firstSectionSeparatorView;
@property (weak, nonatomic) IBOutlet UILabel *firstSectionContentLbl;

@property (weak, nonatomic) IBOutlet UILabel *secondSectionTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *secondSectionSeparatorView;
@property (weak, nonatomic) IBOutlet UITextField *emailTf;

@property (weak, nonatomic) IBOutlet UIButton *resetPwdBtn;

#pragma mark IBActions

@property (weak, nonatomic) IBOutlet UIButton *resetPwdBtnAction;

@end
