//
//  HHHBetterAudioCell.h
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseCell.h"

@protocol HHHBetterAudioCellDelegate <NSObject>

- (void)didSelectHHHBetterAudioCellIndex:(NSInteger)index;

@end

@interface HHHBetterAudioCell : BaseCell
@property (nonatomic,strong)UIImageView *imageview;

@property (nonatomic,weak)id<HHHBetterAudioCellDelegate>delegate;

@end
