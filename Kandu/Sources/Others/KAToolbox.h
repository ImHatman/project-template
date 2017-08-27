//
//  KAToolbox.h
//  Kandu
//
//  Created by Cyril's Mac on 08/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KAToolbox : NSObject

+ (void)printFrame:(CGRect)frame fromObjectWithName:(NSString *)objectName;
+ (void)printSize:(CGSize)size fromObjectWithName:(NSString *)prefixMessage;
+ (void)printPoint:(CGPoint)point fromObjectWithName:(NSString *)prefixMessage;

@end
