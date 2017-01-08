//
//  HHHSexImageModel.h
//  ModelProduct
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface HHHSexImageModel : BaseModel


@property (nonatomic,strong)NSString *imageURL;
@property (nonatomic,strong)NSString *imageTitle;
@property (nonatomic,strong)NSString *JieID;
@property (nonatomic,assign)BOOL hasImages;//是否有图集

@property (nonatomic,strong)NSMutableArray *imageURLs;//图集数组

@end
