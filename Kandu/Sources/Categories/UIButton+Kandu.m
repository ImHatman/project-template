//
//  UIButton+Kandu.m
//  Kandu
//
//  Created by Cyril's Mac on 02/09/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "UIButton+Kandu.h"

@implementation UIButton (Kandu)

- (void)applyMainStyleWithCorners:(BOOL)cornered  {
    self.backgroundColor = [UIColor primaryColor];
    self.titleLabel.font = [UIFont mainBoldFontWithSize:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = (cornered) ? 2 : 0;
}

@end
