//
//  UITableView+ConerRadius.m
//  Kira
//
//  Created by YamatoKira on 16/2/26.
//  Copyright © 2016年 Kira. All rights reserved.
//

#import "UITableView+CornerRadius.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
#import "UIView+Radius.h"


static void *KY_tableViewEnableCornerRadiusCellKey = &KY_tableViewEnableCornerRadiusCellKey;

static void *KY_tableViewConerRadiusKey = &KY_tableViewConerRadiusKey;

static void *KY_tableViewConerRadiusStyleKey = &KY_tableViewConerRadiusStyleKey;

static void *KY_tableViewCornerRadiusMaskInserts = &KY_tableViewCornerRadiusMaskInserts;


@implementation UITableView (CornerRadius)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleOriginalSelector:NSSelectorFromString(@"_createPreparedCellForGlobalRow:withIndexPath:willDisplay:") swizzleSelector:@selector(KY_createPreparedCellForGlobalRow:withIndexPath:willDisplay:) isInstanceSelector:YES];
    });
}

#pragma mark getter&setter
- (void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, KY_tableViewConerRadiusKey, @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cornerRadius {
    return [objc_getAssociatedObject(self, KY_tableViewConerRadiusKey) floatValue];
}

- (void)setCornerRadiusStyle:(KYTableViewCornerRadiusStyle)cornerRadiusStyle {
    objc_setAssociatedObject(self, KY_tableViewConerRadiusStyleKey, @(cornerRadiusStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KYTableViewCornerRadiusStyle)cornerRadiusStyle {
    return [objc_getAssociatedObject(self, KY_tableViewConerRadiusStyleKey) integerValue];
}

- (void)setEnableCornerRadiusCell:(BOOL)enableCornerRadiusCell {
    objc_setAssociatedObject(self, KY_tableViewEnableCornerRadiusCellKey, @(enableCornerRadiusCell), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableCornerRadiusCell {
    return [objc_getAssociatedObject(self, KY_tableViewEnableCornerRadiusCellKey) boolValue];
}

- (void)setCornerRadiusMaskInsets:(UIEdgeInsets)cornerRadiusMaskInsets {
    objc_setAssociatedObject(self, KY_tableViewCornerRadiusMaskInserts, [NSValue valueWithUIEdgeInsets:cornerRadiusMaskInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)cornerRadiusMaskInsets {
    return [objc_getAssociatedObject(self, KY_tableViewCornerRadiusMaskInserts) UIEdgeInsetsValue];
}


#pragma mark hook
- (id)KY_createPreparedCellForGlobalRow:(int)globalRow withIndexPath:(id)indexPath willDisplay:(BOOL)p {
    id cell = [self KY_createPreparedCellForGlobalRow:globalRow withIndexPath:indexPath willDisplay:p];
    
    // 获得需要被做圆角化的视图
    if ([self enableCornerRadiusCell] && [cell isKindOfClass:[UIView class]]) {
        [[cell viewForMakeCornerRadius] addRectCorner:[self cornersToRadiusForIndexPath:indexPath] radius:self.cornerRadius insets:self.cornerRadiusMaskInsets];
        
        // important
        [[cell viewForMakeCornerRadius] setNeedsLayout];
    }
    
    return cell;
}

#pragma mark private method

- (UIRectCorner)cornersToRadiusForIndexPath:(NSIndexPath *)indexPath {
    UIRectCorner corner = 0;
    switch ([self cornerRadiusStyle]) {
        case KYTableViewCornerRadiusStyleEveryCell:
            corner = UIRectCornerAllCorners;
            break;
        case KYTableViewCornerRadiusStyleSectionTopAndBottom: {
            NSUInteger countInSection = [self.dataSource tableView:self numberOfRowsInSection:indexPath.section];
            if (countInSection == 1 && indexPath.row == 0) {
                corner = UIRectCornerAllCorners;
            }
            else if (countInSection > 1) {
                
                if (indexPath.row == 0) {
                    corner = UIRectCornerTopLeft|UIRectCornerTopRight;
                }
                else if (indexPath.row == countInSection - 1) {
                    corner = UIRectCornerBottomLeft|UIRectCornerBottomRight;
                }
            }
        }
            break;
        default:
            break;
    }
    return corner;
}

@end
