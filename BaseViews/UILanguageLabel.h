//
//  UILanguageLabel.h
//  ModelProduct
//
//  Created by apple on 16/3/15.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILanguageLabel : UILabel

@property(nonatomic,strong)NSString *languageKey;

- (id)initWithFrame:(CGRect)frame languageKey:(NSString *)langKey;

@end
