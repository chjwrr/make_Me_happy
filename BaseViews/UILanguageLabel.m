//
//  UILanguageLabel.m
//  ModelProduct
//
//  Created by apple on 16/3/15.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "UILanguageLabel.h"

@implementation UILanguageLabel

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kchangeLanguage object:nil];
}

- (id)initWithFrame:(CGRect)frame languageKey:(NSString *)langKey;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.languageKey=[[NSString alloc]init];
        
        self.languageKey=langKey;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kchangeLanguage object:nil];
        
        [self setlabelText];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.languageKey=[[NSString alloc]init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kchangeLanguage object:nil];
        
        [self setlabelText];
        
    }
    return self;
    
}

- (void)setlabelText {
    
    
    NSString *aaa=kFormatterSring(self.languageKey);
    
    if ([aaa isEmpty]) {
        return;
    }
    
    self.text=[[UserLanguageManager bundle] localizedStringForKey:self.languageKey value:nil table:@"LocationLanguage"];
    
    
}

- (void)themeNotification:(NSNotification *)notification {
    
    [self setlabelText];
    
}

@end
