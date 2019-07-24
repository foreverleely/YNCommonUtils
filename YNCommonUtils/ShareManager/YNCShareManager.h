//
//  YNCShareManager.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/24.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YNCShareManagerType)
{
    YNCShareManagerTypeTwitter = 0,
    YNCShareManagerTypeFacebook,
    YNCShareManagerTypeMessage,
    YNCShareManagerTypeMore
};

NS_ASSUME_NONNULL_BEGIN

@interface YNCShareManager : NSObject

+ (YNCShareManager *)share;

- (void)shareToTwWithVc:(UIViewController *)viewController
                PopView:(UIView *)view
                  Point:(CGPoint)point
              ShareText:(NSString *)shareText
            ShareUrlStr:(NSString *)shareUrlStr;

- (void)shareToFBWithVc:(UIViewController *)viewController
                PopView:(UIView *)view
                  Point:(CGPoint)point
              ShareText:(NSString *)shareText
            ShareUrlStr:(NSString *)shareUrlStr;

- (void)shareToMsgWithVc:(UIViewController *)viewController
                 PopView:(UIView *)view
                   Point:(CGPoint)point
               ShareText:(NSString *)shareText
             ShareUrlStr:(NSString *)shareUrlStr;

- (void)shareMoreWithVc:(UIViewController *)viewController
                PopView:(UIView *)view
                  Point:(CGPoint)point
              ShareText:(NSString *)shareText
            ShareUrlStr:(NSString *)shareUrlStr;

- (void)shareImage:(UIImage *)image
                vc:(UIViewController *)viewController
             point:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
