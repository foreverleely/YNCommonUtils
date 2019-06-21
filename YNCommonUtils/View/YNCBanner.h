//
//  YNCBanner.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNCBanner : UIView

// 在原数组的基础上，加上数组最后一个作为第一个，加上数组第一个作为最后一个，然后组成新的数组
- (instancetype)initViewWithFrame:(CGRect)frame ViewList:(NSArray *)viewList timeInterval:(CGFloat)timeInterval;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, copy) void (^yn_updatePageIndex)(NSInteger index);

@property (nonatomic, copy) void (^yn_clickPage)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
