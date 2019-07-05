//
//  NSData+YNEncrypt.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/7/5.
//  Copyright © 2019 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (YNEncrypt)

/**
 *  @brief  字符串base64后转data
 *
 *  @param string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)yn_dataWithBase64EncodedString:(NSString *)string;
/**
 *  @brief  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 *
 *  @return base64后的字符串
 */
- (NSString *)yn_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  @brief  NSData转string 换行长度默认64
 *
 *  @return base64后的字符串
 */
- (NSString *)yn_base64EncodedString;

/**
 *  利用AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)yn_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  @brief  利用AES解密据
 *
 *  @param key key 长度一般为16 （AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)yn_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  利用DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)yn_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  @brief   利用DES解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)yn_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  利用3DES加密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)yn_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)yn_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;


- (NSData *)yn_CCCryptData:(NSData *)data
                 algorithm:(CCAlgorithm)algorithm
                 operation:(CCOperation)operation
                       key:(NSString *)key
                        iv:(NSData *)iv;
/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (NSString *)yn_UTF8String;

@end

NS_ASSUME_NONNULL_END
