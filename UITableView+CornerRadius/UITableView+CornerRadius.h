//
//  UITableView+ConerRadius.h
//  Kira
//
//  Created by YamatoKira on 16/2/26.
//  Copyright © 2016年 Kira. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, KYTableViewCornerRadiusStyle) {
    /**
     *  no cornerRadius effect
     */
    KYTableViewCornerRadiusStyleNone = 0,
    /**
     *  make cornerRadius effect to every cell
     */
    KYTableViewCornerRadiusStyleEveryCell = 1,
    /**
     *  make cornerRadius effect only to the first and last cell in one section
     */
    KYTableViewCornerRadiusStyleSectionTopAndBottom = 2,
};

@interface UITableView (CornerRadius)

/**
 *  if enable cornerRadius effect , defaut is NO
 */
@property (nonatomic, assign) BOOL enableCornerRadiusCell;

/**
 *  the cornerRadius effect value
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 *  the insets for cornerRadius
 */
@property (nonatomic, assign) UIEdgeInsets cornerRadiusMaskInsets;

/**
 *  ><
 */
@property (nonatomic, assign) KYTableViewCornerRadiusStyle cornerRadiusStyle;

@end
