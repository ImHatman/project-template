//
//  NSMutableDictionary+Utils.h
//  Kandu
//
//  Created by Cyril's Mac on 09/06/2017.
//  Copyright © 2017 Geoks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Utils)

- (void)safelySetObject:(id)object forKey:(id)key;

@end
