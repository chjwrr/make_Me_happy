//
//  CHJShowImageView.m
//  ModelProduct
//
//  Created by apple on 16/10/18.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "CHJShowImageView.h"


@interface CHJShowImageView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic)CGRect beginRect;

@property (nonatomic,copy)CHJShowImageViewDismissBlock dismissBlock;

@end
@implementation CHJShowImageView

+ (instancetype)shareInstance {
    static CHJShowImageView *view=nil;
    static dispatch_once_t oncet;
    dispatch_once(&oncet, ^{
        view=[[CHJShowImageView alloc]initSelf];
    });
    return view;
}

- (instancetype)initSelf {
    self=[super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    self.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self addSubview:_scrollView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_scrollView addGestureRecognizer:tap];
    _scrollView.delegate=self;
    
    //图片的缩放
    _scrollView.minimumZoomScale=0.5;
    _scrollView.maximumZoomScale=2;
    
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [_scrollView addSubview:_imageView];
    
    UIButton *downBtn=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44, 10, 44, 44)];
    [self addSubview:downBtn];
    [downBtn addTarget:self action:@selector(downAction) forControlEvents:UIControlEventTouchUpInside];
    [downBtn setImage:kImageName(@"hhh_meitu_download") forState:UIControlStateNormal];

    UIButton *reportBtn=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44-44-10, 10, 44, 44)];
    [self addSubview:reportBtn];
    [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
    [reportBtn setImage:kImageName(@"hhh_meitu_report") forState:UIControlStateNormal];

}


- (void)showImageURL:(NSString *)imageURL BeginFrame:(CGRect)rect dismissComplete:(CHJShowImageViewDismissBlock)disBlock {
    
    _dismissBlock=disBlock;

    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    _beginRect=rect;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    
    //图片的起始位置
    _imageView.frame=CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);

    //图片最终位置的高度
    CGFloat imageHeight=rect.size.height/rect.size.width*kSCREEN_WIDTH;
    
    CGFloat imageY=0.0;
    if (imageHeight >= kSCREEN_HEIGHT) {
        //超出屏幕的高度，Y 从0 开始，可以滚动
        imageY=0.0;
    }else{
        //不可以滚动，上下居中
        imageY=(kSCREEN_HEIGHT-imageHeight)/2;
    }
    
    //动画显示
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.frame=CGRectMake(0, imageY, kSCREEN_WIDTH, imageHeight);
        self.backgroundColor=[UIColor whiteColor];
    } completion:^(BOOL finished) {
        if (finished) {
            if (rect.size.height >=kSCREEN_HEIGHT) {
                [_scrollView setContentSize:CGSizeMake(kSCREEN_WIDTH, imageHeight)];
            }
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        
        _imageView.frame=CGRectMake(_beginRect.origin.x, _beginRect.origin.y, _beginRect.size.width, _beginRect.size.height);
        self.backgroundColor=[UIColor clearColor];

    } completion:^(BOOL finished) {
        if (finished) {
            _dismissBlock();
            [_scrollView setZoomScale:1 animated:YES];

            [self removeFromSuperview];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

        }
    }];
}


//返回要缩放的控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    [_scrollView setZoomScale:scale animated:YES];
    
    if (scale < 1.0) {
        _imageView.frame=CGRectMake((kSCREEN_WIDTH-view.width)/2, (kSCREEN_HEIGHT-view.height)/2, view.width, view.height);
    }else
        _imageView.frame=CGRectMake(0, 0, view.width, view.height);

}

// 保存
- (void)downAction {
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
//保存图片回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        //保存失败
        [HHHProgressHUD showProgressHUDMessage:@"保存失败" inView:self];
        
    }else{
        //保存成功
        [HHHProgressHUD showProgressHUDMessage:@"保存成功" inView:self];
        
    }
}

//举报
- (void)reportAction {
    [HHHProgressHUD showProgressHUDMessage:@"举报成功,我们会尽快处理您的请求!" inView:self];

}




@end
