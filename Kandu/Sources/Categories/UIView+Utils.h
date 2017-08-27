//
//  UIView+Utils.h
//  Kandu
//
//  Created by Cyril's Mac on 17/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Utils)

- (void)addShadowWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY radius:(CGFloat)radius andOpacity:(CGFloat)opacity;
- (void)removeShadow;

- (CGFloat)origX;
- (CGFloat)origY;
- (CGFloat)width;
- (CGFloat)height;

- (void)setOrigX:(CGFloat)origX;
- (void)setOrigY:(CGFloat)origY;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

@end
