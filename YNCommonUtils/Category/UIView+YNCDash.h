//
//  UIView+YNCDash.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/24.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YNCDashDirectionType)
{
    YNCDashDirectionTypeRow = 0,
    YNCDashDirectionTypeColumn
};

typedef NS_ENUM(NSInteger, YNCDashPositionType)
{
    YNCDashPositionTypeLeftTop = 0,
    YNCDashPositionTypeRightTop,
    YNCDashPositionTypeLeftBottom,
    YNCDashPositionTypeRightBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YNCDash)

@end

NS_ASSUME_NONNULL_END
