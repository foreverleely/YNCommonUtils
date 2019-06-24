//
//  YNPickerView.m
//  
//
//  Created by liyangly on 2018/10/12.
//  Copyright © 2018 makeupopular.com. All rights reserved.
//

#import "YNPickerView.h"
#import "YNCMacroHeader.h"
// pod
#import "Masonry.h"

@interface YNPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *doneBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *resultStr;

@end

@implementation YNPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.viewType = YNPickerViewTypeBottom;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    CGFloat height = 44;
    CGFloat btnWidth = 100;
    
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(self);
        make.width.mas_equalTo(YNC_SCREEN_WIDTH);
        make.height.mas_equalTo(190);
    }];
    
    [self.containerView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.containerView);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.containerView addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.containerView);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(self.cancelBtn.mas_right);
        make.right.mas_equalTo(self.doneBtn.mas_left);
    }];

    [self.containerView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
    }];
}

#pragma mark - UIControl Actions
- (void)hidePicker {
    [self removeFromSuperview];
}

- (void)cancelPick {
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self hidePicker];
}

- (void)donePick {
    if (self.doneAction) {
        self.doneAction(self.resultStr);
    }
    [self hidePicker];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataList.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *list = self.dataList[component];
    return list.count;
}

#pragma mark - PickerDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.resultStr = self.dataList[component][row];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//
////    for(UIView *singleLine in pickerView.subviews){
////        if (singleLine.frame.size.height < 1) {
////            singleLine.backgroundColor = [UIColor clearColor];
////        }
////    }
//
//    UILabel *label = [UILabel new];
//
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = self.dataList[component][row];
//    label.font = [UIFont systemFontOfSize:23.0];
//    label.textColor = [UIColor blackColor];
//
//    return label;
//}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataList[component][row];
}

#pragma mark - Setters
- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    [self.pickerView reloadAllComponents];
}

- (void)setViewType:(YNPickerViewType)viewType {
    _viewType = viewType;
    if (viewType == YNPickerViewTypeCenter) {
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(YNC_SCREEN_WIDTH);
            make.height.mas_equalTo(198);
        }];
    }
}

- (void)setPickViewTitle:(NSString *)pickViewTitle {
    self.titleLabel.text = pickViewTitle;
}

- (void)setDoneBtnTitle:(NSString *)doneBtnTitle {
    [self.doneBtn setTitle:doneBtnTitle forState:UIControlStateNormal];
}

#pragma mark - Getters
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor colorWithRed:247.f/255.f green:247.f/255.f blue:247.f/255.f alpha:1.0];
    }
    return _containerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:0.f/255.f green:122.f/255.f blue:255.f/255.f alpha:1.0] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelPick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Category";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"SFUIDisplay-Medium" size:18];
    }
    return _titleLabel;
}

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor colorWithRed:0.f/255.f green:122.f/255.f blue:255.f/255.f alpha:1.0] forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(donePick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

@end
