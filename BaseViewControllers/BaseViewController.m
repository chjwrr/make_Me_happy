//
//  BaseViewController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseViewController.h"
#import "MWPhotoBrowser.h"
#import "sys/utsname.h"


@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)MJRefreshNormalHeader *header;
@property (nonatomic,strong)MJRefreshBackNormalFooter *footer;


@property (nonatomic,strong)NSMutableArray *photos;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initDataSource];
    
    [self initSubViews];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initDataSource {
    
}
- (void)initSubViews {
    
}

- (void)initLeftNavigationBarButton {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_left setImage:[UIImage imageNamed:@"hhh_navigation_backimage"] forState:UIControlStateNormal];

    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}

- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setTitle:title forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}

- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}


- (void)initRithNavigationBarButtonWithTitle:(NSString *)title {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setTitle:title forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2 {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn_right.tag=101;
    //[btn_right setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn_right1=[[UIButton alloc]initWithFrame:CGRectMake(44, 0, 44, 44)];
    [btn_right1 setBackgroundColor:[UIColor greenColor]];
    //[btn_right1 setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right1 addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    btn_right1.tag=100;
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithCustomView:btn_right1];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar,space,bar1,space];
}
- (void)BackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)leftAction {
    self.leftNavBarBlock();
}
- (void)RightAction {
    self.rightNavBarBlock();
}
- (void)doubleRightAction:(UIButton *)button {
    if (button.tag == 100) {
        self.rightNavBarBlockLeft();
    }else
        self.rightNavBarBlockRight();
    
}

//tableview下拉刷新  上拉加载

/*
 self.tableview.mj_header=[self addTableViewRefreshHeaderWithTarget:self action:@selector(headerRefresh)];
 self.tableview.mj_footer=[self addTableViewRefreshFooterWithTarget:self action:@selector(footerRefresh)];
 
 */
- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _header=[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    return _header;
}

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    return _footer;
}
- (void)headerRefreshHiddent:(BOOL)hiddent {
    self.header.hidden=hiddent;
}
- (void)footerRefreshHiddent:(BOOL)hiddent {
    self.footer.hidden=hiddent;
}
- (void)headerEndRefresh {
    [self.header endRefreshing];
}
- (void)footerEndRefresh {
    [self.footer endRefreshing];
}
- (void)endRefresh {
    [self.header endRefreshing];
    [self.footer endRefreshing];
}



/**
 *  MWPhotoBrowser
 *
 *  @param selectIndex  点击查看大图
 */

- (void)jumpBigImageWithSelectIndex:(NSInteger)selectIndex WithPhotos:(NSMutableArray *)photos{
    
    _photos=[[NSMutableArray alloc]initWithArray:photos];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;//弹出分享保存等选项右上方
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = NO;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:selectIndex];
    
    self.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:browser animated:YES];
    
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    return nil;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return YES;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  获取系统版本号
 *
 *  @return 返回系统版本号
 */
- (NSString *)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"phone4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"phone4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"phone4";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"phone5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"phone5";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"phone5";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"phone5";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"phone5";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"phone5";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"phone6plass";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"phone6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"phone6";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"phone6plass";
    return @"";
}

- (void)showMessage:(NSString *)msg {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = msg;
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1];
}

@end
