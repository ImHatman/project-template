//
//  KALayoutResponderView.m
//  Kandu
//
//  Created by Cyril's Mac on 25/05/17.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KALayoutResponderView.h"

@implementation KALayoutResponderView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.layoutDelegate != nil && [self.layoutDelegate respondsToSelector:@selector(viewHasBeenLayedOut:)] == YES) {
        [self.layoutDelegate viewHasBeenLayedOut:self];
    }
}

@end
