//
//  HHHCustomTabBarView.m
//  ModelProduct
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHCustomTabBarView.h"
#define ktime   3

@protocol itemViewDelegate <NSObject>

- (void)didSelectItemViewWithIndex:(NSInteger)index;

@end
@interface itemView : BaseView

@property (nonatomic,weak)id<itemViewDelegate>delegate;

@end

@implementation itemView



- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title {
    self=[super initWithFrame:frame];
    if (self) {
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:button];
        [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSAttributedString *attString=[[NSAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZYingBiXingShu-S16S" size:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [button setAttributedTitle:attString forState:UIControlStateNormal];
    }
    return self;
    
}

- (void)itemAction:(UIButton *)button {
    [_delegate didSelectItemViewWithIndex:self.tag];
}

@end




@interface HHHCustomTabBarView ()<itemViewDelegate>{
    NSTimer *time;
}

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *coverView;

@property (nonatomic,strong)UIButton *leftButton;

@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation HHHCustomTabBarView




- (void)initSubView {
    
    _titles=[NSArray array];
    
    _selectIndex=0;
    
    time=[NSTimer scheduledTimerWithTimeInterval:ktime target:self selector:@selector(changeSmall) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:time forMode:NSDefaultRunLoopMode];

    _bgView=[[UIView alloc]initWithFrame:CGRectMake(5, 0, self.width-10, self.height-4)];
    [self addSubview:_bgView];
    _bgView.backgroundColor=kbaseColor;
    
    _bgView.layer.cornerRadius=_bgView.height/2;
    _bgView.layer.masksToBounds=YES;
    
    
    
}


- (void)setTitles:(NSArray *)titles {
    _titles=titles;
    for (int i=0; i<[titles count]; i++) {
        itemView *subView=[[itemView alloc]initWithFrame:CGRectMake(_bgView.width/4*i, 0, _bgView.width/4, _bgView.height) Title:[titles objectAtIndex:i]];
        [_bgView addSubview:subView];
        subView.tag=100+i;
        subView.delegate=self;
    }

    
}

- (void)changeSmall {
    self.coverView.alpha=0.0;

    if (time == nil) {
        self.leftButton.alpha=1.0;
    }else
        self.leftButton.alpha=0.0;
    
    self.coverView.hidden=NO;
    self.leftButton.hidden=NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame=CGRectMake(self.x, self.y, kTABBAR_HEIGHT, kTABBAR_HEIGHT);
        _bgView.frame=CGRectMake(5, 0, self.height-4, self.height-4);
        
        self.coverView.alpha=1.0;
        self.leftButton.alpha=1.0;

    } completion:^(BOOL finished) {
        if (finished) {
            NSAttributedString *attString=[[NSAttributedString alloc]initWithString:[_titles objectAtIndex:_selectIndex] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZYingBiXingShu-S16S" size:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
            [self.leftButton setAttributedTitle:attString forState:UIControlStateNormal];
            [self leftButtonAnimal];
            
        }
    }];
}
- (void)changeBig {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame=CGRectMake(self.x, self.y, kSCREEN_WIDTH, kTABBAR_HEIGHT);
        _bgView.frame=CGRectMake(5, 0, self.width-10, self.height-4);
        
        self.coverView.alpha=0.0;

        self.leftButton.alpha=0.0;

    } completion:^(BOOL finished) {
        if (finished) {
            
            self.coverView.hidden=YES;
            self.coverView.alpha=0.0;

            self.leftButton.hidden=YES;
            self.leftButton.alpha=0.0;
            
            
            NSAttributedString *attString=[[NSAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZYingBiXingShu-S16S" size:14],NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kSYS_FONT(14)}];
            [self.leftButton setAttributedTitle:attString forState:UIControlStateNormal];

        }
    }];

    [time invalidate];
    time = nil;
    
    time=[NSTimer scheduledTimerWithTimeInterval:ktime target:self selector:@selector(changeSmall) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:time forMode:NSDefaultRunLoopMode];

}

- (UIButton *)leftButton {
    if (_leftButton == nil) {
        
        _leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _bgView.height, _bgView.height)];
        [_leftButton setBackgroundColor:kbaseColor];
        [_bgView addSubview:_leftButton];
        [_leftButton addTarget:self action:@selector(changeBig) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.titleLabel.font=kSYS_FONT(14);
    }
    return _leftButton;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView=[[UIView alloc]initWithFrame:CGRectMake(5, 0, self.width-10, self.height-4)];
        _coverView.backgroundColor=kbaseColor;
        [_bgView addSubview:_coverView];
    }
    return _coverView;
}
- (void)leftButtonAnimal {
    
    CABasicAnimation *opacityanimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityanimation.duration= 1.0f;
    opacityanimation.fromValue= [NSNumber numberWithInt:0.3];
    opacityanimation.toValue=  [NSNumber numberWithInt:1];
    
    opacityanimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityanimation.repeatCount= 10000;
    opacityanimation.autoreverses= YES;
    
    [_leftButton.layer addAnimation:opacityanimation forKey:nil];

}


/**
 *  tabbar item 点击
 *
 *  @param index
 */
- (void)didSelectItemViewWithIndex:(NSInteger)index {
    [time invalidate];
    time = nil;
    
    _selectIndex=index-100;
    
    [self changeSmall];
    
    [_delegate didSelectHHHCustomTabBarViewIndex:index-100];
    
}


@end
