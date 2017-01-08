//
//  HHHVedioPlayView.m
//  ModelProduct
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHVedioPlayView.h"
#import <AVFoundation/AVFoundation.h>
#import "HHHVedioPlayModel.h"

@interface HHHVedioPlayView ()

@property (strong, nonatomic) UISlider *progressSlider;
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)AVPlayerLayer *playLayer;

@property (nonatomic,strong)UIImageView *bgimageView;
@property (nonatomic,strong)UIView *toolView;
@property (nonatomic,strong)UIButton *playButton;
@property (nonatomic,strong)UIButton *downButton;
@property (nonatomic,strong)UIButton *closeButton;
@property (nonatomic,strong)UILabel *lab_time;
@property (nonatomic,strong)UILabel *lab_playtime;
@property (nonatomic,strong)UILabel *lab_size;
@property (nonatomic,strong)UIButton *btn_cover;

@property (nonatomic)int totalTime;

@property (nonatomic)CGFloat currentTime;

@property (nonatomic,strong)NSTimer *time;

@property (nonatomic,strong)NSTimer *time_dismiss;

@property (nonatomic)BOOL isPlay;

@property (nonatomic)BOOL isShowTool;

@property (nonatomic,strong)HHHVedioPlayModel *vedioModel;

@end

@implementation HHHVedioPlayView



- (void)initSubView {
    
    _vedioModel=[[HHHVedioPlayModel alloc]init];
    
    
    _bgimageView=[[UIImageView alloc]init];
    [self addSubview:_bgimageView];
    _bgimageView.backgroundColor=[UIColor blackColor];
    _bgimageView.alpha=0.5;
    
    
    _btn_cover=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, 0)];
    [self addSubview:_btn_cover];
    [_btn_cover addTarget:self action:@selector(toolViewHiddentAction) forControlEvents:UIControlEventTouchUpInside];
    
    _toolView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-50, kSCREEN_WIDTH, 50)];
    [self addSubview:_toolView];
    
    
    UIImageView *bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, kSCREEN_WIDTH, _toolView.height-10)];
    [_toolView addSubview:bgimageV];
    bgimageV.backgroundColor=[UIColor blackColor];
    bgimageV.alpha=0.5;

    
    [_toolView addSubview:self.progressSlider];
    
    [_toolView addSubview:self.playButton];
    
    [_toolView addSubview:self.downButton];
    
    [_toolView addSubview:self.lab_time];
    
    [_toolView addSubview:self.lab_playtime];
    
    [_toolView addSubview:self.lab_size];
    
    
    [self addVideoNotic];

}

- (void)showWithData:(id)data inView:(UIView *)supView Y:(CGFloat)yyy{
    _isShowTool=NO;
    _isPlay = NO;
    
    [_playLayer removeFromSuperlayer];
    _player = nil;
 
    self.layer.masksToBounds=YES;
    
    _vedioModel=(HHHVedioPlayModel *)data;
    
    
    
    CGFloat videoHeight=_vedioModel.vedioHeight*kSCREEN_WIDTH/_vedioModel.vedioWidth;
    
    
    
    NSURL *vedioURL=[NSURL URLWithString:_vedioModel.vedioURL];
    
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:vedioURL];
    //初始化player对象
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    _playLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //设置播放页面的大小
    _playLayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH, videoHeight);
    //设置播放窗口和当前视图之间的比例显示内容
    _playLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.layer addSublayer:_playLayer];
    
    //设置播放进度的默认值
    self.progressSlider.value = 0;
    //设置播放的默认音量值
    self.player.volume = 1.0f;
    
    self.frame=CGRectMake(0, yyy, kSCREEN_WIDTH, videoHeight);

    _bgimageView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, videoHeight);
    
    
    [supView addSubview:self];
    
    
    [self addSubview:self.closeButton];

    _btn_cover.frame=CGRectMake(0, 0, kSCREEN_WIDTH, videoHeight);

 
    _totalTime=[NSString stringWithFormat:@"%@",_vedioModel.vedioTotalTime].intValue-1;
    _currentTime=0.0;
    
    _lab_time.text=[NSString formatDateWithSecond:self.totalTime];

    _lab_size.text=_vedioModel.vedioSize;
    
    
    [_playButton setImage:[UIImage imageNamed:@"hhh_vedio_bo_fang"] forState:UIControlStateNormal];
    
    _lab_playtime.text=@"00:00";
    
    _progressSlider.value=0;
    
    _toolView.frame=CGRectMake(0, videoHeight, kSCREEN_WIDTH, 50);

    
    [self bringSubviewToFront:_toolView];
    
    [self.player play];

    [self.time fire];

}
/**
 *  播放时间，每秒改变
 *
 */
- (NSTimer *)time {
    [_time invalidate];
    _time = nil;
    
    _time = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired)userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_time forMode:NSDefaultRunLoopMode];

    return _time;
}

/**
 *  5秒后隐藏工具栏
 *
 */
- (NSTimer *)time_dismiss {
    [_time_dismiss invalidate];
    _time_dismiss = nil;
    
    _time_dismiss = [NSTimer timerWithTimeInterval:1  target:self selector:@selector(dismissToolView)userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:_time_dismiss forMode:NSDefaultRunLoopMode];
    
    return _time_dismiss;
}

/**
 *  点击显示、隐藏 toolView
 */
- (void)toolViewHiddentAction {
    
    [_time_dismiss invalidate];

    if (!_isShowTool) {
        //显示

        [UIView animateWithDuration:0.15 animations:^{
            _toolView.frame=CGRectMake(0, self.height-50, kSCREEN_WIDTH, 50);

        } completion:^(BOOL finished) {
            if (finished) {
                [self.time_dismiss fire];
                _isShowTool = YES;
            }
        }];
        
    }else{
        //隐藏
        [UIView animateWithDuration:0.15 animations:^{
            _toolView.frame=CGRectMake(0, self.height, kSCREEN_WIDTH, 50);
            
        } completion:^(BOOL finished) {
            if (finished) {
                [_time_dismiss invalidate];
                _isShowTool = NO;
            }
        }];
    }
}


/**
 *  5秒后  隐藏下面的框
 */
- (void)dismissToolView {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 animations:^{
            _toolView.frame=CGRectMake(0, self.height, kSCREEN_WIDTH, 50);
            
        } completion:^(BOOL finished) {
            if (finished) {
                [_time_dismiss invalidate];
            }
        }];
        _isShowTool=NO;

    });
    
  }


/**
 *  初始化进度条
 */
- (UISlider *)progressSlider {
    if (_progressSlider == nil) {
        _progressSlider=[[UISlider alloc]initWithFrame:CGRectMake(90, 27, kSCREEN_WIDTH-180, 10)];
        [_progressSlider setValue:0.5 animated:YES];
        _progressSlider.minimumValue=0;
        _progressSlider.maximumValue=1;
        
        _progressSlider.minimumTrackTintColor=kColorHexString(@"ea8010");
        _progressSlider.maximumTrackTintColor=[UIColor whiteColor];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"hhh_vedio_ThumbImage"] forState:UIControlStateNormal];
        
        [_progressSlider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventValueChanged];
        [_progressSlider addTarget:self action:@selector(changeProgressTouchUp) forControlEvents:UIControlEventTouchUpInside];
    }
    return _progressSlider;
   
}


/**
 *  初始化播放暂停按钮
 */
- (UIButton * )playButton {
    if (_playButton == nil) {
        _playButton=[[UIButton alloc]initWithFrame:CGRectMake(0, _toolView.height-44, 44, 44)];
        [_playButton setImage:[UIImage imageNamed:@"hhh_vedio_bo_fang"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(startPlayer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

/**
 *  初始下载按钮
 */
- (UIButton *)downButton {
    if (_downButton == nil) {
        _downButton=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44, _toolView.height-44, 44, 44)];
        [_downButton setImage:[UIImage imageNamed:@"hhh_vedio_xia_zai"] forState:UIControlStateNormal];
        [_downButton addTarget:self action:@selector(downLoadVedio) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _downButton;
}


/**
 *  初始化视频播放时间
 */
- (UILabel *)lab_time {
    if (_lab_time == nil) {
        _lab_time=[[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-35-50, _downButton.y+17, 45, 10)];
        _lab_time.textColor=[UIColor whiteColor];
        _lab_time.textAlignment=NSTextAlignmentCenter;
        _lab_time.font=kSYS_FONT(12);
    }
    return  _lab_time;
}

/**
 *  初始化视频正在播放时间
 */
- (UILabel *)lab_playtime {
    if (_lab_playtime == nil) {
        _lab_playtime=[[UILabel alloc]initWithFrame:CGRectMake(40, _lab_time.y, 45, 10)];
        _lab_playtime.textColor=[UIColor whiteColor];
        _lab_playtime.textAlignment=NSTextAlignmentCenter;
        _lab_playtime.font=kSYS_FONT(12);
        _lab_playtime.text=@"00:00";
    }
    return _lab_playtime;
}

/**
 *  初始化视频大小
 */
- (UILabel *)lab_size {
    if (_lab_size == nil) {
        _lab_size=[[UILabel alloc]initWithFrame:CGRectMake(_lab_time.x, _lab_time.y+10+5, _lab_time.width, 10)];
        _lab_size.textAlignment=NSTextAlignmentCenter;
        _lab_size.textColor=kColorHexString(@"ea8010");
        _lab_size.font=kSYS_FONT(12);
    }
    return _lab_size;
}


/**
 *  初始化关闭按钮
 */
- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44, 0, 44, 44)];
        [_closeButton setImageEdgeInsets:UIEdgeInsetsMake(-12, 0, 0, -12)];
        [_closeButton setImage:[UIImage imageNamed:@"hhh_vedio_guan_bi"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];

    }
    return _closeButton;
}

#pragma mark - 开始按钮响应方法
- (void)startPlayer{
    if (_isPlay) {
        //正在不播放，点击暂停
        [self.player pause];
        
        [_playButton setImage:[UIImage imageNamed:@"hhh_vedio_bo_fang"] forState:UIControlStateNormal];
        
        _isPlay=NO;
        
        [_time invalidate];//暂停
        
    }else{
        [self.player play];
        
        [_playButton setImage:[UIImage imageNamed:@"hhh_vedio_zan_ting"] forState:UIControlStateNormal];
        
        _isPlay=YES;

        [self.time fire];//启动

    }
    
    [self.time_dismiss fire];
}


/**
 *  拖动slider ,暂停视频播放
 */
- (void)changeProgress:(UISlider *)slider {
    //CMTimeMake(a,b) a表示当前时间，b表示每秒钟有多少帧
    
    [self.player pause];
    
    [_time invalidate];
    [_time_dismiss invalidate];
    
    _isPlay=NO;

    [self.player seekToTime:CMTimeMakeWithSeconds(_totalTime*_progressSlider.value, 1) completionHandler:^(BOOL finished) {
        
        _currentTime = CMTimeGetSeconds([self.player currentTime]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            int second = (int)_currentTime+1;
            self.lab_playtime.text=[NSString formatDateWithSecond:second];
 
        });
        
    }];

}

/**
 *  拖动slider  手指抬起时  播放
 */
- (void)changeProgressTouchUp {
    
    [_playButton setImage:[UIImage imageNamed:@"hhh_vedio_zan_ting"] forState:UIControlStateNormal];
    
    [self.player play];
    
    _isPlay=YES;
    
    [self.time fire];
    
    [self.time_dismiss fire];

}


/**
 *  时间，每秒调用，改变已播放的时间
 */
- (void)timerFired {
    
    
    _currentTime = CMTimeGetSeconds([self.player currentTime]);
    
    float second = (float)_currentTime+1;
    
    self.lab_playtime.text=[NSString formatDateWithSecond:second];
    
    
    [_progressSlider setValue:second/_totalTime animated:YES];

}

/**
 *  添加视频播放通知
 */
- (void)addVideoNotic {
    
    //Notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieJumped:) name:AVPlayerItemTimeJumpedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieStalle:) name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backGroundPauseMoive) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}

/**
 *  移除通知
 */
- (void)removeVideoNotic {
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemTimeJumpedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//播放结束
- (void)movieToEnd:(NSNotification *)notic {
    NSLog(@"播放结束movieToEnd  %@",NSStringFromSelector(_cmd));
    
    [_time invalidate];
    _currentTime =0.0;
    _isPlay=NO;
    [_playButton setImage:[UIImage imageNamed:@"hhh_vedio_bo_fang"] forState:UIControlStateNormal];
    [self.player seekToTime:CMTimeMakeWithSeconds(0, 1) completionHandler:^(BOOL finished) {
    }];
    [_progressSlider setValue:0.0 animated:YES];
    self.lab_playtime.text=@"00:00";
}
- (void)movieJumped:(NSNotification *)notic {
    NSLog(@"播放状态改变movieJumped  %@",NSStringFromSelector(_cmd));
}
- (void)movieStalle:(NSNotification *)notic {
    NSLog(@"movieStalle  %@",NSStringFromSelector(_cmd));
}
- (void)backGroundPauseMoive {
    NSLog(@"backGroundPauseMoive  %@",NSStringFromSelector(_cmd));
}

/**
 *  下载视频
 */
- (void)downLoadVedio {

    NSString *vedioName=[NSString stringWithFormat:@"%@.mp4",_vedioModel.vedioTitle];
    
    if ([[FileManager shareIntance] isHasThisVedio:vedioName]) {
        [HHHProgressHUD showProgressHUDMessage:@"该视频已经下载" inView:self];
        return;
    }
    
    [HHHProgressHUD showProgressHUDMessage:@"视频进入后台下载" inView:self];

     [[AFHTTPClickManager shareInstance] downLoadRequestWithURL:_vedioModel.vedioURL filePath:[[FileManager shareIntance] videoFilePath] contentName:vedioName progressBlock:^(CGFloat progress) {
     NSLog(@"progress  %f",progress);
     } completSuccessBlock:^(NSString *filePath) {
     NSLog(@"下载成功%@",filePath);
     } failureBlock:^(NSError *error) {
     NSLog(@"下载失败  %@",error);
     }];

}

/**
 *  关闭视频播放页面
 */
- (void)close {
    
    [_time invalidate];
    _time = nil;
    
    [_time_dismiss invalidate];
    _time_dismiss = nil;
    
    
    [self removeVideoNotic];
    
    [_delegate didSelectHHHVedioPlayViewColse];

}


@end
