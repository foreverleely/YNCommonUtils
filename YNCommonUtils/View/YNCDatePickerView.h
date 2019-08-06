//
//  YNCDatePickerView.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNCDatePickerView : UIView

@property (nonatomic, strong) NSDate *curDate;

@property (nonatomic, copy) void (^chooseBirthDate)(NSDate *date);

@property (nonatomic, strong) NSAttributedString *cancelTitle;
@property (nonatomic, strong) NSAttributedString *confirmTitle;

@end

NS_ASSUME_NONNULL_END
