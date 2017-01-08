//
//  HHHBetterAudioCell.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterAudioCell.h"
#import "HHHAudioPlayModel.h"

#define kspaceHeight    10

#define kspaceWidth     10

@interface HHHBetterAudioCell ()

@property (nonatomic,strong)HHHCopyLabel *lab_title;
@property (nonatomic,strong)UILabel *lab_time;
@property (nonatomic,strong)UIButton *playButton;
@end
@implementation HHHBetterAudioCell

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
- (UIButton *)playButton {
    if (_playButton == nil) {
        _playButton=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44, self.imageview.height-44, 44, 44)];
        [self addSubview:_playButton];
        [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
        [_playButton setImage:kImageName(@"hhh_audio_list_play") forState:UIControlStateHighlighted];
        [_playButton setImage:kImageName(@"hhh_audio_list_play_select") forState:UIControlStateNormal];
        
        
    }
    return _playButton;
}

- (void)cellForData:(id)data {
    HHHAudioPlayModel *model=(HHHAudioPlayModel *)data;
    
    CGFloat hhh=model.audioHeight*kSCREEN_WIDTH/model.audioWidth;
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:kFormatterSring(model.audioPicPath)]];
    self.imageview.frame=CGRectMake(0, 0, kSCREEN_WIDTH, hhh);
    
    
    self.lab_title.text=model.audioTitle;
    
    CGFloat titleWidth=[model.audioTitle getStringHeightSizeWidth:kSCREEN_WIDTH-kspaceWidth*2 WithFontSize:15];
    
    self.lab_title.frame=CGRectMake(kspaceWidth, self.imageview.height+kspaceHeight, kSCREEN_WIDTH-kspaceWidth*2, titleWidth);
    
    
    self.lab_time.text=[NSString getDataStringFromeTimeInterval:model.audioCreatTime];
    self.lab_time.frame=CGRectMake(kspaceWidth, self.lab_title.y+self.lab_title.height+kspaceHeight, kSCREEN_WIDTH-kspaceWidth*2, 20);
    
    self.playButton.frame=CGRectMake(kSCREEN_WIDTH-44, self.imageview.height-44, 44, 44);
    
}


+ (CGFloat)cellHeightForData:(id)data {
    
    HHHAudioPlayModel *model=(HHHAudioPlayModel *)data;
    
    CGFloat hhh=model.audioHeight*kSCREEN_WIDTH/model.audioWidth;
    
    CGFloat titleWidth=[model.audioTitle getStringHeightSizeWidth:kSCREEN_WIDTH-kspaceWidth*2 WithFontSize:15];
    
    return hhh+kspaceHeight+titleWidth+kspaceHeight+20+kspaceHeight;
    
}

/**
 *  点击播放按钮
 */
- (void)playAction {
    [_delegate didSelectHHHBetterAudioCellIndex:self.tag-100];
}

@end
