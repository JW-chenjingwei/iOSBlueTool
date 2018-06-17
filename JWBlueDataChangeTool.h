//
//  JWBlueDataChangeTool.h
//  SmartAudio
//
//  Created by 陈经纬 on 2018/4/8.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBlueDataChangeTool : NSObject

/**
 将传入的NSData类型转换成NSString并返回
 eg：收到的数据：<01d4d4d4 01d4d4d4 3d3d3d>
     需要转成 01d4d4d401d4d4d43d3d3d
 */
+ (NSString*)hexadecimalString:(NSData *)data;

/**
 
 将传入的NSString（10进制）类型转换成NSData并返回(格式: xxxxxxxx)
 eg：将数字64 转为两位的NSData格式 00 40
NSData *data = [JWBlueDataChangeTool dataWithInt:64 andLength:2];
 
 */
+ (NSData *)dataWithInt:(NSInteger)integer andLength:(int)len;



/**
 将传入的NSString（16进制）类型转换成NSData并返回(格式: xxxxxxxx)
 */
+ (NSData*)dataWithHexstring:(NSString *)hexstring;

/**
 将传入的NSString（10进制）类型转换成NSData并返回(格式: xxxxxxxx)
 */
+ (NSData*)dataWithIntString:(NSString *)intString;



/**
 字符串以ASCII编码格式解码

 @param ASCIIString 45312e30
 @return 字符串
 */
+ (NSString *)stringWithASCII:(NSString *)ASCIIString;


/**
 删除字符串里面的某个字符

 @param string <#string description#>
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)deleteString:(NSString *)string withDeletStr:(NSString *)str;

#pragma mark - 进制转化
/**
 十六进制转十进制字符串
 */
+ (NSInteger )numberWithHexString:(NSString *)hexString;

/**二进制转十进制*/
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

/*将十进制转化为十六进制*/
+ (NSString *)ToHex:(int)tmpid;

@end
