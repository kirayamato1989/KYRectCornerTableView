//
//  UIView+Radius.h
//  Kira
//
//  Created by YamatoKira on 16/2/15.
//  Copyright © 2016年 Kira. All rights reserved.
//

// 给视图增加上圆角或者下圆角

#import <UIKit/UIKit.h>

@interface UIView (Radius)

/**
 *  添加圆角
 *
 *  @param corners 需要圆化的角
 *  @param radius  半径
 */
- (void)addRectCorner:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 *  添加圆角以及缩进
 *
 *  @param corners 需要圆化的角
 *  @param radius  半径
 *  @param inserts 缩进
 */

- (void)addRectCorner:(UIRectCorner)corners radius:(CGFloat)radius insets:(UIEdgeInsets)inserts;

/**
 *  移除圆化效果
 */
- (void)removeCornerRadius;

/**
 *  如果子类没有重写则为sel
 *
 *  @return 返回需要被圆角化的视图
 */
- (UIView *)viewForMakeCornerRadius;

@end
