//
//  KAResetPasswordVC.m
//  Kandu
//
//  Created by Cyril's Mac on 02/09/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAResetPasswordVC.h"

@interface KAResetPasswordVC ()

@property (nonatomic) BOOL isFirstLayout;

@end

@implementation KAResetPasswordVC

#pragma mark - Lifecycle -
#pragma mark IN

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
//    [self registerToKeyboardDisplayNotifications];
}

#pragma mark OUT

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

#pragma mark - Initialization -
#pragma mark Data & Variables

- (void)initVariables {
    self.isFirstLayout = YES;
}

#pragma mark UI

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.isFirstLayout == YES) {
        [self initUI];
        self.isFirstLayout = NO;
    }
    [self.view layoutIfNeeded];
}

- (void)initUI {
    self.title = @"IDENTIFICATION";
    self.view.backgroundColor = [UIColor backgroundColor];
    self.scrollView.backgroundColor = [UIColor backgroundColor];

    [self initNavBar];
    [self initLabels];
    [self initSeparatorViews];
    [self initTextField];
    
    [self initResetPwdBtn];
}

- (void)initNavBar {
    [self.navigationController.navigationBar displayCloseButton];
}

- (void)initLabels {
    [self initTitleLbl:self.firstSectionTitleLbl];
    [self initTitleLbl:self.secondSectionTitleLbl];
    self.firstSectionContentLbl.font = [UIFont mainFontWithSize:17];
    self.firstSectionContentLbl.textColor = [UIColor darkLabelColor];
}

- (void)initTitleLbl:(UILabel *)label {
    label.font = [UIFont mainBoldFontWithSize:17];
    label.textColor = [UIColor darkLabelColor];
}

- (void)initSeparatorViews {
    self.firstSectionSeparatorView.backgroundColor = [UIColor separatorViewsColor];
    self.secondSectionSeparatorView.backgroundColor = [UIColor separatorViewsColor];
}

- (void)initTextField {
    self.emailTf.font = [UIFont mainFontWithSize:17];
    self.emailTf.textColor = [UIColor darkLabelColor];
    self.emailTf.delegate = self;
    
    self.emailTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.emailTf.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor darkLabelColor]}];

    self.emailTf.enabled = NO;
}

- (void)initResetPwdBtn {
    [self.resetPwdBtn applyMainStyleWithCorners:YES];
}

#pragma mark - Buttons Actions -

- (void)backBtnAction {
    if (self.isDisplayedModally == YES) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Protocols Implementations -
#pragma mark UITextFieldDelegate

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField == self.emailTf) {
//        [self.passwordTf becomeFirstResponder];
//    } else if (textField == self.passwordTf) {
//        [self.passwordTf resignFirstResponder];
//    }
//    return NO;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.loginFailedLbl.hidden = YES;
//}

#pragma mark - Misc -
#pragma mark Toolbox

//- (NSString *)getErrorMessageFromEmail:(NSString *)email {
//    NSString *errorMessage = nil;
//    
//    if ([email isValidString]) {
//        NSString *emailRegex =
//        @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
//        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
//        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
//        @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
//        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
//        @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
//        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
//        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
//        
//        if ([emailTest evaluateWithObject:email] == FALSE) {
//            errorMessage = @"Le format de votre adresse mail est incorrect.";
//        }
//    } else {
//        errorMessage = @"Veuillez saisir un email";
//    }
//    
//    return errorMessage;
//}

#pragma mark Notifications

//- (void)registerToKeyboardDisplayNotifications {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)keyboardWillShow:(NSNotification *)notification {
//    NSDictionary *keyboardInfo = [notification userInfo];
//    NSValue *keyboardFrameEnd = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardFrameEndRect = [keyboardFrameEnd CGRectValue];
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardFrameEndRect.size.height);
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification {
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
//}

#pragma mark Controller Instantiation

+ (KAResetPasswordVC *)controller {
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"KAResetPasswordVC"];
}

+ (UINavigationController *)navigatedController {
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"KAResetPasswordNC"];
}

@end
