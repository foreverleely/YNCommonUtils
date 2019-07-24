//
//  UIView+YNCDash.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/24.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "UIView+YNCDash.h"

@implementation UIView (YNCDash)

- (void)drawDashLineLength:(int)lineLength
               lineSpacing:(int)lineSpacing
                 lineColor:(UIColor *)lineColor
                directType:(YNCDashDirectionType)directionType
{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    switch (directionType) {
        case YNCDashDirectionTypeRow:
            [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
            break;
        case YNCDashDirectionTypeColumn:
            [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2)];
            break;
        default:
            break;
    }
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    switch (directionType) {
        case YNCDashDirectionTypeRow:
            [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
            break;
        case YNCDashDirectionTypeColumn:
            [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
            break;
        default:
            break;
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    switch (directionType) {
        case YNCDashDirectionTypeRow:
            CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
            break;
        case YNCDashDirectionTypeColumn:
            CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
            break;
        default:
            break;
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)drawDashWithPosType:(YNCDashPositionType)positionType
                 lineLength:(int)lineLength
                lineSpacing:(int)lineSpacing
                  lineColor:(UIColor *)lineColor
{
    
    if (self.frame.size.width == 1) {
        [self drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeColumn];
    } else if (self.frame.size.height == 1) {
        [self drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeRow];
    } else {
        
        switch (positionType) {
            case YNCDashPositionTypeLeftTop:
            {
                UIView *leftView = [UIView new];
                leftView.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
                [self addSubview:leftView];
                [leftView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeColumn];
                
                UIView *topView = [UIView new];
                topView.frame = CGRectMake(1, 0, CGRectGetWidth(self.frame) - 1, 1);
                [self addSubview:topView];
                [topView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeRow];
            }
                break;
            case YNCDashPositionTypeRightTop:
            {
                UIView *rightView = [UIView new];
                rightView.frame = CGRectMake(CGRectGetWidth(self.frame) - 1, 0, 1, CGRectGetHeight(self.frame));
                [self addSubview:rightView];
                [rightView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeColumn];
                
                UIView *topView = [UIView new];
                topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) - 1, 1);
                [self addSubview:topView];
                [topView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeRow];
            }
                break;
            case YNCDashPositionTypeLeftBottom:
            {
                UIView *leftView = [UIView new];
                leftView.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
                [self addSubview:leftView];
                [leftView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeColumn];
                
                UIView *bottomView = [UIView new];
                bottomView.frame = CGRectMake(1, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame) - 1, 1);
                [self addSubview:bottomView];
                [bottomView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeRow];
            }
                break;
            case YNCDashPositionTypeRightBottom:
            {
                UIView *rightView = [UIView new];
                rightView.frame = CGRectMake(CGRectGetWidth(self.frame) - 1, 0, 1, CGRectGetHeight(self.frame));
                [self addSubview:rightView];
                [rightView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeColumn];
                
                UIView *bottomView = [UIView new];
                bottomView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame) - 1, 1);
                [self addSubview:bottomView];
                [bottomView drawDashLineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor directType:YNCDashDirectionTypeRow];
            }
                break;
            default:
                break;
        }
    }
    
}

@end
