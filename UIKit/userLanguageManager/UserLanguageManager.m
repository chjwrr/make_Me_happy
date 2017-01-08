//
//  UserLanguageManager.m
//  程序内切换语言
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import "UserLanguageManager.h"

@implementation UserLanguageManager

static NSBundle *bundle=nil;


//创建静态变量bundle，以及获取方法bundle（注：此处不要使用getBundle）。
+ (NSBundle *)bundle {
    return bundle;
}


//userLanguage储存在NSUserDefaults中，首次加载时要检测是否存在，如果不存在的话读AppleLanguages，并赋值给userLanguage。
+ (void)initUserLanguage {
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    //NSString *userLanguage=[def valueForKey:@"userLanguage"];
    
    
    if ([kFormatterSring(kgetDefaultValueForKey(kUserlanguage)) isEmpty]) {
        
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray *languages=[def objectForKey:@"AppleLanguages"];
        
        NSString *current=[languages objectAtIndex:0];
        
        
        //本地语言code
        NSArray *citiesCode=[[NSArray alloc]initWithObjects:@"zh-Hans",
                             @"en",
                             @"ja",
                             @"fr",
                             @"de",
                             @"ko",
                             @"es",
                             @"pt",
                             @"ru",
                             @"ar",
                             @"it",
                             @"fi",
                             @"th",
                             @"nl",
                             @"nb",
                             @"ms",
                             @"sv", nil];
        
        
        if([current isEmpty]){
            
            //设置语言
            [UserLanguageManager setUserLanguage:@"en"];
            
            
            
            //获取文件路径
            //我们使用 Xcode 创建一个新项目，会自动创建一个 en.lproj 目录，这个目录下存放的就是需要国际化的文件（默认为英文）。
            NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
            
            bundle = [NSBundle bundleWithPath:path];//生成bundle
        }else{
            int a=1;
            for (int i =0; i<[citiesCode count]; i++) {
                NSString *string=[citiesCode objectAtIndex:i];
                
                if ([string isEqualToString:current]) {
                    a=i;
                }else if ([current hasPrefix:string]){
                    a=i;
                }
                
            }
            
            //设置语言
            [UserLanguageManager setUserLanguage:[citiesCode objectAtIndex:a]];
            NSString *path = [[NSBundle mainBundle] pathForResource:[citiesCode objectAtIndex:a] ofType:@"lproj"];
            bundle = [NSBundle bundleWithPath:path];//生成bundle
            
                    }
        

    }else{
        
        //获取文件路径
        //我们使用 Xcode 创建一个新项目，会自动创建一个 en.lproj 目录，这个目录下存放的就是需要国际化的文件（默认为英文）。
        NSString *path = [[NSBundle mainBundle] pathForResource:(NSString *)kgetDefaultValueForKey(kUserlanguage) ofType:@"lproj"];
        
        bundle = [NSBundle bundleWithPath:path];//生成bundle

    }
    
    //注册通知，应用程序语言改变
    [[NSNotificationCenter defaultCenter] postNotificationName:kchangeLanguage object:nil];

    
}


//获得当前语言方法
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:@"userLanguage"];
    
    return language;
}


//设置语言方法
+ (void)setUserLanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    
    [def synchronize];
}

+ (NSString *)loadTextforKey:(NSString *)key {
   return [[UserLanguageManager bundle] localizedStringForKey:key value:nil table:@"LocationLanguage"];
}


@end
