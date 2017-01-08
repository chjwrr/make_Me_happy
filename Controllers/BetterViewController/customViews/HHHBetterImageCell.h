//
//  HHHBetterImageCell.h
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseCell.h"

@protocol HHHBetterImageCellDelegate <NSObject>

- (void)didSelectHHHBetterImageCellIndex:(NSInteger)index;

@end

@interface HHHBetterImageCell : BaseCell

@property (nonatomic,strong)UIImageView *imageview;

@property (nonatomic,weak)id<HHHBetterImageCellDelegate>delegate;

@end
