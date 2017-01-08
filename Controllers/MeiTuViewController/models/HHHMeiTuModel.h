//
//  HHHMeiTuModel.h
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface HHHMeiTuModel : BaseModel

@property (nonatomic,strong)NSString *album_name;
@property (nonatomic,strong)NSString *originUrl;
@property (nonatomic,strong)NSString *thumbUrl;//缩略图

@property (nonatomic)CGFloat imageHeight;
@property (nonatomic)CGFloat imageWidth;
@property (nonatomic)double creat_time;
@property (nonatomic)NSInteger imageNum;
@property (nonatomic)long int imageSize;

@end
