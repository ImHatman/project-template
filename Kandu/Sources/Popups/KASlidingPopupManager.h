//
//  KASlidingPopupManager.h
//  Kandu
//
//  Created by Cyril's Mac on 30/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAPopupFactory.h"

#define TARGET_KEY @"target"
#define POST_KEY @"post"
#define REWARD_KEY @"reward"

typedef enum KAPopupAnimationStyle {
    StyleSliding,
    StyleTranslating,
    StyleFading
} KAPopupAnimationStyle;

typedef enum KAPopupType {
    KAPopupTypeLogout
} KAPopupType;

@class KASlidingPopupManager;

@protocol KASlidingPopupManagerDelegate

- (void)managerJustHidPopupOfType:(KAPopupType)type;

@end

@interface KASlidingPopupManager : NSObject

+ (KASlidingPopupManager *)sharedManager;

- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params;
- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params verticalPosition:(CGFloat)posY;
- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params animationStyle:(KAPopupAnimationStyle)animationStyle;
- (void)showPopup:(KAPopupType)popupType withParams:(NSDictionary *)params verticalPosition:(CGFloat)popupPosY animationStyle:(KAPopupAnimationStyle)animationStyle;

- (void)chainPopup:(KAPopupType)popupType withParams:(NSDictionary *)params;
- (void)chainPopup:(KAPopupType)popupType withParams:(NSDictionary *)params verticalPosition:(CGFloat)popupPosY;

- (void)hidePopup;

@end
