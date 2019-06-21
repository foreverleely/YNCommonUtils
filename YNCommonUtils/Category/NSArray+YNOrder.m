//
//  NSArray+YNOrder.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSArray+YNOrder.h"

@implementation NSArray (YNOrder)

+ (NSArray *)getOutOfOrderArray:(NSArray *)array
                      withCount:(int)getCount {
    
    NSMutableArray * mutArray = [[NSMutableArray alloc] initWithArray:array];
    NSMutableArray *mutArr = [NSMutableArray new];
    for (int i = 0; i < getCount; i ++) {
        int t = arc4random() % mutArray.count;
        mutArr[i] = mutArray[t];
        mutArray[t] = [mutArray lastObject];
        [mutArray removeLastObject];
    }
    return mutArr;
}

@end
