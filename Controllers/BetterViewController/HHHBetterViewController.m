//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterViewController.h"
#import "HHHCustomTabBarView.h"
#import "HHHVedioPlayView.h"

#import "HHHBetterAudioViewController.h"
#import "HHHBetterVideoViewController.h"
#import "HHHBetterImageViewController.h"
#import "HHHBetterTextViewController.h"

@interface HHHBetterViewController ()<HHHCustomTabBarViewDelegate>

@property (nonatomic,strong)HHHCustomTabBarView *tabbarView;

@property (nonatomic,strong)HHHBetterVideoViewController *videoVC;
@property (nonatomic,strong)HHHBetterAudioViewController *audioVC;
@property (nonatomic,strong)HHHBetterImageViewController *imageVC;
@property (nonatomic,strong)HHHBetterTextViewController *textVC;

@property (nonatomic,strong)BaseViewController *currentVC;

@property (nonatomic,strong)UIView *statuView;


@end

@implementation HHHBetterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    self.fd_prefersNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)initDataSource {
    
}

- (void)initSubViews {

    _statuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSTATUSBAR_HEIGHT)];
    [self.view addSubview:_statuView];
    _statuView.backgroundColor=kbaseStatuColor;

    _videoVC=[[HHHBetterVideoViewController alloc]init];
    [self addChildViewController:_videoVC];
    
    _audioVC=[[HHHBetterAudioViewController alloc]init];
    [self addChildViewController:_audioVC];
    
    _imageVC=[[HHHBetterImageViewController alloc]init];
    [self addChildViewController:_imageVC];
    
    _textVC=[[HHHBetterTextViewController alloc]init];
    [self addChildViewController:_textVC];
    
    
    [self.view addSubview:_videoVC.view];
    [_videoVC didMoveToParentViewController:self];
    _currentVC=_videoVC;
    
    
    
    _tabbarView=[[HHHCustomTabBarView alloc]initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, kTABBAR_HEIGHT)];
    _tabbarView.delegate=self;
    _tabbarView.titles=@[@"视频",@"声音",@"图片",@"段子"];
    [self.view addSubview:_tabbarView];

}






/**
 *  HHHCustomTabBarView Delegate
 *
 *  @param index 视频 声音 图片 段子
 */
- (void)didSelectHHHCustomTabBarViewIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            [self changeViewControllerToNewViewController:_videoVC];
        }
            break;
        case 1:{
            [self changeViewControllerToNewViewController:_audioVC];
        }
            break;
        case 2:{
            [self changeViewControllerToNewViewController:_imageVC];
        }
            break;
        case 3:{
            [self changeViewControllerToNewViewController:_textVC];
        }
            break;
        default:
            break;
    }
    
    [self.view bringSubviewToFront:_tabbarView];
    //[self.view bringSubviewToFront:_statuView];

}

/**
 *  切换视图控制器
 *
 *  @param newVC 需要切换到的控制器
 */
- (void)changeViewControllerToNewViewController:(BaseViewController *)newVC {
    [self transitionFromViewController:_currentVC toViewController:newVC duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            _currentVC=newVC;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
