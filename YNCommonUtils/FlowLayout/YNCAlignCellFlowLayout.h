//
//  YNCAlignCellFlowLayout.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YNCAlignType)
{
    YNCAlignWithLeft,
    YNCAlignWithCenter,
    YNCAlignWithRight
};

NS_ASSUME_NONNULL_BEGIN

@interface YNCAlignCellFlowLayout : UICollectionViewFlowLayout

//两个Cell之间的距离
@property (nonatomic, assign) CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic, assign) YNCAlignType cellType;

- (instancetype)initWthType:(YNCAlignType)cellType;

- (instancetype)initWithType:(YNCAlignType) cellType betweenOfCell:(CGFloat)betweenOfCell;

@end

NS_ASSUME_NONNULL_END
