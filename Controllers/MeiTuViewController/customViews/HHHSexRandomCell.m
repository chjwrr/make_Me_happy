//
//  HHHSexRandomCell.m
//  ModelProduct
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHSexRandomCell.h"
#import "HHHSexImageModel.h"

@implementation HHHSexRandomCell

- (UIImageView *)imageview {
    if (!_imageview) {
        _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _imageview.contentMode=UIViewContentModeScaleAspectFill;
        _imageview.layer.masksToBounds=YES;
        [self addSubview:_imageview];
    }
    return _imageview;
}


- (void)cellForData:(id)data {
    HHHSexImageModel *model=(HHHSexImageModel *)data;
    
    self.imageview.frame=CGRectMake(0, 0, self.width, self.height);
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];

}
@end
