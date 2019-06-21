//
//  UIView+YNFlash.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "UIView+YNFlash.h"
#import <objc/runtime.h>

static char YNC_Flash_Layer0;
static char YNC_Flash_Layer1;

@implementation UIView (YNFlash)

- (void)ync_addFlash:(CGSize)size
               color:(UIColor *)color
             isSmall:(BOOL)isSmall
             isShake:(BOOL)shake {
    
    [self ync_removeFlash];
    
    CALayer *layer0 = CALayer.layer;
    layer0.backgroundColor = color.CGColor;
    layer0.anchorPoint = CGPointZero;
    CALayer *layer1 = CALayer.layer;
    layer1.backgroundColor = color.CGColor;
    layer1.anchorPoint = CGPointZero;
    if (isSmall) {
        
        layer0.frame = CGRectMake(-12.f, -1.5f, 3.f, ceil((2.f * size.height + 3.f) / sqrtf(3.f)));
        layer1.frame = CGRectMake(-6.f, -3.f, 6.f, ceil((2.f * size.height + 6.f) / sqrtf(3.f)));
    } else {
        
        layer0.frame = CGRectMake(-24.f, -3.f, 6.f, ceil((2.f * size.height + 6.f) / sqrtf(3.f)));
        layer1.frame = CGRectMake(-12.f, -6.f, 12.f, ceil((2.f * size.height + 12.f) / sqrtf(3.f)));
    }
    layer0.affineTransform = CGAffineTransformMakeRotation(M_PI / 6.f);
    layer1.affineTransform = CGAffineTransformMakeRotation(M_PI / 6.f);
    [self.layer addSublayer:layer0];
    [self.layer addSublayer:layer1];
    objc_setAssociatedObject(self, &YNC_Flash_Layer0, layer0, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &YNC_Flash_Layer1, layer1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.duration = 0.5f;
    animation.fromValue = @(0.f);
    animation.toValue = @(size.width - layer0.frame.origin.x);
    CAAnimationGroup *group = CAAnimationGroup.animation;
    group.duration = 1.f;
    group.beginTime = CACurrentMediaTime();// + 2.f;
    group.animations = @[animation];
    group.repeatCount = HUGE_VALF;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    [layer0 addAnimation:group forKey:@"animation"];
    [layer1 addAnimation:group forKey:@"animation"];
    
    if (!shake) {
        return;
    }
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnimation.keyTimes = @[@(.02f), @(.05f), @(.1f), @(.15f), @(.2f), @(.25f), @(.3f), @(.32f)];
    shakeAnimation.values = @[@(0.f), @(4.f), @(-4.f), @(4.f), @(-4.f), @(4.f), @(-4.f), @(0.f)];
    shakeAnimation.duration = 2.f;
    shakeAnimation.beginTime = group.beginTime;
    shakeAnimation.repeatCount = HUGE_VALF;
    shakeAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:shakeAnimation forKey:@"ly_flash_shake"];
    
}

- (void)ync_removeFlash {
    
    CALayer *layer0 = (CALayer *)objc_getAssociatedObject(self, &YNC_Flash_Layer0);
    if (layer0) {
        
        [layer0 removeAllAnimations];
        [layer0 removeFromSuperlayer];
        objc_setAssociatedObject(self, &YNC_Flash_Layer0, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    CALayer *layer1 = (CALayer *)objc_getAssociatedObject(self, &YNC_Flash_Layer1);
    if (layer1) {
        
        [layer1 removeAllAnimations];
        [layer1 removeFromSuperlayer];
        objc_setAssociatedObject(self, &YNC_Flash_Layer1, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self.layer removeAnimationForKey:@"ly_flash_shake"];
}

@end
