//
//  UIView+Radius.m
//  Kira
//
//  Created by YamatoKira on 16/2/15.
//  Copyright © 2016年 Kira. All rights reserved.
//

#import "UIView+Radius.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"

@interface KY_cornerRadiusModel : NSObject

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) UIRectCorner corners;

@property (nonatomic, assign) UIEdgeInsets inserts;

@end

@implementation KY_cornerRadiusModel

+ (instancetype)modelWithRadius:(CGFloat)radius corners:(UIRectCorner)corners insets:(UIEdgeInsets)inserts {
    KY_cornerRadiusModel *model = [[KY_cornerRadiusModel alloc] init];
    model.corners = corners;
    model.radius = radius;
    model.inserts = inserts;
    return model;
}

@end

static void *KY_cornerRadiusMaskKey = &KY_cornerRadiusMaskKey;


@implementation UIView (Radius)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleOriginalSelector:@selector(layoutSubviews) swizzleSelector:@selector(KY_layoutSubviews) isInstanceSelector:YES];
    });
}

- (void)addRectCorner:(UIRectCorner)corners radius:(CGFloat)radius {
    [self addRectCorner:corners radius:radius insets:UIEdgeInsetsZero];
}


- (void)addRectCorner:(UIRectCorner)corners radius:(CGFloat)radius insets:(UIEdgeInsets)inserts {
    // 如果是这两个情况则直接移除圆角化
    if ((corners == 0 || radius <= 0) && UIEdgeInsetsEqualToEdgeInsets(inserts, UIEdgeInsetsZero)) {
        [self removeCornerRadius];
        return;
    }
    
    KY_cornerRadiusModel *oldModel = [self KY_cornerRadius];
    
    // 判断是否跟旧的圆角化数据一样
    if (oldModel.corners == corners && oldModel.radius == radius && UIEdgeInsetsEqualToEdgeInsets(oldModel.inserts, inserts)) return;
    
    KY_cornerRadiusModel *model = [KY_cornerRadiusModel modelWithRadius:radius corners:corners insets:inserts];
    
    objc_setAssociatedObject(self, KY_cornerRadiusMaskKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self updateCornerMaskLayer];
}

- (void)removeCornerRadius {
    [self viewForMakeCornerRadius].layer.mask = nil;
    
    objc_setAssociatedObject(self, KY_cornerRadiusMaskKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self updateCornerMaskLayer];
}

- (KY_cornerRadiusModel *)KY_cornerRadius {
    return objc_getAssociatedObject(self, KY_cornerRadiusMaskKey);
}

- (void)KY_layoutSubviews {
    [self KY_layoutSubviews];
    
    KY_cornerRadiusModel *cornerModel = [self KY_cornerRadius];
    if (cornerModel != nil) {
        [self updateCornerMaskLayer];
    }
}

- (CAShapeLayer *)maskLayerForModel:(KY_cornerRadiusModel *)model {
    if (model == nil) return nil;
    
    CGRect bounds = self.bounds;
    
    bounds.size.width -= model.inserts.left + model.inserts.right;
    bounds.size.height -= model.inserts.top + model.inserts.bottom;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:model.corners cornerRadii:CGSizeMake(model.radius, model.radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(model.inserts.left, model.inserts.top, bounds.size.width, bounds.size.height);
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

- (void)updateCornerMaskLayer {
    self.layer.mask = [self maskLayerForModel:[self KY_cornerRadius]];
}

- (UIView *)viewForMakeCornerRadius {
    return self;
}

@end
