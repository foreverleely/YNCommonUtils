//
//  YNCAVPlayerManager.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/11.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNCAVPlayerManager : NSObject

@property (nonatomic, strong, readonly) AVPlayerItem *playerItem;
@property (nonatomic, strong, readonly) AVPlayerLayer *playLayer;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, copy) void(^videoEndBlock)(void);

/*******/
- (instancetype)initWithFilePath:(NSString *)filePath andFrame:(CGRect)frame;

- (void)play;

- (void)pause;

- (void)seekToTime:(CMTime)time;

- (void)releaseMemoryWithDeep:(BOOL)isDeep;

- (UIImage *)getVideoCurrentFrame;

@end

NS_ASSUME_NONNULL_END
