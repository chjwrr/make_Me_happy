/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "NSString+Valid.h"

@implementation NSString (Valid)
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (BOOL)isEmpty
{
    if (self == nil || self == NULL)
        return YES;
    if ([self isKindOfClass:[NSNull class]])
        return YES;
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
        return YES;
    if ([self isEqualToString:@"(null)"])
        return YES;
    if ([self isEqualToString:@"(null)(null)"])
        return YES;
    if ([self isEqualToString:@"<null>"])
        return YES;
    if ([self isEqualToString:@" "])
        return YES;
    if ([self isEqualToString:@""])
        return YES;
return NO;
}
- (BOOL)isMobilePhone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700
     22         */
    NSString * CT = @"^1((33|53|8[019]|7[678])\\d|349|700)\\d{7}$";
    
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    if (([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)
        || ([regextestphs evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isEmail
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
- (NSString *)fromatterHasEmojiString {
    
    
    //NSString *unicodeStr=@"你好\\ud83d\\ude0a逗比";
    
    
    //unicode
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return returnStr;
}

- (NSMutableAttributedString *)getAttributeStringWithFont:(NSInteger)font WithRange:(NSRange)range {
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:self];
    
    [attString setAttributes:@{NSFontAttributeName:kSYS_FONT(font),NSForegroundColorAttributeName:[UIColor whiteColor]} range:range];
    
    
    return attString;
}
- (NSMutableAttributedString *)setStringRangeColor:(UIColor *)color Range:(NSRange)range{
    NSMutableAttributedString *attS=[[NSMutableAttributedString alloc]initWithString:self];
    [attS addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:kSYS_FONT(17)} range:range];
    
    return attS;
}



- (NSString *)formatterTime{
    //1462848371
    
    NSTimeInterval late=self.doubleValue;
 
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    if (cha/3600 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num= [timeString intValue];
        
        if (num <= 1) {
            
            timeString = [NSString stringWithFormat:@"刚刚"];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
            
        }
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
        
    }
    
    if (cha/86400 > 1)
        
    {
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            
            timeString = [NSString stringWithFormat:@"昨天"];
            
        }else if(num == 2){
            
            timeString = [NSString stringWithFormat:@"前天"];
            
        }else if (num > 2 && num <7){
            
            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            
        }else if (num >= 7 && num <= 10) {
            
            timeString = [NSString stringWithFormat:@"1周前"];
            
        }else if(num > 10){
            
            //timeString = [UserLanguageManager loadTextforKey:@"n_tian_qian"];
            NSDate *showdate=[NSDate dateWithTimeIntervalSince1970:late];
            
            NSDateFormatter *matter=[[NSDateFormatter alloc]init];
            [matter setDateFormat:@"yyyy-MM-dd"];
            
            timeString=[matter stringFromDate:showdate];
            
        }
        
    }
    
    return timeString;

}


/**
 * 初始化时间
 *
 *  @param second 秒数
 *
 *  @return 返回  00：00：00 类型字符串
 */
+ (NSString *)formatDateWithSecond:(int)second
{
    if(!second || second<=0){
        return @"00:00";
    }
    int hour = second/(60*60);
    int minute = (second-(60*60)*hour)/60;
    second -= (60*60)*hour+minute*60;
    
    if(hour!=0){
        return [NSString stringWithFormat:@"%02i:%02i:%02i", hour, minute, second];
    }else{
        return [NSString stringWithFormat:@"%02i:%02i", minute, second];
    }
    return @"";
}


/**
 *  初始化时间
 *
 *  @return 返回秒数
 */
- (int)formatDateToSecond {
    
    //00:00:00
    NSArray *array=[self componentsSeparatedByString:@":"];
    if ([array count] == 3) {
        //时分秒
        //1.时转秒
        int hour=kFormatterSring([array objectAtIndex:0]).intValue;
        
        int hourSecond=hour*60*60;
        
        //2.分转秒
        int minutes=kFormatterSring([array objectAtIndex:1]).intValue;
        
        int minutesSecond=minutes*60;
        
        //秒
        int second=kFormatterSring([array objectAtIndex:2]).intValue;
        
        return hourSecond+minutesSecond+second;
    }else if ([array count] == 2){
        //分秒
        //1.分转秒
        int minutes=kFormatterSring([array objectAtIndex:0]).intValue;
        
        int minutesSecond=minutes*60;
        
        //2.秒
        int second=kFormatterSring([array objectAtIndex:1]).intValue;
        
        return minutesSecond+second;
    }
    
    
    return 1;
}


/**
 *  格式时间戳
 *
 *  @param timeInterval 传递一个时间戳对象
 *
 *  @return 返回格式化后的时间  yyyy-MM-dd
 */
+ (NSString *)getDataStringFromeTimeInterval:(double)timeInterval {
    
    NSDate *showdate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *matter=[[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy-MM-dd hh:MM"];
    
    return [matter stringFromDate:showdate];

}

@end
