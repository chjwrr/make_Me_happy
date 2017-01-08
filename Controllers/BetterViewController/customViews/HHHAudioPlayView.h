//
//  HHHAudioPlayView.h
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

@protocol HHHAudioPlayViewDelegate <NSObject>

- (void)didSelectHHHAudioPlayViewClose;

@end

@interface HHHAudioPlayView : BaseView

@property (nonatomic,weak)id<HHHAudioPlayViewDelegate>delegate;

- (void)showWithData:(id)data inView:(UIView *)supView;

- (void)close;


@end
