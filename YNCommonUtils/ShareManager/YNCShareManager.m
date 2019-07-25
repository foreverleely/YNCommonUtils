//
//  YNCShareManager.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/24.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "YNCShareManager.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface YNCShareManager ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) UIViewController *vc;

@end

@implementation YNCShareManager

+ (YNCShareManager *)share {
    
    static dispatch_once_t onceToken;
    static YNCShareManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [YNCShareManager new];
    });
    return instance;
}

- (void)shareToTwWithVc:(UIViewController *)viewController
                PopView:(UIView *)view
                  Point:(CGPoint)point
              ShareText:(NSString *)shareText
            ShareUrlStr:(NSString *)shareUrlStr {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://app"]]) {
        
        [self shareWithType:YNCShareManagerTypeTwitter vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:@[]];
    } else {
        
        [self shareWithType:YNCShareManagerTypeMore vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:@[]];
    }
    
}

- (void)shareToFBWithVc:(UIViewController *)viewController
                PopView:(UIView *)view
                  Point:(CGPoint)point
              ShareText:(NSString *)shareText
            ShareUrlStr:(NSString *)shareUrlStr {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://app"]]) {
        
        [self shareWithType:YNCShareManagerTypeFacebook vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:@[]];
    } else {
        
        [self shareWithType:YNCShareManagerTypeMore vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:@[]];
    }
    
}

- (void)shareToMsgWithVc:(UIViewController *)viewController
                 PopView:(UIView *)view
                   Point:(CGPoint)point
               ShareText:(NSString *)shareText
             ShareUrlStr:(NSString *)shareUrlStr {
    
    [self shareWithType:YNCShareManagerTypeMessage vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:@[]];
}

- (void)shareToMailWithVc:(UIViewController *)viewController
                  PopView:(UIView *)view
                    Point:(CGPoint)point
                ShareText:(NSString *)shareText
              ShareUrlStr:(NSString *)shareUrlStr
         mailToRecipients:(NSArray *)mailToRecipients {
    
    [self shareWithType:YNCShareManagerTypeMessage vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:mailToRecipients];
}

- (void)shareMoreWithVc:(UIViewController *)viewController
                PopView:(UIView *)view
                  Point:(CGPoint)point
              ShareText:(NSString *)shareText
            ShareUrlStr:(NSString *)shareUrlStr {
    
    [self shareWithType:YNCShareManagerTypeMore vc:viewController popView:view point:point shareText:shareText shareUrlStr:shareUrlStr mailToRecipients:@[]];
}

/**
 share
 
 @param shareType share type
 @param viewController vc
 @param view sourceView
 @param point sourceRect
 @param shareText share text
 @param shareUrlStr share url
 */
- (void)shareWithType:(YNCShareManagerType)shareType
                   vc:(UIViewController *)viewController
              popView:(UIView *)view
                point:(CGPoint)point
            shareText:(NSString *)shareText
          shareUrlStr:(NSString *)shareUrlStr
     mailToRecipients:(NSArray *)mailToRecipients {
    
    switch (shareType) {
        case YNCShareManagerTypeTwitter:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://app"]]) {
                
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = [NSString stringWithFormat:@"%@\n\n%@", shareText, shareUrlStr];
                
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://app"] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@YES} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://app"]];
                }
                
            }
        }
            break;
        case YNCShareManagerTypeFacebook:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://app"]]) {
                
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = [NSString stringWithFormat:@"%@\n\n%@", shareText, shareUrlStr];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://app"] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@YES} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://app"]];
                }
                
            }
        }
            break;
        case YNCShareManagerTypeMessage:
        {
            if (![MFMessageComposeViewController canSendText]) {
                return;
            }
            MFMessageComposeViewController *msgVc = [[MFMessageComposeViewController alloc] init];
            msgVc.messageComposeDelegate = self;
            self.vc = viewController;
            [msgVc setBody:[NSString stringWithFormat:@"%@\n\n%@", shareText, shareUrlStr]];
            [viewController presentViewController:msgVc animated:YES completion:nil];
        }
            break;
        case YNCShareManagerTypeMail:
        {
            if (![MFMailComposeViewController canSendMail]) {
                return;
            }
            MFMailComposeViewController *mailVc = [[MFMailComposeViewController alloc] init];
            mailVc.mailComposeDelegate = self;
            self.vc = viewController;
            [mailVc setSubject:shareText];
            [mailVc setToRecipients:mailToRecipients];
            [mailVc setMessageBody:shareUrlStr isHTML:NO];
            [viewController presentViewController:mailVc animated:YES completion:nil];
        }
            break;
        case YNCShareManagerTypeMore:
        {
            NSURL *shareUrl = [NSURL URLWithString:shareUrlStr];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[shareText, shareUrl] applicationActivities:nil];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [viewController presentViewController:activityVC animated:YES completion:nil];
            } else {
                UIPopoverPresentationController *presentVC = activityVC.popoverPresentationController;
                presentVC.sourceView = viewController.view;
                presentVC.sourceRect = CGRectMake(point.x, point.y, 0, 0);
                presentVC.permittedArrowDirections = UIPopoverArrowDirectionDown;
                [viewController presentViewController:activityVC animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Share Image

- (void)shareImage:(UIImage *)image
                vc:(UIViewController *)viewController
             point:(CGPoint)point {
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [viewController presentViewController:activityVC animated:YES completion:nil];
    } else {
        UIPopoverPresentationController *presentVC = activityVC.popoverPresentationController;
        presentVC.sourceView = viewController.view;
        presentVC.sourceRect = CGRectMake(point.x, point.y, 0, 0);
        presentVC.permittedArrowDirections = UIPopoverArrowDirectionDown;
        [viewController presentViewController:activityVC animated:YES completion:nil];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    if (self.vc) {
        [self.vc dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
}

@end
