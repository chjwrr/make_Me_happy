//
//  AppDelegate.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "JPUSHService.h"

#import "BaseNavigationController.h"
#import "BaseTabBarViewController.h"

#import "HHHBetterViewController.h"
#import "HHHMeiTuViewController.h"
#import "HHHVedioViewController.h"
#import "HHHSettingViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

/*键盘设置*/
- (void)IQKeyboardInitSet {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10];
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //sleep(3);
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    [self configSetting];
    
    BaseNavigationController *nav1=[[BaseNavigationController alloc]initWithRootViewController:[[HHHBetterViewController alloc]init]];
    BaseNavigationController *nav2=[[BaseNavigationController alloc]initWithRootViewController:[[HHHMeiTuViewController alloc]init]];
    BaseNavigationController *nav3=[[BaseNavigationController alloc]initWithRootViewController:[[HHHVedioViewController alloc]init]];
    BaseNavigationController *nav4=[[BaseNavigationController alloc]initWithRootViewController:[[HHHSettingViewController alloc]init]];
    
    nav4.hidesBottomBarWhenPushed=YES;
    nav3.hidesBottomBarWhenPushed=YES;
    nav2.hidesBottomBarWhenPushed=YES;
    nav1.hidesBottomBarWhenPushed=YES;

    BaseTabBarViewController *tabbar=[[BaseTabBarViewController alloc]init];
    tabbar.viewControllers=@[nav1,nav2,nav3,nav4];
    
    
    self.window.rootViewController=tabbar;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configSetting {
    
    //机器码
    //NSString *udid=[DeviceUUID getKeychainIdentifier];
    
    
    //键盘设置
    [self IQKeyboardInitSet];
    
    //缓存目录
    [[FileManager shareIntance] creatMyWayFilePath];

    
    /*
    //极光推送设置
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [JPUSHService setTags:sett alias:(NSString *)kgetDefaultValueForKey(KUserID) fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
     
     }];
     });
     
     
     */
}
/**
 *  当有电话进来或者锁屏，这时你的应用程会挂起，在这时，UIApplicationDelegate委托会收到通知，调用 applicationWillResignActive 方法，你可以重写这个方法，做挂起前的工作，比如关闭网络，保存数据。
 *
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  进入后台
 *
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

/**
 *  这个方法是从后台将要进入前台时运行的
 *
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

/**
 *  进入前台
 *
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    //进入前台，开启定位服务
    //[[LocationManager shareInStance] startUserLocation];
}

/**
 *  当用户按下按钮，或者关机，程序都会被终止。当一个程序将要正常终止时会调用 applicationWillTerminate方法。但是如果长主按钮强制退出 ，则不会调用该方法。这个方法该执行剩下的清理工作，比如所有的连接都能正常关闭，并在程序退出前执行任何其他的必要的工作
 *
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*极光推送*/
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"收到通知在此提示:%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

@end
