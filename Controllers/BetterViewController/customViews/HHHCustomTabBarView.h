//
//  HHHCustomTabBarView.h
//  ModelProduct
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"


@protocol HHHCustomTabBarViewDelegate <NSObject>

- (void)didSelectHHHCustomTabBarViewIndex:(NSInteger)index;

@end


@interface HHHCustomTabBarView : BaseView

@property (nonatomic,strong)NSArray *titles;


@property (nonatomic,weak)id<HHHCustomTabBarViewDelegate>delegate;

@end
