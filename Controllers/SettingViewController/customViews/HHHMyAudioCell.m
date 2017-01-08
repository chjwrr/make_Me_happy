//
//  HHHMyAudioCell.m
//  ModelProduct
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHMyAudioCell.h"


#define kcellHeight      70

@interface HHHMyAudioCell ()

@property (nonatomic,strong)UILabel *lab_size;
@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UIImageView *headImage;

@end

@implementation HHHMyAudioCell

- (void)initSubViews {
    _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [self addSubview:_headImage];

    _lab_title=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, kSCREEN_WIDTH-70-70, 50)];
    _lab_title.numberOfLines=0;
    [self addSubview:_lab_title];
    
    _lab_size=[[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-60, 40, 50, 20)];
    _lab_size.font=kSYS_FONT(14);
    _lab_size.textAlignment=NSTextAlignmentRight;
    [self addSubview:_lab_size];
    
}

- (void)cellForData:(id)data {
    _headImage.backgroundColor=kColorHexString(@"EDEDED");
    _lab_size.text=@"12M";
    _lab_title.text=@"我的音频";
}
+ (CGFloat)cellHeight {
    return kcellHeight;
}

@end
