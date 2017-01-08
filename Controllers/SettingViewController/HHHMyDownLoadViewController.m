//
//  HHHMyDownLoadViewController.m
//  ModelProduct
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHMyDownLoadViewController.h"
#import "HHHMyAudioListViewController.h"
#import "HHHMyVideoListViewController.h"

@interface HHHMyDownLoadViewController ()

@property (nonatomic,strong)UISegmentedControl *segmentCtrl;

@property (nonatomic,strong)HHHMyAudioListViewController *audioVC;
@property (nonatomic,strong)HHHMyVideoListViewController *videoVC;
@property (nonatomic,strong)BaseViewController *currentVC;
@end

@implementation HHHMyDownLoadViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    self.segmentCtrl.hidden=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.segmentCtrl.hidden=YES;
}

- (void)initDataSource {
    
    _audioVC=[[HHHMyAudioListViewController alloc]init];
    [self addChildViewController:_audioVC];
    
    _videoVC=[[HHHMyVideoListViewController alloc]init];
    [self addChildViewController:_videoVC];
    
    [self.view addSubview:_videoVC.view];
    _currentVC=_videoVC;
    
    [_videoVC didMoveToParentViewController:self];

}
- (void)initSubViews {
    
    [self.navigationController.navigationBar addSubview:self.segmentCtrl];
    
    [self initLeftNavigationBarButton];
}


- (UISegmentedControl *)segmentCtrl {
    if (_segmentCtrl == nil) {
        
        _segmentCtrl=[[UISegmentedControl alloc]initWithItems:@[@"视频",@"音频"]];
        _segmentCtrl.frame=CGRectMake((kSCREEN_WIDTH-120)/2, 7, 120, 30);
        
        _segmentCtrl.selectedSegmentIndex=0;
        _segmentCtrl.tintColor=[UIColor whiteColor];
        
        [_segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZYingBiXingShu-S16S" size:15],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
        
        [_segmentCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentCtrl;
}

/**
 *  UISegmentedControl  Action
 *
 *  @param segCtrl segmentCtrl
 */
- (void)segmentAction:(UISegmentedControl *)segCtrl {
    switch (segCtrl.selectedSegmentIndex) {
        case 0:{
            //视频
            [self changeViewControllerToNewViewController:_videoVC];

        }
            break;
        case 1:{
            //音频
            [self changeViewControllerToNewViewController:_audioVC];

        }
            break;
        default:
            break;
    }
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

@end
