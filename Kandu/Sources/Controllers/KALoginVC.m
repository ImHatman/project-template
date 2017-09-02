//
//  KALoginVC.m
//  Kandu
//
//  Created by Cyril's Mac on 30/08/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KALoginVC.h"
#import "KAWebVC.h"
#import "KAAPIClient.h"
#import "KAUser.h"
#import "KADebugHelper.h"

#define FORGOTTEN_PWD_SEGUE @"passwordForgotten"
#define LAUNCH_APP_SEGUE @"launchApp"

@interface KALoginVC ()

@property (nonatomic) BOOL isFirstLayout;
@property (nonatomic) BOOL isLoging;
@property (nonatomic, weak) UITextField *selectedTextField;

@end

@implementation KALoginVC

#pragma mark - Lifecycle -
#pragma mark IN

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerToKeyboardDisplayNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark OUT

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.selectedTextField resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

#pragma mark - Initialization -
#pragma mark Data & Variables

- (void)initVariables {
    self.isFirstLayout = YES;
    self.isLoging = NO;
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
    self.title = @"KANDU";
    self.view.backgroundColor = [UIColor backgroundColor];
    self.scrollView.backgroundColor = [UIColor backgroundColor];
    
    [self initTitleView];
    [self initTextForm];
    self.submitView.layoutDelegate = self;
}

- (void)initTitleView {
    self.titleLbl.font = [UIFont mainFontWithSize:22];
    self.titleLbl.textColor = [UIColor darkLabelColor];
    self.titleSeparatorView.backgroundColor = [UIColor lightYellowColor];
}

- (void)initTextForm {
    [self initLoginFailedLbl];
    
    [self initTextFieldContainerView:self.emailTfContainerView];
    [self initTextFieldContainerView:self.passwordTfContainerView];

    [self initTextField:self.emailTf];
    [self initTextField:self.passwordTf];
    
    [self initForgottenPasswordBtn];
    [self initLoginBtn];
}

- (void)initLoginFailedLbl {
    self.loginFailedLbl.textColor = [UIColor errorColor];
    self.loginFailedLbl.font = [UIFont mainFontWithSize:14];
    self.loginFailedLbl.hidden = YES;
}

- (void)initTextFieldContainerView:(UIView *)containerView {
    containerView.backgroundColor = [UIColor textfieldBackgroundColor];
    containerView.layer.cornerRadius = 3;
}

- (void)initTextField:(UITextField *)textField {
    textField.font = [UIFont mainFontWithSize:17];
    textField.textColor = [UIColor darkLabelColor];
    textField.delegate = self;
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor darkLabelColor]}];

}

- (void)initForgottenPasswordBtn {
    self.forgottenPasswordBtn.titleLabel.font = [UIFont mainFontWithSize:14];
    [self.forgottenPasswordBtn setTitleColor:[UIColor lightLabelColor] forState:UIControlStateNormal];
}

- (void)initLoginBtn {
    [self.loginBtn applyMainStyleWithCorners:YES];
}

- (void)initWebSiteLbl {
    
    TTTAttributedLabel *webSiteLbl = [[TTTAttributedLabel alloc] initWithFrame:self.linkLbl.frame];
    
    webSiteLbl.font = [UIFont mainFontWithSize:14];
    webSiteLbl.textColor = [UIColor lightLabelColor];
    webSiteLbl.textAlignment = NSTextAlignmentCenter;
    webSiteLbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    webSiteLbl.userInteractionEnabled = YES;
    
    NSString *link = @"www.kandu.fr";
    NSString *fullText = [NSString stringWithFormat:@"Retrouvez-nous sur : %@", link];
    
    NSRange linkRange = [fullText rangeOfString:link];
    
    webSiteLbl.linkAttributes = @{(id)kCTForegroundColorAttributeName : (id)[[UIColor primaryColor] CGColor], (id)kCTFontAttributeName : (id)[UIFont mainMediumFontWithSize:14]};
    webSiteLbl.activeLinkAttributes = @{(id)kCTForegroundColorAttributeName : (id)[[UIColor primaryColor] CGColor]};
    webSiteLbl.text = fullText;
    [webSiteLbl addLinkToURL:[NSURL URLWithString:link] withRange:linkRange];
    webSiteLbl.adjustsFontSizeToFitWidth = YES;
    webSiteLbl.delegate = self;
    [webSiteLbl setNeedsDisplay];
    [self.linkLbl.superview addSubview:webSiteLbl];
    self.linkLbl.hidden = YES;
}

#pragma mark - Buttons Actions -

- (IBAction)forgottenPasswordBtnAction:(id)sender {
    [self performSegueWithIdentifier:FORGOTTEN_PWD_SEGUE sender:self];
}

- (IBAction)loginBtnAction:(id)sender {
    
    self.loginFailedLbl.hidden = YES;
    
    if ([KADebugHelper shouldSkipAuthentication]) {
        [self launchApp];
        return;
    }
    
    NSString *email = self.emailTf.text;
    NSString *password = self.passwordTf.text;
    
    // Error Handling
    NSString *error = [self getErrorMessageFromEmail:email];
    if ([error isValidString] == NO) {
        error = [self getErrorMessageFromPassword:password];
    }
    if ([error isValidString] == YES) {
        self.loginFailedLbl.hidden = NO;
//        [self showAlertWithTitle:nil andMessage:error];
        return;
    }
    
    [self loginWithEmail:email andPassword:password];
}

- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password {
    
    if (self.isLoging == YES) {
        return;
    }
    
    self.isLoging = YES;
    [SVProgressHUD showWithStatus:@"Connexion en cours..."];
    
    [[KAAPIClient sharedClient] authenticateUserWithEmail:email andPassword:password withCompletion:^(BOOL success, KAUser *user, NSString *errorMessage) {
        self.isLoging = NO;
        [SVProgressHUD dismiss];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (success) {
                [self handleLoginResponse:user];
            } else if ([errorMessage isValidString]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:errorMessage];
                });
            }
        });
    }];
}

- (void)handleLoginResponse:(KAUser *)user {
    NSAssert(user != nil && [user isKindOfClass:[KAUser class]] == YES, @"handleLoginResponse : missing User object");
    [self launchApp];
}

- (void)launchApp {
    [self performSegueWithIdentifier:LAUNCH_APP_SEGUE sender:self];
}

#pragma mark - Protocols & Notifications -
#pragma mark TTTAttributedLabel

- (void)attributedLabel:(__unused TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [self loadWebViewWithURL:url];
}

- (void)loadWebViewWithURL:(NSURL *)url {
//    UINavigationController *nc = [KAWebVC navigatedController];
//    KAWebVC *webVC = (KAWebVC *)nc.topViewController;
//    webVC.isDisplayedModally = YES;
//    webVC.URLToLoad = url;
//    webVC.title = [@"CGU" uppercaseString];
//    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTf) {
        [self.passwordTf becomeFirstResponder];
    } else if (textField == self.passwordTf) {
        [self.passwordTf resignFirstResponder];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.loginFailedLbl.hidden = YES;
    self.selectedTextField = textField;
}

#pragma mark UIViewLayoutDelegate

- (void)viewHasBeenLayedOut:(UIView *)view {
    if (view == self.submitView) {
        [self initWebSiteLbl];
    }
}

#pragma mark - Misc -
#pragma mark Toolbox

- (NSString *)getErrorMessageFromEmail:(NSString *)email {
    NSString *errorMessage = nil;
    
    if ([email isValidString]) {
        NSString *emailRegex =
        @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
        
        if ([emailTest evaluateWithObject:email] == FALSE) {
            errorMessage = @"Le format de votre adresse mail est incorrect.";
        }
    } else {
        errorMessage = @"Veuillez saisir un email";
    }
    
    return errorMessage;
}

- (NSString *)getErrorMessageFromPassword:(NSString *)password {
    NSString *errorMessage = nil;
    
    if ([password isValidString] == NO) {
        errorMessage = @"Veuillez saisir un mot de passe";
    }
    
    return errorMessage;
}

#pragma mark Notifications

- (void)registerToKeyboardDisplayNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameEnd = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameEndRect = [keyboardFrameEnd CGRectValue];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardFrameEndRect.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
}

#pragma mark Controller Instantiation

+ (KALoginVC *)controller {
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"KALoginVC"];
}

+ (UINavigationController *)navigatedController {
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"KALoginNC"];
}

@end
