//
//  NSString+YNEncrypt.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YNEncrypt)

- (NSString *)yn_base64EncodedString;

- (NSString *)yn_base64DecodedString;

@end

NS_ASSUME_NONNULL_END
