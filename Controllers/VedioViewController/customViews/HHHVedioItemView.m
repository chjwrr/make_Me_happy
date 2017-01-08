//
//  HHHVedioItemView.m
//  ModelProduct
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHVedioItemView.h"

#define kviewHeight   40

@interface HHHVedioItemView ()

@property(nonatomic)NSInteger currentIndex;

@end
@implementation HHHVedioItemView

- (void)initSubView {

    NSArray *titles;
    
    NSDate *date=[NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970];//当前日期的时间戳
    NSTimeInterval nextinterval=1481472000;//12月12日的时间戳  1481472000
    
    //当前的时间戳大于12月5日的时间戳。说明当前日期为 12月12日 以后
    if (interval > nextinterval) {
        titles=@[@"最新",@"舞蹈女神",@"性感女神",@"音乐女神",@"日系宅舞"];
    }else
        titles=@[@"最新"];

    
    for (int i=0; i<[titles count]; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/[titles count]*i, 0, kSCREEN_WIDTH/[titles count], kviewHeight)];
        [self addSubview:button];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        
        if (i == 0) {
            [button setTitleColor:kbaseColor forState:UIControlStateNormal];
        }else
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        button.titleLabel.font=kSYS_FONT(14);
        button.tag=100+i;
        [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _currentIndex=100;
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, kviewHeight-1, kSCREEN_WIDTH, 0.5)];
    [self addSubview:line];
    line.backgroundColor=[UIColor lightGrayColor];
}


- (void)itemAction:(UIButton *)button {
    if (_currentIndex == button.tag) {
        return;
    }
    
    [button setTitleColor:kbaseColor forState:UIControlStateNormal];

    UIButton *oldButton=(UIButton *)[self viewWithTag:_currentIndex];
    [oldButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    [_delegate didSelectHHHVedioItemViewIndex:button.tag-100];
    
    _currentIndex=button.tag;
}

+ (CGFloat)viewHeight {
    return kviewHeight;
}

@end
