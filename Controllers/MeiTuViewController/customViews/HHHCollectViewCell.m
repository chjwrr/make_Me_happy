//
//  HHHCollectViewCell.m
//  ModelProduct
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHCollectViewCell.h"
#import "HHHMeiTuModel.h"

#define ktopBottomheight  1
#define kspaceHeight      5
#define kspacewidth       2
#define kcellWidth        (kSCREEN_WIDTH - kspacewidth)/2

@interface HHHCollectViewCell ()

@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)HHHCopyLabel *lab_title;

@end
@implementation HHHCollectViewCell

- (UIImageView *)imageview {
    if (!_imageview) {
        _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, ktopBottomheight, self.width, self.height)];
        [self addSubview:_imageview];
    }
    return _imageview;
}

- (HHHCopyLabel *)lab_title {
    if (!_lab_title) {
        _lab_title=[[HHHCopyLabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _lab_title.font=kSYS_FONT(14);
        _lab_title.numberOfLines=0;
        _lab_title.textColor=kbaseColor;
        [self addSubview:_lab_title];
    }
    return _lab_title;
}

- (void)cellForData:(id)data {
    HHHMeiTuModel *model=(HHHMeiTuModel *)data;
    
    CGFloat imageHeight=model.imageHeight / model.imageWidth * kcellWidth;
    
    self.imageview.frame=CGRectMake(0, ktopBottomheight, kcellWidth, imageHeight);
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.originUrl]];
    
    CGFloat labHieght=[model.album_name getStringHeightSizeWidth:kcellWidth-kspacewidth*2 WithFontSize:14]+5;
    self.lab_title.frame=CGRectMake(kspacewidth, self.imageview.y+self.imageview.height+kspaceHeight, kcellWidth-kspacewidth*2, labHieght);
    self.lab_title.text=model.album_name;
}

+ (CGFloat)cellHeightForData:(id)data {
    HHHMeiTuModel *model=(HHHMeiTuModel *)data;
    
    CGFloat imageHeight=model.imageHeight / model.imageWidth * kcellWidth;
    
    CGFloat labHieght=[model.album_name getStringHeightSizeWidth:kcellWidth-kspacewidth*2 WithFontSize:14]+5;

    return ktopBottomheight+imageHeight+kspaceHeight+labHieght+ktopBottomheight;
}

@end
