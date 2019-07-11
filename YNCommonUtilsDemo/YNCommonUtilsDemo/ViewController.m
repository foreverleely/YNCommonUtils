//
//  ViewController.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "ViewController.h"

#import "YNCAVPlayerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Example For YNCAVPlayer

- (void)addPlayer {
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"test.mp4"];
    
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    YNCAVPlayerManager *player = [[YNCAVPlayerManager alloc] initWithFilePath:filePath andFrame:rect];

    player.videoEndBlock = ^{
        
    };

    [self.view.layer addSublayer:player.playLayer];
    [player play];
}


@end
