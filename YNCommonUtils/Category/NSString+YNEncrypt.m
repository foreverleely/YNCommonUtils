//
//  NSString+YNEncrypt.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSString+YNEncrypt.h"

@implementation NSString (YNEncrypt)

- (NSString *)yn_base64EncodedString {
    
    NSData *dataToEncode = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodedData = [dataToEncode base64EncodedDataWithOptions:0];
    NSString *encodedString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    
    return encodedString;
}


- (NSString *)yn_base64DecodedString {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
