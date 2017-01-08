//
//  HHHAudioPlayModel.h
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface HHHAudioPlayModel : BaseModel

@property (nonatomic,strong)NSString *audioURL;
@property (nonatomic,strong)NSString *audioPicPath;
@property (nonatomic,strong)NSString *audioTotalTime;
@property (nonatomic,strong)NSString *audioTitle;

@property (nonatomic)double audioCreatTime;
@property (nonatomic)CGFloat audioHeight;
@property (nonatomic)CGFloat audioWidth;

@property (nonatomic,strong)NSString *maxTime;

@end
