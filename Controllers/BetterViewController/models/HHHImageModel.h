//
//  HHHImageModel.h
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface HHHImageModel : BaseModel

@property (nonatomic,strong)NSString *imageURL;
@property (nonatomic,strong)NSString *title;
@property (nonatomic)CGFloat imageHeight;
@property (nonatomic)CGFloat imageWidth;
@property (nonatomic,strong)NSString *maxTime;
@property (nonatomic)double imageCreatTime;

@end
