//
//  UIView+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 15/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIView+Kandu.h"

@implementation UIView (Kandu)

- (void)applyTextFieldStyle {
    self.layer.borderWidth = 2;
    self.layer.borderColor = [[UIColor grayEE] CGColor];
}

- (void)addPopupsShadow {
    [self addShadowWithOffsetX:0 offsetY:0 radius:4 andOpacity:0.5];
}

- (void)addTimelineCellShadow {
    [self addShadowWithOffsetX:0 offsetY:0 radius:3 andOpacity:0.35];
}

- (void)addEventCellShadow {
    [self addShadowWithOffsetX:0 offsetY:0 radius:3 andOpacity:0.35];
}

- (void)addTokenShadow {
    [self addShadowWithOffsetX:0 offsetY:0 radius:1 andOpacity:0.35];
}

@end
