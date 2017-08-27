//
//  KAToolbox.m
//  Kandu
//
//  Created by Cyril's Mac on 08/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import "KAToolbox.h"

@implementation KAToolbox

+ (void)printFrame:(CGRect)frame fromObjectWithName:(NSString *)objectName {
    NSLog(@"%@ frame : {%f, %f / %f x %f}", objectName, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}

+ (void)printSize:(CGSize)size fromObjectWithName:(NSString *)prefixMessage {
    NSLog(@"%@ size : {%f x %f}", prefixMessage, size.width, size.height);
}

+ (void)printPoint:(CGPoint)point fromObjectWithName:(NSString *)prefixMessage {
    NSLog(@"%@ point : (%f ; %f)", prefixMessage, point.x, point.y);
}


@end
