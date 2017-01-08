//
//  HHHSexImageCell.m
//  ModelProduct
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHSexImageCell.h"

#import "HHHSexImageModel.h"

#define kimageHeight      200

#define kspaceHeight      5

#define kspacewidth       10

#define klabelWidth       kSCREEN_WIDTH - kspacewidth*2

@interface HHHSexImageCell ()

@property (nonatomic,strong)UILabel *lab_number;
@property (nonatomic,strong)HHHCopyLabel *lab_title;


@end

@implementation HHHSexImageCell


- (UIImageView *)imageview {
    if (!_imageview) {
        _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _imageview.contentMode=UIViewContentModeScaleAspectFill;
        _imageview.layer.masksToBounds=YES;
        [self addSubview:_imageview];
    }
    return _imageview;
}

- (UILabel *)lab_number {
    if (!_lab_number) {
        _lab_number=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _lab_number.textColor=kbaseColor;
        _lab_number.textAlignment=NSTextAlignmentRight;
        [self addSubview:_lab_number];
    }
    return _lab_number;
}

- (HHHCopyLabel *)lab_title {
    if (!_lab_title) {
        _lab_title=[[HHHCopyLabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _lab_title.textColor=kbaseColor;
        _lab_title.numberOfLines=0;
        _lab_title.font=kSYS_FONT(14);
        [self addSubview:_lab_title];
    }
    return _lab_title;
}


- (void)cellForData:(id)data {
    HHHSexImageModel *model=(HHHSexImageModel *)data;

    self.imageview.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kimageHeight);
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
    
    self.lab_number.frame=CGRectMake(kSCREEN_WIDTH-50, kimageHeight-30, 40, 20);
    self.lab_number.text=kFormatterInt([model.imageURLs count]);

    CGFloat labHieght=[model.imageTitle getStringHeightSizeWidth:klabelWidth WithFontSize:14]+5;
    self.lab_title.frame=CGRectMake(kspacewidth, self.imageview.y+self.imageview.height+kspaceHeight, klabelWidth, labHieght);
    self.lab_title.text=model.imageTitle;

    
}

+ (CGFloat)cellHeightForData:(id)data {
    
    HHHSexImageModel *model=(HHHSexImageModel *)data;
    
    CGFloat labHieght=[model.imageTitle getStringHeightSizeWidth:klabelWidth WithFontSize:14]+5;

    return kimageHeight+kspaceHeight+labHieght+kspaceHeight;
}
@end
