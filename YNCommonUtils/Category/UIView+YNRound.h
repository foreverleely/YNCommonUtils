//
//  UIView+YNRound.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YNRound)

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
