//
//  YNCAudioPlayerManager.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/11.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNCAudioPlayerManager : NSObject

+ (YNCAudioPlayerManager *)share;

- (void)playAudioWithUrl:(NSString *)fileUrl;
- (void)playAudioWithData:(NSData *)musicData;

- (void)continuePlayAudio;
- (void)stopAudio;

- (CGFloat)getCurrent;
- (CGFloat)getDuration;
- (CGFloat)getCurrentProgress;

@end

NS_ASSUME_NONNULL_END
