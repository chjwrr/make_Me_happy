//
//  HHHVedioPlayModel.h
//  ModelProduct
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface HHHVedioPlayModel : BaseModel

@property (nonatomic,strong)NSString *vedioURL;
@property (nonatomic,strong)NSString *vedioPicPath;
@property (nonatomic,strong)NSString *vedioSize;
@property (nonatomic,strong)NSString *vedioTitle;
@property (nonatomic,strong)NSString *vedioTotalTime;

@property (nonatomic)double vedioCreatTime;
@property (nonatomic)CGFloat vedioHeight;
@property (nonatomic)CGFloat vedioWidth;


@property (nonatomic,strong)NSString *maxTime;

@end
