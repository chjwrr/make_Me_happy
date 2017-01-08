//
//  UserLanguageManager.h
//  程序内切换语言
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLanguageManager : NSObject

//+ (id)shareInstance ;

+ (NSBundle *)bundle;//获取当前资源文件

+ (void)initUserLanguage;//初始化语言文件

//+ (NSString *)userLanguage;//获取应用当前语言

+ (void)setUserLanguage:(NSString *)language;//设置当前语言

+ (NSString *)loadTextforKey:(NSString *)key ;
@end
