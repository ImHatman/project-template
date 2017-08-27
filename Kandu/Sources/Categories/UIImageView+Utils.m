//
//  UIImageView+Utils.m
//  Kandu
//
//  Created by Cyril's Mac on 03/07/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIImageView+Utils.h"

@implementation UIImageView (Utils)

+ (CGFloat)heightForImage:(UIImage *)image withWidth:(CGFloat)width {
    CGFloat imageRatio = image.size.height / image.size.width;
    CGFloat height = width * imageRatio;
    return height;
}

@end
