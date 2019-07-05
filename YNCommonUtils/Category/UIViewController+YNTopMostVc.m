//
//  UIViewController+YNTopMostVc.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "UIViewController+YNTopMostVc.h"

@implementation UIViewController (YNTopMostVc)

+ (UIViewController *)yn_getTopMostVC {
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *topVC = appRootVC;
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    if (topVC != nil) {
        return topVC;
    }
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end
