//
//  UIView+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 17/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)addShadowWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY radius:(CGFloat)radius andOpacity:(CGFloat)opacity {
    self.layer.shadowOffset = CGSizeMake(offsetX, offsetY);
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
}

- (void)removeShadow {
    self.layer.shadowOpacity = 0.0;
}

- (CGFloat)origX {
    return self.frame.origin.x;
}

- (CGFloat)origY {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setOrigX:(CGFloat)origX {
    CGRect frame = self.frame;
    frame.origin.x = origX;
    self.frame = frame;
}

- (void)setOrigY:(CGFloat)origY {
    CGRect frame = self.frame;
    frame.origin.y = origY;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
