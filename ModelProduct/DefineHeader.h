//
//  DefineHeader.h
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#ifndef ModelProduct_DefineHeader_h
#define ModelProduct_DefineHeader_h

//缓存目录
#define kTXTFilePath                            @"CacheFilePath"

//数据库名称
#define kFMDBName                               @"/Muwood.sqlite"

//数据库路径
#define kFMDBPath                               [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:kFMDBName]

//导航条背景颜色
#define kNavgationBarBackGroundColor            kColorWithRGB(69, 125, 254, 1.0)

//用户位置信息
#define kUserLocationLatitude                   @"UserLocationLatitude"

#define kUserLocationLongitude                  @"UserLocationLongitude"

//详细地址信息
#define kUserLocationAddressInfo                @"UserLocationAddressInfo"

//城市
#define kUserLocationCity                       @"UserLocationCity"

//国家
#define kUserLocationCountry                    @"UserLocationCountry"

//用户选择语言
#define kUserlanguage                           @"Userlanguage"





/*通知*/


//切换语言发送通知
#define kchangeLanguage                         @"LocationLanguageName"




#endif
