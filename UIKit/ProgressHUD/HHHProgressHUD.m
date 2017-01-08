//
//  HHHProgressHUD.m
//  ModelProduct
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHProgressHUD.h"

@implementation HHHProgressHUD


+ (void)showProgressHUDMessage:(NSString *)string inView:(UIView *)supView{
    
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:supView];
    
    [supView addSubview:HUD];
    
    //如果设置此属性则当前的view置于后台
    
    //HUD.dimBackground=YES;
    
    HUD.mode=MBProgressHUDModeText;
    //设置对话框文字
    
    HUD.labelText=string;
    HUD.labelFont=kSYS_FONT(12);
    //显示对话框
    [HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        
        sleep(2);
        
    } completionBlock:^{
        //操作执行完后取消对话框
        
        [HUD removeFromSuperview];
        
    }];
}

@end
