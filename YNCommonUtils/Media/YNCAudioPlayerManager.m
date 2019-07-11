//
//  YNCAudioPlayerManager.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/11.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "YNCAudioPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
// pod
#import "YYCache.h"

#define SBMusicDB @"sleepBetter_music_db"

@interface YNCAudioPlayerManager ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation YNCAudioPlayerManager

+ (YNCAudioPlayerManager *)share {
    static dispatch_once_t onceToken;
    static YNCAudioPlayerManager *share = nil;
    dispatch_once(&onceToken, ^{
        share = [YNCAudioPlayerManager new];
    });
    return share;
}

// remote
- (void)playAudioWithUrl:(NSString *)fileUrl {
    
    if (self.audioPlayer) {
        [self.audioPlayer stop];
        self.audioPlayer = nil;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        YYCache *cache = [YYCache cacheWithName:SBMusicDB];
        NSData *musicData = (NSData *)[cache objectForKey:fileUrl];
        if (!musicData) {
            musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
            [cache setObject:musicData forKey:fileUrl];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!musicData) {
                return;
            }
            [self playAudioWithData:musicData];
        });
    });
    
}

- (void)playAudioWithData:(NSData *)musicData {
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:musicData error:nil];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

- (void)continuePlayAudio {
    if (self.audioPlayer) {
        [self.audioPlayer play];
    }
}

- (void)stopAudio {
    [self stopAudioWithDeep:NO];
}

- (void)stopAudioWithDeep:(BOOL)isDeep {
    if (self.audioPlayer) {
        [self.audioPlayer stop];
        if (isDeep) {
            self.audioPlayer = nil;
        }
    }
}

- (CGFloat)getCurrent {
    
    if (self.audioPlayer) {
        return self.audioPlayer.currentTime;
    }
    return 0.f;
}

- (CGFloat)getDuration {
    
    if (self.audioPlayer) {
        return self.audioPlayer.duration;
    }
    return 0.f;
}

- (CGFloat)getCurrentProgress {
    
    if (self.audioPlayer) {
        NSTimeInterval duration = self.audioPlayer.duration;
        NSTimeInterval current = self.audioPlayer.currentTime;
        return current/duration;
    }
    return 0.f;
}

@end
