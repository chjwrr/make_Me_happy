//
//  HHHBetterVedioCell.h
//  ModelProduct
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseCell.h"

@protocol HHHBetterVedioCellDelegate <NSObject>

- (void)didSelectHHHBetterVedioCellIndex:(NSInteger)index;

@end
@interface HHHBetterVedioCell : BaseCell

@property (nonatomic,weak)id<HHHBetterVedioCellDelegate>delegate;

@end
