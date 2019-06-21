//
//  YNCDatePickerView.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "YNCDatePickerView.h"
#import "YNCMacroHeader.h"
#import "Masonry.h"

@interface YNCDatePickerView ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation YNCDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.frame = CGRectMake(0, 0, YNC_SCREEN_WIDTH, YNC_SCREEN_HEIGHT);
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bgView];
    [bgView addSubview:self.cancelBtn];
    [bgView addSubview:self.confirmBtn];
    [bgView addSubview:self.datePicker];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(YNC_SNAP2(250));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YNC_SNAP2(10));
        make.top.mas_equalTo(YNC_SNAP2(10));
        make.width.mas_equalTo(YNC_SNAP2(100));
        make.height.mas_equalTo(YNC_SNAP2(30));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(YNC_SNAP2(-10));
        make.top.mas_equalTo(YNC_SNAP2(10));
        make.width.mas_equalTo(YNC_SNAP2(100));
        make.height.mas_equalTo(YNC_SNAP2(30));
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(bgView);
        make.top.mas_equalTo(YNC_SNAP2(50));
    }];
}

- (void)cancelBtnClick {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, YNC_SCREEN_HEIGHT, YNC_SCREEN_WIDTH, YNC_SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)confirmBtnClick {
    
    if (self.chooseBirthDate) {
        self.chooseBirthDate(self.datePicker.date);
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, YNC_SCREEN_HEIGHT, YNC_SCREEN_WIDTH, YNC_SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Setters

- (void)setCurDate:(NSDate *)curDate {
    self.datePicker.date = curDate;
//    NSDate *beginDate = [curDate gu_offsetMonths:-12];
//    NSDate *endDate = [curDate gu_offsetMonths:12];
//    self.datePicker.minimumDate = beginDate;
//    self.datePicker.maximumDate = endDate;
}

#pragma mark - Getters

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"Cancel" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(8, 25, 6), NSFontAttributeName:YNFontKrungthep(YN_SNAP2(14))}];
//        [_cancelBtn setAttributedTitle:attr forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"Confirm" attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(8, 25, 6), NSFontAttributeName:YNFontKrungthep(YN_SNAP2(14))}];
//        [_confirmBtn setAttributedTitle:attr forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Confirm" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

@end
