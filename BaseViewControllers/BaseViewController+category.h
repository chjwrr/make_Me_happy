//
//  BaseViewController+category.h
//  ModelProduct
//
//  Created by apple on 16/10/18.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (category)

//需要保存到本地的图片
@property (nonatomic,strong)UIImage *saveImage;

//保存图片到本地
- (void)showSaveAndReportAlert:(UIImage *)image;


@end
