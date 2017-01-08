//
//  BaseViewController.h
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftNarBarBlock)(void);
typedef void(^RightNarBarBlock)(void);

typedef void(^RightNarBarBlockLeft)(void);
typedef void(^RightNarBarBlockRight)(void);

@interface BaseViewController : UIViewController <UIActionSheetDelegate,MWPhotoBrowserDelegate>

@property (nonatomic,copy)LeftNarBarBlock leftNavBarBlock;
@property (nonatomic,copy)RightNarBarBlock rightNavBarBlock;
@property (nonatomic,copy)RightNarBarBlockLeft rightNavBarBlockLeft;
@property (nonatomic,copy)RightNarBarBlockRight rightNavBarBlockRight;

- (void)initDataSource;

- (void)initSubViews;

- (void)initLeftNavigationBarButton;

- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title;

- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName;

- (void)initRithNavigationBarButtonWithTitle:(NSString *)title;

- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName;

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2;

- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (void)headerRefreshHiddent:(BOOL)hiddent;

- (void)footerRefreshHiddent:(BOOL)hiddent;

- (void)headerEndRefresh;

- (void)footerEndRefresh;

- (void)endRefresh;


/**
 *  点击放大图片
 *
 *  @param selectIndex 点击的第几张图片
 *  @param photos      图片数组
 */
- (void)jumpBigImageWithSelectIndex:(NSInteger)selectIndex WithPhotos:(NSMutableArray *)photos;


/**
 *  获取系统版本号
 *
 *  @return 返回系统版本号
 */
- (NSString *)deviceName;

- (void)showMessage:(NSString *)msg;
@end
