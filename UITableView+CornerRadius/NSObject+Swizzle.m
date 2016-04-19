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
    
    Class class = isInstance ? [self class] : object_getClass(self);
    
    if (isInstance) {
        originalMethod = class_getInstanceMethod(class, original);
        
        swizzlingMethod = class_getInstanceMethod(class, swizzle);
    }
    else{
        originalMethod = class_getClassMethod(class, original);
        
        swizzlingMethod = class_getClassMethod(class, swizzle);
    }
    
    BOOL didAddMethod = class_addMethod(class, original, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzle, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}

@end
