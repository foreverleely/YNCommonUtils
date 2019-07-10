//
//  NSString+YNOrder.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/10.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSString+YNOrder.h"

@implementation NSString (YNOrder)

+ (NSString *)yn_getRandomLetterStringWithCount:(NSInteger)count {
    
    NSArray *allChars = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
    
    NSMutableString *tmpStr = [NSMutableString new];
    for (int i=0; i<count; i++) {
        
        [tmpStr appendString:allChars[arc4random()%allChars.count]];
    }
    
    return tmpStr;
}

@end
