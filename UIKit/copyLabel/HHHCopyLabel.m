//
//  CopyLabel.m
//  可复制的label
//
//  Created by apple on 15/4/30.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import "HHHCopyLabel.h"

@implementation HHHCopyLabel

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)attachTapHandler {
    self.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *touch=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handlerTap:)];
    [self addGestureRecognizer:touch];
}

- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

- (void)handlerTap:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        
        
        UIMenuItem *copyLink=[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(CopyBtnPressed:)];
        [[UIMenuController sharedMenuController] setMenuItems:@[copyLink]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES];
        
    }
}
//还需要针对复制的操作覆盖两个方法：

// 可以响应的方法

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    if (action == @selector(CopyBtnPressed:)) {
        return YES;
    }
    
    return NO;
    
}

//针对于响应方法的实现

-(void)CopyBtnPressed:(id)sender

{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    
    pboard.string = self.text;
}

@end
