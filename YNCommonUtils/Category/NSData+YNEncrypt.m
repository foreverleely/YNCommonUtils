//
//  NSData+YNEncrypt.m
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import "NSData+YNEncrypt.h"
#pragma GCC diagnostic ignored "-Wselector"
#import <Availability.h>

@implementation NSData (YNEncrypt)

/**
 *  @brief  字符串base64后转data
 *
 *  @param string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)yn_dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    NSData *decoded = nil;
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
#pragma clang diagnostic pop
    }
    else
#endif
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    return [decoded length]? decoded: nil;
}
/**
 *  @brief  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 *
 *  @return base64后的字符串
 */
- (NSString *)yn_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    NSString *encoded = nil;
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        encoded = [self base64Encoding];
#pragma clang diagnostic pop
        
    }
    else
#endif
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    return result;
}
/**
 *  @brief  NSData转string 换行长度默认64
 *
 *  @return base64后的字符串
 */
- (NSString *)yn_base64EncodedString
{
    return [self yn_base64EncodedStringWithWrapWidth:0];
}

static void yn_FixKeyLengths(CCAlgorithm algorithm, NSMutableData * keyData, NSMutableData * ivData)
{
    NSUInteger keyLength = [keyData length];
    switch ( algorithm )
    {
        case kCCAlgorithmAES128:
        {
            if (keyLength <= 16)
            {
                [keyData setLength:16];
            }
            else if (keyLength>16 && keyLength <= 24)
            {
                [keyData setLength:24];
            }
            else
            {
                [keyData setLength:32];
            }
            
            break;
        }
            
        case kCCAlgorithmDES:
        {
            [keyData setLength:8];
            break;
        }
            
        case kCCAlgorithm3DES:
        {
            [keyData setLength:24];
            break;
        }
            
        case kCCAlgorithmCAST:
        {
            if (keyLength <5)
            {
                [keyData setLength:5];
            }
            else if ( keyLength > 16)
            {
                [keyData setLength:16];
            }
            
            break;
        }
            
        case kCCAlgorithmRC4:
        {
            if ( keyLength > 512)
                [keyData setLength:512];
            break;
        }
            
        default:
            break;
    }
    
    [ivData setLength:[keyData length]];
}

/**
 *  利用AES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData*)yn_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self yn_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCEncrypt key:key iv:iv];
}
/**
 *  @brief  利用AES解密据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData*)yn_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self yn_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCDecrypt key:key iv:iv];
}
/**
 *  利用3DES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData*)yn_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self yn_CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCEncrypt key:key iv:iv];
}
/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData*)yn_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self yn_CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCDecrypt key:key iv:iv];
}

/**
 *  利用DES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)yn_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self yn_CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCEncrypt key:key iv:iv];
}
/**
 *  @brief   利用DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)yn_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv{
    return [self yn_CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCDecrypt key:key iv:iv];
}
- (NSData *)yn_CCCryptData:(NSData *)data
                 algorithm:(CCAlgorithm)algorithm
                 operation:(CCOperation)operation
                       key:(NSString *)key
                        iv:(NSData *)iv {
    NSMutableData *keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    NSMutableData *ivData = [iv mutableCopy];
    
    size_t dataMoved;
    
    int size = 0;
    if (algorithm == kCCAlgorithmAES128 ||algorithm == kCCAlgorithmAES) {
        size = kCCBlockSizeAES128;
    }else if (algorithm == kCCAlgorithmDES) {
        size = kCCBlockSizeDES;
    }else if (algorithm == kCCAlgorithm3DES) {
        size = kCCBlockSize3DES;
    }if (algorithm == kCCAlgorithmCAST) {
        size = kCCBlockSizeCAST;
    }
    
    NSMutableData *decryptedData = [NSMutableData dataWithLength:data.length + size];
    
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    if (iv) {
        option = kCCOptionPKCS7Padding;
    }
    yn_FixKeyLengths(algorithm, keyData,ivData);
    CCCryptorStatus result = CCCrypt(operation,                    // kCCEncrypt or kCCDecrypt
                                     algorithm,
                                     option,                        // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     data.bytes,
                                     data.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}
/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (NSString *)yn_UTF8String {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
