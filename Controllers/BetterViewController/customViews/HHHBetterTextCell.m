//
//  HHHBetterTextCell.m
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterTextCell.h"
#import "HHHCopyLabel.h"
#import "HHHTextModel.h"


#define kspaceHeight    10

@interface HHHBetterTextCell ()

@property (nonatomic,strong)HHHCopyLabel *lab_title;
@property (nonatomic,strong)UILabel *lab_time;
@property (nonatomic,strong)UIImageView *line;
@end

@implementation HHHBetterTextCell

- (void)initSubViews {
    //文字，图片，时间

    _lab_title=[[HHHCopyLabel alloc]initWithFrame:CGRectMake(0, 5, kSCREEN_WIDTH, 190)];
    [self addSubview:_lab_title];
    _lab_title.font=kSYS_FONT(15);
    _lab_title.numberOfLines=0;

    
    _lab_time=[[UILabel alloc]initWithFrame:CGRectMake(kspaceHeight, self.lab_title.y+kspaceHeight, kSCREEN_WIDTH-kspaceHeight*2, 20)];
    _lab_time.numberOfLines=0;
    _lab_time.textColor=kbaseColor;
    _lab_time.textAlignment=NSTextAlignmentRight;
    _lab_time.font=kSYS_BOLDFONT(12);
    [self addSubview:_lab_time];
    
    _line=[[UIImageView alloc]initWithFrame:CGRectMake(kspaceHeight*2, 0, kSCREEN_WIDTH-kspaceHeight*2, 0.5)];
    [self addSubview:_line];
    _line.backgroundColor=[UIColor lightGrayColor];
}

- (void)cellForData:(id)data {
    HHHTextModel *model=(HHHTextModel *)data;
    
    self.lab_title.text=model.title;
    
    CGFloat titleWidth=[model.title getStringHeightSizeWidth:kSCREEN_WIDTH-kspaceHeight*2 WithFontSize:15];
    
    self.lab_title.frame=CGRectMake(kspaceHeight, kspaceHeight, kSCREEN_WIDTH-kspaceHeight*2, titleWidth);

    self.lab_time.text=[NSString getDataStringFromeTimeInterval:model.textCreatTime];
    self.lab_time.frame=CGRectMake(kspaceHeight, self.lab_title.y+self.lab_title.height+kspaceHeight, kSCREEN_WIDTH-kspaceHeight*2, 20);

    _line.frame=CGRectMake(kspaceHeight*2, self.lab_time.y+self.lab_time.height+kspaceHeight-1, kSCREEN_WIDTH-kspaceHeight*2, 0.5);

}
+ (CGFloat)cellHeightForData:(id)data {
    
    HHHTextModel *model=(HHHTextModel *)data;
    
    CGFloat titleWidth=[model.title getStringHeightSizeWidth:kSCREEN_WIDTH-kspaceHeight*2 WithFontSize:15];
    
    return kspaceHeight+titleWidth+kspaceHeight+20+kspaceHeight;

}
@end
