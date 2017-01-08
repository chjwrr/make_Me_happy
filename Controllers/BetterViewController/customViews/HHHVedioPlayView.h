//
//  HHHVedioPlayView.h
//  ModelProduct
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

@protocol HHHVedioPlayViewDelegate <NSObject>

- (void)didSelectHHHVedioPlayViewColse;

@end

@interface HHHVedioPlayView : BaseView

@property (nonatomic,weak)id<HHHVedioPlayViewDelegate>delegate;

- (void)showWithData:(id)data inView:(UIView *)supView Y:(CGFloat)yyy;

- (void)close;

@end
