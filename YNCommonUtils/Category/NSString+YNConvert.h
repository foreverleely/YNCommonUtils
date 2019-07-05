//
//  NSString+YNConvert.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YNConvert)

- (NSDictionary *)yn_toDictionary;

- (BOOL)yn_isPureNum;

@end

NS_ASSUME_NONNULL_END
