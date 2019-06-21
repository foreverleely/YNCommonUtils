//
//  NSArray+YNOrder.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YNOrder)

+ (NSArray *)getOutOfOrderArray:(NSArray *)array
                      withCount:(int)getCount;

@end

NS_ASSUME_NONNULL_END
