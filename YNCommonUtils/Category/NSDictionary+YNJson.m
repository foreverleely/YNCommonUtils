//
//  NSDictionary+YNJson.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSDictionary+YNJson.h"

@implementation NSDictionary (YNJson)

- (NSString *)yn_toJsonString {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] == 0 || error != nil) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
