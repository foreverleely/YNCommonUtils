//
//  UIView+YNFlash.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YNFlash)

- (void)ync_addFlash:(CGSize)size
               color:(UIColor *)color
             isSmall:(BOOL)isSmall
             isShake:(BOOL)shake;

- (void)ync_removeFlash;

@end

NS_ASSUME_NONNULL_END
