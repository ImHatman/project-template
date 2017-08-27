//
//  KAPopupFactory.m
//  Kandu
//
//  Created by Cyril's Mac on 30/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAPopupFactory.h"

@interface KAPopupFactory()

@property (strong, nonatomic) UIView *popupView;

@end

@implementation KAPopupFactory

+ (KAPopupFactory *)sharedFactory {
    static KAPopupFactory *sharedFactory = nil;
    if (sharedFactory == nil) {
        sharedFactory = [[KAPopupFactory alloc] init];
    }
    return sharedFactory;
}

//- (UIView *)deletePostPopupWithTarget:(id)target andPost:(KAPost *)post {
//    KADeletePostPopupView *popup = [[[NSBundle mainBundle] loadNibNamed:@"KADeletePostPopupView" owner:self options:nil] firstObject];
//    popup.delegate = target;
//    popup.post = post;
//    return popup;
//}

@end
