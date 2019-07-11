//
//  YNCAVPlayerManager.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/11.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "YNCAVPlayerManager.h"

@interface YNCAVPlayerManager ()

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playLayer;

@end

@implementation YNCAVPlayerManager

- (instancetype)initWithFilePath:(NSString *)filePath andFrame:(CGRect)frame
{
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    if (asset) {
        self.playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
        // add notific
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ync_PlayerPlaybackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        // set AVPlayerLayer
        self.frame = frame;
        return self;
    }
    
    return nil;
}

- (void)play {
    if (_player) {
        [self.player play];
    }
}

- (void)pause {
    if (_player) {
        [self.player pause];
    }
}

- (void)seekToTime:(CMTime)time {
    if (_player) {
        [_player seekToTime:time];
    }
}

- (void)releaseMemoryWithDeep:(BOOL)isDeep {
    [self pause];
    // release AVPlayer memory
    if (_player && _player.currentItem) {
        [_player.currentItem cancelPendingSeeks];
        [_player.currentItem.asset cancelLoading];
    }
    if (isDeep) {
        if (_playLayer) {
            [_playLayer removeFromSuperlayer];
            _playLayer = nil;
        }
        _player = nil;
    }
}

- (UIImage *)getVideoCurrentFrame {
    
    if (_player.currentItem && _player.currentItem.asset) {
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:_player.currentItem.asset];
        assetGen.appliesPreferredTrackTransform = YES;
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [assetGen copyCGImageAtTime:_player.currentItem.currentTime actualTime:&actualTime error:&error];
        UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        return videoImage;
    }
    return nil;
}

#pragma mark - KVO

- (void)ync_PlayerPlaybackFinished:(NSNotification *)notification {
    
    if (self.videoEndBlock) {
        self.videoEndBlock();
    } else {
        [self.player seekToTime:CMTimeMake(0, 1)];
        [self.player play];
    }
}

#pragma mark - Setters

- (void)setFrame:(CGRect)frame {
    
    if (_playLayer) {
        _playLayer.frame = frame;
    } else if (_player) {
        self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playLayer.frame = frame;
    }
}

@end
