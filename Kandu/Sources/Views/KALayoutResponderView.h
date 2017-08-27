//
//  KALayoutResponderView.h
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewLayoutDelegate

- (void)viewHasBeenLayedOut:(UIView *)view;

@end

@interface KALayoutResponderView : UIView

@property (nonatomic, weak) id layoutDelegate;

@end
