//
//  KASlidingPopupManager.m
//  Kandu
//
//  Created by Cyril's Mac on 30/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KASlidingPopupManager.h"
#import "KAPopupFactory.h"

#define OVERLAY_ANIMATION_DURATION 0.25
#define POPUP_ANIMATION_DURATION 0.3

#define SLIDING_N_TRANSLATING_POPUP_DISPLAY_ANIMATION_DURATION 0.3
#define FADING_POPUP_DISPLAY_ANIMATION_DURATION 0.6

#define TRANSFORMATION_ROTATION_VALUE 30
#define TRANSFORMATION_TRANSLATION_VALUE 5

@interface KASlidingPopupManager()

@property (strong, nonatomic) KAPopupFactory *factory;
@property (strong, nonatomic) UIView *displayedPopup;
@property (nonatomic) KAPopupAnimationStyle displayedPopupAnimationStyle;
@property (nonatomic) id displayedPopupTarget;
@property (nonatomic) KAPopupType lastDisplayedPopupType;
@property (strong, nonatomic) UIView *chainedPopup;
@property (strong, nonatomic) UIView *parentView;
@property (strong, nonatomic) UIView *backgroundOverlay;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) KAPopupAnimationStyle currentAnimationStyle;

@end

@implementation KASlidingPopupManager

+ (KASlidingPopupManager *)sharedManager {
    static KASlidingPopupManager *manager = nil;
    if (manager == nil) {
        manager = [[KASlidingPopupManager alloc] init];
        manager.backgroundOverlay = [[UIView alloc] init];
        manager.backgroundOverlay.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        
        // Touch Event
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:manager action:@selector(hidePopup)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [manager.backgroundOverlay setUserInteractionEnabled:YES];
        [manager.backgroundOverlay addGestureRecognizer:singleTap];
    }
    return manager;
}

#pragma mark - Getting Popups

- (UIView *)getPopupForType:(KAPopupType)popupType withParams:(NSDictionary *)params {
    
    UIView *popupView = nil;
    
    if (popupType == KAPopupTypeLogout) {

    } else {
        NSAssert(NO, @"KASlidingPopupManager - showPopup: unknown popup type");
    }
    
    return popupView;
}

#pragma mark - Managing Display

- (void)chainPopup:(KAPopupType)popupType withParams:(NSDictionary *)params {
    [self chainPopup:popupType withParams:params verticalPosition:0.5];
}

- (void)chainPopup:(KAPopupType)popupType withParams:(NSDictionary *)params verticalPosition:(CGFloat)popupPosY {
    
    if (self.isAnimating == YES) {
        return;
    }
    
    self.displayedPopupTarget = nil;
    
    if (self.displayedPopup == nil) {
        [self showPopup:popupType withParams:params];
    } else {
        self.chainedPopup = [self getPopupForType:popupType withParams:params];
        [self.parentView addSubview:self.chainedPopup];
        
        CGPoint origin = CGPointMake(self.parentView.frame.size.width * 1.5, self.parentView.frame.size.height * popupPosY);
        
        self.chainedPopup.center = origin;
        self.chainedPopup.alpha = 0.0;
        self.chainedPopup.transform = [self getTransformationWithRotation:TRANSFORMATION_ROTATION_VALUE andTranslation:TRANSFORMATION_TRANSLATION_VALUE];
        
        CGPoint displayedPopupDestination = CGPointMake(self.parentView.frame.size.width * -0.5, self.displayedPopup.center.y);
        CGPoint chainedPopupDestination = CGPointMake(self.displayedPopup.center.x, origin.y);
        self.isAnimating = YES;
        [UIView animateWithDuration:POPUP_ANIMATION_DURATION animations:^{
            self.displayedPopup.center = displayedPopupDestination;
            self.displayedPopup.alpha = 0.0;
            self.displayedPopup.transform = [self getTransformationWithRotation:-TRANSFORMATION_ROTATION_VALUE andTranslation:-TRANSFORMATION_TRANSLATION_VALUE];
        } completion:^(BOOL finished) {
            if (finished == YES) {
                [self.displayedPopup removeFromSuperview];
                self.displayedPopup = self.chainedPopup;
                self.displayedPopupAnimationStyle = StyleSliding;
                
                [UIView animateWithDuration:POPUP_ANIMATION_DURATION animations:^{
                    self.chainedPopup.alpha = 1.0;
                    self.chainedPopup.transform = [self getTransformationWithRotation:0 andTranslation:0];
                    self.chainedPopup.center = chainedPopupDestination;
                } completion:^(BOOL finished) {
                    self.isAnimating = NO;
                    self.chainedPopup = nil;
                }];
            }
        }];
    }
}

- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params {
    [self showPopup:popupType withParams:params verticalPosition:0.5 animationStyle:StyleSliding];
}

- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params verticalPosition:(CGFloat)popupPosY {
    [self showPopup:popupType withParams:params verticalPosition:popupPosY animationStyle:StyleSliding];
}

- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params animationStyle:(KAPopupAnimationStyle)animationStyle {
    [self showPopup:popupType withParams:params verticalPosition:0.5 animationStyle:animationStyle];
}

- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params verticalPosition:(CGFloat)popupPosY animationStyle:(KAPopupAnimationStyle)animationStyle {
    
    // if there is currently an animation
    if (self.isAnimating == YES) {
        return;
    }
    
    // if there already is a popup displayed
    if (self.displayedPopup != nil) {
        [self chainPopup:popupType withParams:params];
        return;
    }
    
    self.displayedPopupTarget = nil;

    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            self.parentView = window;
            break;
        }
    }

    self.backgroundOverlay.frame = self.parentView.bounds;
    [self.parentView addSubview:self.backgroundOverlay];
    self.displayedPopup = [self getPopupForType:popupType withParams:params];
    self.displayedPopupAnimationStyle = animationStyle;
    
    self.lastDisplayedPopupType = popupType;
    [self.parentView addSubview:self.displayedPopup];
    
    CGPoint origin = CGPointMake(self.parentView.frame.size.width / 2, self.parentView.frame.size.height * popupPosY);
    if (animationStyle == StyleSliding || animationStyle == StyleTranslating) {
        origin = CGPointMake(self.parentView.frame.size.width * 0.5, self.parentView.frame.size.height * 0.15);
        if (animationStyle == StyleSliding) {
            self.displayedPopup.transform = [self getTransformationWithRotation:TRANSFORMATION_ROTATION_VALUE andTranslation:TRANSFORMATION_TRANSLATION_VALUE];
        }
    } else if (animationStyle == StyleFading) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hidePopup];
        });
    }
    self.displayedPopup.center = origin;
    self.displayedPopup.alpha = 0.0;

    self.isAnimating = YES;
    self.currentAnimationStyle = animationStyle;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self animateBackgroundOverlayDisplayWithPopupVerticalPosition:popupPosY];
    });
}

- (void)animateBackgroundOverlayDisplayWithPopupVerticalPosition:(CGFloat)popupPosY {
    static BOOL isFirstTime = YES; // this is a workarround to fix a bug that execute the completion block after only 10% of the expected time
    
    CGFloat animationDuration = (self.displayedPopupAnimationStyle == StyleSliding) ? OVERLAY_ANIMATION_DURATION : OVERLAY_ANIMATION_DURATION * 2;

    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundOverlay.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished == YES) {
            [self performSelector:@selector(animatePopupDisplay:) withObject:[NSNumber numberWithFloat:popupPosY] afterDelay:(isFirstTime == YES) ? (OVERLAY_ANIMATION_DURATION * 0.9) : 0];
            isFirstTime = NO;
        }
    }];
}

- (void)animatePopupDisplay:(NSNumber *)posY {
    CGPoint destination = CGPointMake(self.parentView.frame.size.width / 2, self.parentView.frame.size.height * [posY floatValue]);
    
    CGFloat animationDuration = (self.displayedPopupAnimationStyle == StyleSliding || self.displayedPopupAnimationStyle == StyleTranslating) ? SLIDING_N_TRANSLATING_POPUP_DISPLAY_ANIMATION_DURATION : FADING_POPUP_DISPLAY_ANIMATION_DURATION;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.displayedPopup.center = destination;
        self.displayedPopup.alpha = 1.0;
        if (self.currentAnimationStyle == StyleSliding) {
            self.displayedPopup.transform = [self getTransformationWithRotation:0 andTranslation:0];
        }
    } completion:^(BOOL finished) {
        if (finished == YES) {
            self.isAnimating = NO;
        }
    }];
}

- (void)hidePopup {

    // if there is currently an animation
    if (self.isAnimating == YES) {
        return;
    }

    self.isAnimating = YES;
    
    CGPoint destination = CGPointMake(self.parentView.frame.size.width / 2, self.parentView.frame.size.height);

    [UIView animateWithDuration:POPUP_ANIMATION_DURATION animations:^{
        self.backgroundOverlay.alpha = 0.0;
        self.displayedPopup.alpha = 0.0;
        if (self.displayedPopupAnimationStyle == StyleSliding || self.displayedPopupAnimationStyle == StyleTranslating) {
            if (self.currentAnimationStyle == StyleSliding) {
                self.displayedPopup.transform = [self getTransformationWithRotation:-TRANSFORMATION_ROTATION_VALUE andTranslation:TRANSFORMATION_TRANSLATION_VALUE];
            }
            self.displayedPopup.center = destination;
        }
    } completion:^(BOOL finished) {
        if (self.displayedPopupTarget != nil && [self.displayedPopupTarget respondsToSelector:@selector(managerJustHidPopupOfType:)]) {
            [self.displayedPopupTarget managerJustHidPopupOfType:self.lastDisplayedPopupType];
        }
        self.isAnimating = NO;
        [self.displayedPopup removeFromSuperview];
        [self.backgroundOverlay removeFromSuperview];
        self.displayedPopup = nil;
    }];
}

#pragma mark - Tool Box

- (CGAffineTransform)getTransformationWithRotation:(CGFloat)rotation andTranslation:(CGFloat)translation {
    double rads = M_PI * (rotation / 180.0);
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(rads);
    transform = CGAffineTransformTranslate(transform, 0, translation);
    return transform;
}

@end
