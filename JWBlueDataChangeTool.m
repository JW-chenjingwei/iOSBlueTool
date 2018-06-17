//
//  JWBlueDataChangeTool.m
//  SmartAudio
//
//  Created by 陈经纬 on 2018/4/8.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "JWBlueDataChangeTool.h"

@implementation JWBlueDataChangeTool



 /**
   将传入的NSData类型转换成NSString并返回
  */

+ (NSString*)hexadecimalString:(NSData *)data
{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}

/**
 将传入的NSString（10进制）类型转换成NSData并返回(格式: xxxxxxxx)
 */
+ (NSData*)dataWithIntString:(NSString *)intString{
    
    NSMutableData *data = [NSMutableData data];
    
    int idx;
    for(idx = 0; idx + 2 <= intString.length; idx += 2){
        NSRange range = NSMakeRange(idx, 2);
        NSInteger i = [intString substringWithRange:range].integerValue;
        
        NSData *tempData = [FGDataChangeTool dataWithInt:i andLength:1];
        [data appendData:tempData];
    }
    return data;
    
}

/**
 将传入的NSString（16进制）类型转换成NSData并返回(格式: xxxxxxxx)
 */
+ (NSData*)dataWithHexstring:(NSString *)hexstring
{
    NSMutableData *data = [NSMutableData data];
    
    int idx;
    for(idx = 0; idx + 2 <= hexstring.length; idx += 2){
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [hexstring substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}



/**
 字符串以ASCII编码格式解码
 
 @param ASCIIString 45312e30
 @return 字符串
 */
+ (NSString *)stringWithASCII:(NSString *)ASCIIString{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i + 2 <= (ASCIIString.length) ; i +=2 ) {
        NSString *subStr = [ASCIIString substringWithRange:NSMakeRange(i, 2)];
        
        NSString *ascc = NSStringFormat(@"%c",[FGDataChangeTool numberWithHexString:subStr]);
        [str appendString:ascc];
    }
    
    return str;
}

/**
 删除字符串里面的某个字符
 
 @param string <#string description#>
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)deleteString:(NSString *)string withDeletStr:(NSString *)str{
    NSMutableString *dataStr = [NSMutableString string];
    NSArray *arry = [string componentsSeparatedByString:str];
    for (int i = 0; i<arry.count; i++) {
        NSString *str = arry[i];
        [dataStr appendString:str];
    }
    
    return dataStr;
}

+ (NSData *)dataWithInt:(NSInteger)integer andLength:(int)len{
    
    Byte abyte[len];
    
    if (len == 1) {
        
        abyte[0] = (Byte) (0xff & integer);
        
    } else if (len == 2) {
        
        abyte[0] = (Byte) ((0xff00 & integer) >> 8);
        
        abyte[1] = (Byte) (0xff & integer);
        
        
        
    } else {
        
        abyte[0] = (Byte) ((0xff000000 & integer) >> 24);
        
        abyte[1] = (Byte) ((0xff0000 & integer) >> 16);
        
        abyte[2] = (Byte) ((0xff00 & integer) >> 8);
        
        abyte[3] = (Byte) (0xff & integer);
    }
    
    NSData *adata = [NSData dataWithBytes:abyte length:len];
    return adata;
    
}

#pragma mark - 进制转化

/**
 十六进制转十进制
 */
+ (NSInteger)numberWithHexString:(NSString *)hexString{
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSInteger hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return hexNumber;
}

/**二进制转十进制*/
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}



//将十进制转化为十六进制
+ (NSString *)ToHex:(int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"a";break;
            case 11:
                nLetterValue =@"b";break;
            case 12:
                nLetterValue =@"c";break;
            case 13:
                nLetterValue =@"d";break;
            case 14:
                nLetterValue =@"e";break;
            case 15:
                nLetterValue =@"f";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}


@end
