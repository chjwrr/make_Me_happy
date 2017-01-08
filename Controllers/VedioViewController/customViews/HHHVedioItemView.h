//
//  HHHVedioItemView.h
//  ModelProduct
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

@protocol HHHVedioItemViewDelegate <NSObject>

- (void)didSelectHHHVedioItemViewIndex:(NSInteger)index;

@end

@interface HHHVedioItemView : BaseView

@property (nonatomic,weak)id <HHHVedioItemViewDelegate>delegate;

+ (CGFloat)viewHeight;

@end
