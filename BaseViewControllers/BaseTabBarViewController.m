//
//  BaseTabBarViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseTabBarViewController.h"

#import "HHHCustomTabBarView.h"

@interface BaseTabBarViewController ()<HHHCustomTabBarViewDelegate>



@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.frame=CGRectZero;
    [self.tabBar removeFromSuperview];
    self.tabBar.hidden=YES;
    
    for(UIView *view in self.view.subviews){
        
         if([view isKindOfClass:[UITabBar class]]){
            
             view.hidden = YES;
        }
    }
    
    HHHCustomTabBarView *tabbarView=[[HHHCustomTabBarView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kTABBAR_HEIGHT, kSCREEN_WIDTH, kTABBAR_HEIGHT)];
    tabbarView.delegate=self;
    tabbarView.titles=@[@"精选",@"美图",@"视频",@"设置"];
    [self.view addSubview:tabbarView];

}




- (void)didSelectHHHCustomTabBarViewIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }

    self.selectedIndex=index;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
