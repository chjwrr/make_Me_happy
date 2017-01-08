//
//  BaseViewController+category.m
//  ModelProduct
//
//  Created by apple on 16/10/18.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController+category.h"


static const void *imagekey;


@implementation BaseViewController (category)

- (UIImage*)saveImage {
    return objc_getAssociatedObject(self, &imagekey);
}

- (void)setSaveImage:(UIImage *)saveImage {
    objc_setAssociatedObject(self, imagekey, saveImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)showSaveAndReportAlert:(UIImage *)image {
    self.saveImage=[[UIImage alloc]init];
    self.saveImage=image;
    
    if (kAPP_System_Version >= 8.0) {
        UIAlertController *alertCtrl=[UIAlertController alertControllerWithTitle:nil message:@"你想进行什么操作？" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self saveImageToPhone:image];
            
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [HHHProgressHUD showProgressHUDMessage:@"举报成功,我们会尽快处理您的请求!" inView:self.view];
            
        }];
        UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertCtrl addAction:action1];
        [alertCtrl addAction:action2];
        [alertCtrl addAction:action3];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"你想进行什么操作？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片",@"举报", nil];
        [sheet showInView:self.view];
    }

}


//保存图片
- (void)saveImageToPhone:(UIImage *)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

//保存图片回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        //保存失败
        [HHHProgressHUD showProgressHUDMessage:@"保存失败" inView:self.view];
        
    }else{
        //保存成功
        [HHHProgressHUD showProgressHUDMessage:@"保存成功" inView:self.view];
        
    }
}

/**
 *  UIActionSheet Delegate
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //保存图片
        [self saveImageToPhone:self.saveImage];
    }
    if (buttonIndex == 1){
        //举报
        [HHHProgressHUD showProgressHUDMessage:@"举报成功,我们会尽快处理您的请求!" inView:self.view];
        
    }
}


@end
