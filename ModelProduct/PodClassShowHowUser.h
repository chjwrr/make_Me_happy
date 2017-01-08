//
//  PodClassShowHowUser.h
//  ModelProduct
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 chj. All rights reserved.
//

#ifndef PodClassShowHowUser_h
#define PodClassShowHowUser_h

/*
 pod "AFNetworking"
 pod 'IQKeyboardManager'
 pod 'HexColors'
 pod 'MJRefresh'
 pod "SDWebImage"
 pod "MWPhotoBrowser"
 pod 'FMDB'
 pod 'FDFullscreenPopGesture'
 pod 'ZYCornerRadius'
 pod 'RealReachability'
 pod 'JDStatusBarNotification'
 */


/*
 #import "FXBlurView.h"
 #import "JSONKit.h"
 #import "SWTableViewCell.h"
 #import "VVBlurViewController.h"
 */

/**************************************  AFNetworking  使用介绍  **************************************/

/**
 * pod "AFNetworking"   
 *
 * 详细使用情况参考 AFHTTPClickManager.h
 */



/**************************************  IQKeyboardManager  使用介绍  **************************************/


/**
 *  pod 'IQKeyboardManager'
 *
 *  [[IQKeyboardManager sharedManager] setEnable:YES];
 *
 *  [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10];
 *
 *  [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
 *
 *  [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
 *
 *  不使用在键盘上的工具条
 *
 *  [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
 */


/**************************************  HexColors  使用介绍  **************************************/


/**
 * pod 'HexColors'
 * 
 * 使用方法  kColorHexString(@“色值”)
 */


/**************************************  MJRefresh  使用介绍  **************************************/


/**
 *  pod 'MJRefresh'
 *
 *  使用方法参考 BaseViewController.h
 */



/**************************************  SDWebImage  使用介绍  **************************************/


/**
 *  pod "SDWebImage"
 *
 *  使用方法参考 SDWebImage -->Core 里面的分类方法
 */



/**************************************  MWPhotoBrowser  使用介绍  **************************************/


/**
 *  pod "MWPhotoBrowser"
 *
 *  使用方法参考 BaseViewController.h
 */


/**************************************  FMDB  使用介绍  **************************************/



/**
 *  pod 'FMDB'
 *
 *  使用方法参考 FMDBManager.h
 */



/**************************************  FDFullscreenPopGesture  使用介绍  **************************************/



/**
 *  pod 'FDFullscreenPopGesture'
 *
 *  什么都不用写，自动带有滑动返回效果
 *
 *  但是如果从 有bar 跳转到 无bar ，或者 无bar 跳转到 有bar 再到 无bar ，需要进行一下操作
 *
 *  - (void)viewDidLoad {
 *
 *      [super viewDidLoad];
 *
 *      self.navigationController.fd_prefersNavigationBarHidden = YES;
 *
 *  }
 *
 *  或者 重载
 * 
 *  - (BOOL)fd_prefersNavigationBarHidden {
 *
 *      return YES;
 *
 *  }
 */


/**************************************  ZYCornerRadius  使用介绍  **************************************/



/**
 *  pod 'ZYCornerRadius'  -->UIImageView+CornerRadius.h
 *
 *  初始化 UIImageView 时，调用这个方法，创建一个有弧度的图片，可以指定 四个角 哪些需要有弧度
 *
 *  - (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;
 *
 *
 *
 *  UIImageView 对象可以调用此方法，得到一个有弧度的图片，可以指定 四个角 哪些需要有弧度
 *
 *  - (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;
 *
 *
 *
 *  初始化 UIImageView 时，调用这个方法，创建一个圆角的 UIImageView 对象
 *
 *  - (instancetype)initWithRoundingRectImageView;
 *
 *
 *
 *  UIImageView 对象可以调用此方法，得到圆角的 UIImageView 对象
 *
 *  - (void)zy_cornerRadiusRoundingRect;
 *
 *
 *
 *  UIImageView 对象可以调用此方法，得到有边框的 UIImageView 对象，可以指定边框宽度，边框颜色
 *
 *  - (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;
 */



/**************************************  RealReachability  使用介绍  **************************************/



/**
 *  pod 'RealReachability'
 *
 *  添加一个通知监听网络状态切换
 *
 *  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kRealReachabilityChangedNotification object:nil];
 *
 *  开启网络监测
 *
 *  [[RealReachability sharedInstance] startNotifier];
 *
 *
 *  网络改变通知调用方法
 *
 *  - (void)networkChanged:(NSNotification *)notification{
 *
 *      RealReachability *reachability = (RealReachability *)notification.object;
 *
 *      ReachabilityStatus status = [reachability currentReachabilityStatus];
 *
 *      if (status == RealStatusNotReachable)
 *      {
 *          当前无联网连接
 *      }
 *
 *      if (status == RealStatusViaWiFi)
 *      {
 *          已连接至WiFi
 *      }
 *
 *      WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
 *
 *      if (status == RealStatusViaWWAN)
 *      {
 *          if (accessType == WWANType2G)
 *          {
 *              已连接2G
 *          }else if (accessType == WWANType3G)
 *          {
 *              已连接3G
 *          }else if (accessType == WWANType4G)
 *          {
 *              已连接4G
 *          }else
 *          {
 *              未知网络
 *          }
 *      }
 *
 *  }
 *
 *
 *  取消网络状态监测
 *
 *  [[RealReachability sharedInstance] stopNotifier];
 */


/**************************************  JDStatusBarNotification  使用介绍  **************************************/



/**
 *   pod 'JDStatusBarNotification'
 *
 *   使用方法请参考  JDStatusBarNotification.h
 */


/**************************************  FXBlurView.h  使用介绍  **************************************/


/**
 *  #import "FXBlurView.h"
 *
 *  FXBlurView * bview = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 120, 100, 100)];
 *
 *  bview.tintColor = [UIColor whiteColor];  //前景颜色
 *
 *  bview.blurEnabled = YES;                //是否允许模糊，默认YES
 *
 *  bview.blurRadius = 10.0;               //模糊半径
 *
 *  bview.dynamic = YES;                   //动态改变模糊效果
 *
 *  bview.iterations = 2;                  //迭代次数：
 *
 *  bview.updateInterval = 2.0;            //更新时间（不确定具体功能）
 */


/**************************************  JSONKit.h  使用介绍  **************************************/



/**
 *  #import "JSONKit.h"
 *
 *  使用方法参考 JSONKit.h
 */


/**************************************  SWTableViewCell.h  使用介绍  **************************************/



/**
 *  #import "SWTableViewCell.h"   SWTableViewCellDelegate
 *
 *  SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
 *
 *  if (cell == nil) {
 *
 *      cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier     containingTableView:_tableView leftUtilityButtons:[self leftButtons] rightUtilityButtons:[self rightButtons]];
 *
 *      cell.delegate = self;
 *  }
 *
 *
 *  得到cell右边的按钮  可以自定义
 *
 *  - (NSArray *)rightButtons {
 *
 *      NSMutableArray *rightUtilityButtons = [NSMutableArray new];
 *
 *     [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0] title:@"More"];
 *
 *     [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
     title:@"Delete"];
 
 *     return rightUtilityButtons;
 * }
 *
 *
 *  得到cell左边的按钮  可以自定义
 *
 *  - (NSArray *)leftButtons {
 *
 *      NSMutableArray *leftUtilityButtons = [NSMutableArray new];
 
 *      [leftUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0] icon:[UIImage imageNamed:@"check.png"]];
 *
 *      [leftUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0] icon:[UIImage imageNamed:@"clock.png"]];
 *
 *      [leftUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0] icon:[UIImage imageNamed:@"cross.png"]];
 *
 *      [leftUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0] icon:[UIImage imageNamed:@"list.png"]];
 
 *      return leftUtilityButtons;
 *  }
 *
 *
 *  SWTableViewDelegate   左边的按钮点击事件
 *
 *  #pragma mark - SWTableViewDelegate
 *
 *  - (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
 *      switch (index) {
 *               case 0:
 *                  NSLog(@"left button 0 was pressed");
 *               break;
 *
 *               case 1:
 *                  NSLog(@"left button 1 was pressed");
 *               break;
 *
 *               case 2:
 *                  NSLog(@"left button 2 was pressed");
 *               break;
 *
 *               case 3:
 *                  NSLog(@"left btton 3 was pressed");
 *               break;
 *
 *               default:
 *               break;
 *    }
 *  }
 *
 *  右边的按钮点击事件
 *
 *- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
 *     switch (index) {
 *              case 0:{
 *                 NSLog(@"More button was pressed");
 *              }
 *              break;
 *
 *              case 1:{
 *                NSLog(@"Delete button was pressed");
 *              }
 *              break;
 *
 *              default:
 *              break;
 *     }
 *  }
 */


/**************************************  VVBlurViewController.h  使用介绍  **************************************/



/**
 *  #import "VVBlurViewController.h"
 *
 *  使用方法，需要继承 VVBlurViewController 
 *  
 *
 *  PresentedViewController 继承 VVBlurViewController
 *
 *  PresentedViewController *pvc = segue.destinationViewController;
 *
 *  第一种情况
 *  pvc.blurStyle = UIBlurEffectStyleLight;
 *
 *  第二种情况
 *  pvc.blurStyle = UIBlurEffectStyleDark;
 *
 */





#endif /* PodClassShowHowUser_h */
