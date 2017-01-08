//
//  CHJShowImageView.h
//  ModelProduct
//
//  Created by apple on 16/10/18.
//  Copyright © 2016年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CHJShowImageViewDismissBlock)(void);

@interface CHJShowImageView : UIView

@property (nonatomic,strong)UIImageView *imageView;


+ (instancetype)shareInstance;

- (void)showImageURL:(NSString *)imageURL BeginFrame:(CGRect)rect dismissComplete:(CHJShowImageViewDismissBlock)disBlock;

@end
