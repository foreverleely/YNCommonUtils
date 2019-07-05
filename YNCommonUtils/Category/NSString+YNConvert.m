//
//  NSString+YNConvert.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSString+YNConvert.h"

@implementation NSString (YNConvert)

- (NSDictionary *)yn_toDictionary {
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    return dictionary;
}

- (BOOL)yn_isPureNum {
    
    NSString *currentStr = self;
    
    if (currentStr==0) {
        return NO;
    }
    currentStr = [currentStr stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(currentStr.length > 0) {
        return NO;
    }
    return YES;
}

@end
