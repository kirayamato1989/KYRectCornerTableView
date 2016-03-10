//
//  NSObject+Swizzle.m
//  Kira
//
//  Created by YamatoKira on 16/2/26.
//  Copyright © 2016年 Kira. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void)swizzleOriginalSelector:(SEL)original swizzleSelector:(SEL)swizzle isInstanceSelector:(BOOL)isInstance {
    // get Method
    Method originalMethod = nil;
    
    Method swizzlingMethod = nil;
    
    if (isInstance) {
        originalMethod = class_getInstanceMethod([self class], original);
        
        swizzlingMethod = class_getInstanceMethod([self class], swizzle);
    }
    else{
        originalMethod = class_getClassMethod([self class], original);
        
        swizzlingMethod = class_getClassMethod([self class], swizzle);
    }
    
    BOOL didAddMethod = class_addMethod([self class], original, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class], swizzle, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}

@end
