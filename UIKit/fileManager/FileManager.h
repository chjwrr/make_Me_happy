//
//  FileManager.h
//  NSFileManager测试
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (id)shareIntance;

/*创建文件夹*/
- (void)creatMyWayFilePath;

/*返回视频文件夹地址*/
- (NSString *)videoFilePath;

/*返回音频文件夹地址*/
- (NSString *)audeoFilePath;

/*返回图片文件夹地址*/
- (NSString *)imageFilePath;

/*移除某一个视频*/
- (void)removeAudeoFilePathWithItemName:(NSString *)name;

/*移除某一个音频*/
- (void)removeVideoFilePathWithItemName:(NSString *)name;

/*移除某一个图片*/
- (void)removeImageFilePathWithItemName:(NSString *)name;

/*删除所有的视频*/
- (void)removeAllVideoItems;

/*删除所有的音频*/
- (void)removeAllAudeoItems;

/*删除所有的图片*/
- (void)removeAllImageItems;

/*获取所有的视频*/
- (NSArray *)getAllVideoItems;

/*获取所有的音频*/
- (NSArray *)getAllAudeoItems;

/*获取所有的图片*/
- (NSArray *)getAllImageItems;

- (void)saveContent:(NSDictionary *)content ToFilePath:(NSString *)filepath;

/*获取新闻文件夹数据*/
- (NSDictionary *)getContentFromFilePath:(NSString *)filepath;

//判断视频文件夹里面是否存在当前视频，根据视频名字判断
- (BOOL)isHasThisVedio:(NSString *)vedioName;

//判断音频文件夹里面是否存在该视频地址
- (BOOL)isHasThisAudio:(NSString *)vedioName;

@end
