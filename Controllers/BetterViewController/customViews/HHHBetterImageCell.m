//
//  HHHBetterAudioCell.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterImageCell.h"
#import "HHHImageModel.h"

#define kspaceHeight    10

#define kspaceWidth     10

@interface HHHBetterImageCell ()

@property (nonatomic,strong)HHHCopyLabel *lab_title;
@property (nonatomic,strong)UILabel *lab_time;
@end
@implementation HHHBetterImageCell

- (void)initSubViews {
    //文字，图片，时间，播放按钮
}

- (UIImageView *)imageview {
    if (_imageview == nil) {
        
        _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 100)];
        [self addSubview:_imageview];
        _imageview.backgroundColor=kColorHexString(@"EDEDED");
        [self addSubview:_imageview];
        
    }
    return _imageview;
}

- (UILabel *)lab_title {
    if (_lab_title == nil) {
        
        _lab_title=[[HHHCopyLabel alloc]initWithFrame:CGRectMake(kspaceWidth, self.imageview.y+kspaceHeight, kSCREEN_WIDTH-kspaceWidth*2, 20)];
        _lab_title.numberOfLines=0;
        _lab_title.textColor=[UIColor blackColor];
        _lab_title.font=kSYS_FONT(15);
        [self addSubview:_lab_title];
        
    }
    return _lab_title;
}

- (UILabel *)lab_time {
    if (_lab_time == nil) {
        
        _lab_time=[[UILabel alloc]initWithFrame:CGRectMake(kspaceWidth, self.lab_title.y+kspaceHeight, kSCREEN_WIDTH-kspaceWidth*2, 20)];
        _lab_time.numberOfLines=0;
        _lab_time.textColor=kbaseColor;
        _lab_time.textAlignment=NSTextAlignmentRight;
        _lab_time.font=kSYS_BOLDFONT(12);
        [self addSubview:_lab_time];
        
    }
    return _lab_time;
}


- (void)cellForData:(id)data {
    HHHImageModel *model=(HHHImageModel *)data;
    
    CGFloat hhh=model.imageHeight*kSCREEN_WIDTH/model.imageWidth;
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:kFormatterSring(model.imageURL)]];
    self.imageview.frame=CGRectMake(0, 0, kSCREEN_WIDTH, hhh);
    
    
    self.lab_title.text=model.title;
    
    CGFloat titleWidth=[model.title getStringHeightSizeWidth:kSCREEN_WIDTH-kspaceWidth*2 WithFontSize:15];
    
    self.lab_title.frame=CGRectMake(kspaceWidth, self.imageview.height+kspaceHeight, kSCREEN_WIDTH-kspaceWidth*2, titleWidth);
    
    
    self.lab_time.text=[NSString getDataStringFromeTimeInterval:model.imageCreatTime];
    self.lab_time.frame=CGRectMake(kspaceWidth, self.lab_title.y+self.lab_title.height+kspaceHeight, kSCREEN_WIDTH-kspaceWidth*2, 20);
}


+ (CGFloat)cellHeightForData:(id)data {
    
    HHHImageModel *model=(HHHImageModel *)data;
    
    CGFloat hhh=model.imageHeight*kSCREEN_WIDTH/model.imageWidth;
    
    CGFloat titleWidth=[model.title getStringHeightSizeWidth:kSCREEN_WIDTH-kspaceWidth*2 WithFontSize:15];
    
    return hhh+kspaceHeight+titleWidth+kspaceHeight+20+kspaceHeight;
    
}

/**
 *  点击播放按钮
 */
- (void)playAction {
    [_delegate didSelectHHHBetterImageCellIndex:self.tag-100];
}

@end
