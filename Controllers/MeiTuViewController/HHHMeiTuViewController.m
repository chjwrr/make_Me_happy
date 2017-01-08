//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHMeiTuViewController.h"

#import "HHHMeiTuBetterViewController.h"
#import "HHHMeiTuNewViewController.h"
#import "HHHMeiTuSexViewController.h"

#import "HHHRandomViewController.h"

@interface HHHMeiTuViewController ()

@property (nonatomic,strong)HHHMeiTuBetterViewController *betterVC;
@property (nonatomic,strong)HHHMeiTuNewViewController *xinVC;
@property (nonatomic,strong)HHHMeiTuSexViewController *sexVC;
@property (nonatomic,strong)BaseViewController *currentVC;


@property (nonatomic,strong)UISegmentedControl *segmentCtrl;
@end

@implementation HHHMeiTuViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

    self.segmentCtrl.hidden=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.segmentCtrl.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initDataSource {
 
    _betterVC=[[HHHMeiTuBetterViewController alloc]init];
    [self addChildViewController:_betterVC];
    
    _xinVC=[[HHHMeiTuNewViewController alloc]init];
    [self addChildViewController:_xinVC];
    
    _sexVC=[[HHHMeiTuSexViewController alloc]init];
    [self addChildViewController:_sexVC];
    
    [self.view addSubview:_betterVC.view];
    _currentVC=_betterVC;
    
    [_betterVC didMoveToParentViewController:self];
}
- (void)initSubViews {
    
    [self.navigationController.navigationBar addSubview:self.segmentCtrl];
    
    __weak HHHMeiTuViewController *weakself=self;
    
    self.rightNavBarBlock=^{
        HHHRandomViewController *redomVC=[[HHHRandomViewController alloc]init];
        [weakself.navigationController pushViewController:redomVC animated:YES];
    };
}

- (UISegmentedControl *)segmentCtrl {
    if (_segmentCtrl == nil) {
        
        NSDate *date=[NSDate date];
        NSTimeInterval interval = [date timeIntervalSince1970];//当前日期的时间戳
        NSTimeInterval nextinterval=1481731200;
        
        //12月15日的时间戳
        if (interval > nextinterval) {
            [self addNavigationRightBar];
        }
        _segmentCtrl=[[UISegmentedControl alloc]initWithItems:@[@"美图",@"最新"]];
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
            [self changeViewControllerToNewViewController:_betterVC];
            
        }
            break;
        case 1:{
            [self changeViewControllerToNewViewController:_xinVC];
            
        }
            break;
        case 2:{
            [self changeViewControllerToNewViewController:_sexVC];

        }
            break;
        default:
            break;
    }
}

/**
 * 导航条添加  随机 按钮
 */
- (void)addNavigationRightBar {
    [self initRithNavigationBarButtonWithImage:@"hhh_sexImage_rightBarimage"];
}

/**
 *  导航条移除  随机 按钮
 */
- (void)removeNavigationRightBar {
    self.navigationItem.rightBarButtonItems=nil;
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
