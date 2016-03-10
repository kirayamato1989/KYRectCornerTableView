//
//  NSObject+Swizzle.h
//  Kira
//
//  Created by YamatoKira on 16/2/26.
//  Copyright © 2016年 Kira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleOriginalSelector:(SEL)original swizzleSelector:(SEL)swizzle isInstanceSelector:(BOOL)isInstance;

@end
