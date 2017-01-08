//
//  HHHAudioPlayView.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHAudioPlayView.h"
#import "HHHAudioPlayModel.h"

#define kToolViewHeight     50

@interface HHHAudioPlayView ()

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong)AVPlayerLayer *playLayer;
@property (nonatomic,strong)UIProgressView *progressView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIButton *closeButton;
@property (nonatomic,strong)UIButton *showButton;
@property (nonatomic,strong)UIButton *playButton;
@property (nonatomic,strong)UIButton *downloadButton;
@property (nonatomic,strong)UIImageView *bgimageView;

@property (nonatomic,strong)UILabel *lab_currentTime;
@property (nonatomic,strong)UILabel *lab_totalTime;

@property (nonatomic,strong)UIView *toolView;
@property (nonatomic,strong)UIImageView *toolbgImg;

@property (nonatomic,strong)HHHAudioPlayModel *audioModel;


@property (nonatomic)BOOL isPlay;
@property (nonatomic)BOOL isBig;

@property (nonatomic)CGFloat videoHeight;

@property (nonatomic)CGFloat currentTime;
@property (nonatomic)CGFloat totalTime;


@end


@implementation HHHAudioPlayView


- (void)initSubView {
    _audioModel=[[HHHAudioPlayModel alloc]init];

    _bgimageView=[[UIImageView alloc]init];
    [self addSubview:_bgimageView];
    
  
    _toolView=[[UIView alloc]init];
    [self addSubview:_toolView];
    
    _toolbgImg=[[UIImageView alloc]init];
    [_toolView addSubview:_toolbgImg];
    
    _toolbgImg.backgroundColor=[UIColor blackColor];
    _toolbgImg.alpha=0.5;

    self.layer.masksToBounds=YES;
    
    
    [self addSubview:self.closeButton];
    [_toolView addSubview:self.showButton];
    [_toolView addSubview:self.playButton];
    [_toolView addSubview:self.downloadButton];
    [_toolView addSubview:self.progressView];
    [_toolView addSubview:self.lab_currentTime];
    [_toolView addSubview:self.lab_totalTime];
    
    [self addVideoNotic];
}

- (void)showWithData:(id)data inView:(UIView *)supView{
    
    _audioModel=(HHHAudioPlayModel *)data;
    
    _videoHeight=_audioModel.audioHeight*kSCREEN_WIDTH/_audioModel.audioWidth;

    
    NSURL * url  = [NSURL URLWithString:_audioModel.audioURL];
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //初始化player对象
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    _playLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //设置播放页面的大小
    _playLayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH, _videoHeight);
    //设置播放窗口和当前视图之间的比例显示内容
    _playLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.layer addSublayer:_playLayer];
    
    //设置播放的默认音量值
    self.player.volume = 1.0f;
    
    self.frame=CGRectMake(0, 20, kSCREEN_WIDTH, _videoHeight);
    
    self.backgroundColor=[UIColor greenColor];
    
    [supView addSubview:self];
    
    
    _bgimageView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, _videoHeight);
    [_bgimageView sd_setImageWithURL:[NSURL URLWithString:_audioModel.audioPicPath]];
    
    
    _toolView.frame=CGRectMake(0, self.height-kToolViewHeight, kSCREEN_WIDTH, kToolViewHeight);
    _toolbgImg.frame=CGRectMake(0, 0, kSCREEN_WIDTH, _toolView.height);

   
    
    //设置播放进度的默认值
    self.progressView.progress=0;
    

    _isPlay=YES;
    _isBig=NO;
    _currentTime=0.0;
    _totalTime=[NSString stringWithFormat:@"%@",_audioModel.audioTotalTime].intValue;

    self.lab_currentTime.text=@"00:00";
    self.lab_totalTime.text=[NSString formatDateWithSecond:self.totalTime];
    
    [self.timer fire];

    [self.player play];
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 5)];
        _progressView.trackTintColor=[UIColor whiteColor];
        _progressView.progressTintColor=kbaseColor;
    }
    return _progressView;
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

/**
 *  初始化放大缩小按钮
 */
- (UIButton *)showButton {
    if (_showButton == nil) {
        _showButton=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44, (kToolViewHeight-44)/2, 44, 44)];
        [_showButton setImage:[UIImage imageNamed:@"hhh_audio_showsmall"] forState:UIControlStateNormal];
        [_showButton addTarget:self action:@selector(showFrameAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _showButton;
}

/**
 *  初始化下载按钮
 */
- (UIButton *)downloadButton {
    if (_downloadButton == nil) {
        _downloadButton=[[UIButton alloc]initWithFrame:CGRectMake(0, (kToolViewHeight-44)/2, 44, 44)];
        [_downloadButton setImage:[UIImage imageNamed:@"hhh_audio_download"] forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downLoadAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _downloadButton;
}

/**
 *  初始化暂停播放按钮
 */
- (UIButton *)playButton {
    if (_playButton == nil) {
        _playButton=[[UIButton alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-44)/2, (kToolViewHeight-44)/2, 44, 44)];
        [_playButton setImage:[UIImage imageNamed:@"hhh_audio_zanting"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playAudioAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _playButton;
}

/**
 *  初始化正在播放的时间
 */
- (UILabel *)lab_currentTime {
    if (_lab_currentTime == nil) {
        _lab_currentTime=[[UILabel alloc]initWithFrame:CGRectMake(self.playButton.x-100, kToolViewHeight-20, 100, 20)];
        _lab_currentTime.textAlignment=NSTextAlignmentRight;
        _lab_currentTime.font=kSYS_FONT(12);
        _lab_currentTime.textColor=kbaseColor;
    }
    return _lab_currentTime;
}

/**
 *  初始化正在总时间
 */
- (UILabel *)lab_totalTime {
    if (_lab_totalTime == nil) {
        _lab_totalTime=[[UILabel alloc]initWithFrame:CGRectMake(self.playButton.x+self.playButton.width, kToolViewHeight-20, 100, 20)];
        _lab_totalTime.font=kSYS_FONT(12);
        _lab_totalTime.textColor=[UIColor whiteColor];
    }
    return _lab_totalTime;
}

/**
 *  点击播放或者暂停
 */
- (void)playAudioAction {
    [_timer invalidate];
    _timer = nil;
 
    
    if (_isPlay) {
        //暂停
        [_playButton setImage:[UIImage imageNamed:@"hhh_audio_bofang"] forState:UIControlStateNormal];
        _isPlay=NO;
        
        [self.player pause];
    }else{
        [_playButton setImage:[UIImage imageNamed:@"hhh_audio_zanting"] forState:UIControlStateNormal];
        _isPlay=YES;
        
        [self.player play];
        
        [self.timer fire];
    }
    

}


/**
 *  点击放大或缩小播放器页面
 */
- (void)showFrameAction {
    if (_isBig) {
        [_showButton setImage:[UIImage imageNamed:@"hhh_audio_showsmall"] forState:UIControlStateNormal];
        _isBig=NO;
        
        //变大
        [UIView animateWithDuration:0.25 animations:^{
            
            self.frame=CGRectMake(0, 20, kSCREEN_WIDTH, _videoHeight);
            _toolView.frame=CGRectMake(0, self.height-kToolViewHeight, kSCREEN_WIDTH, kToolViewHeight);
            
        } completion:^(BOOL finished) {
            
        }];

    }else{
        [_showButton setImage:[UIImage imageNamed:@"hhh_audio_showbig"] forState:UIControlStateNormal];
        _isBig=YES;
        
        //变小
        
        [UIView animateWithDuration:0.25 animations:^{
           
            self.frame=CGRectMake(0, 20, kSCREEN_WIDTH, 50+kToolViewHeight);
            _toolView.frame=CGRectMake(0, self.height-kToolViewHeight, kSCREEN_WIDTH, kToolViewHeight);

        } completion:^(BOOL finished) {
            
        }];
    }
}


/**
 *  点击下载按钮
 */
- (void)downLoadAction {
    NSString *audioName=[NSString stringWithFormat:@"%@.mp3",_audioModel.audioTitle];
    if ([[FileManager shareIntance] isHasThisVedio:audioName]) {
        [HHHProgressHUD showProgressHUDMessage:@"该音频已经下载" inView:self];

        return;
    }
    
    [HHHProgressHUD showProgressHUDMessage:@"音频进入后台下载" inView:self];

    [[AFHTTPClickManager shareInstance] downLoadRequestWithURL:_audioModel.audioURL filePath:[[FileManager shareIntance] audeoFilePath] contentName:audioName progressBlock:^(CGFloat progress) {
        NSLog(@"progress  %f",progress);
    } completSuccessBlock:^(NSString *filePath) {
        NSLog(@"下载成功%@",filePath);
    } failureBlock:^(NSError *error) {
        NSLog(@"下载失败  %@",error);
    }];
}


/**
 *  播放时间，每秒改变
 *
 */
- (NSTimer *)timer {
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired)userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    return _timer;
}

/**
 *  每秒钟改变进度条的值
 */
- (void)timerFired {
    
    _currentTime = CMTimeGetSeconds([self.player currentTime]);

    _lab_currentTime.text=[NSString formatDateWithSecond:_currentTime];
    
    [self.progressView setProgress:_currentTime/_totalTime animated:YES];
}


/**
 *  关闭音频播放器
 */
- (void)close {
    [_timer invalidate];
    _timer = nil;
    
    [self removeVideoNotic];

    [_delegate didSelectHHHAudioPlayViewClose];
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemTimeJumpedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//播放结束
- (void)movieToEnd:(NSNotification *)notic {
    NSLog(@"播放结束movieToEnd  %@",NSStringFromSelector(_cmd));
    
    [_timer invalidate];
    _currentTime =0.0;
    _isPlay=NO;
    [_playButton setImage:[UIImage imageNamed:@"hhh_audio_bofang"] forState:UIControlStateNormal];
    [self.player seekToTime:CMTimeMakeWithSeconds(0, 1) completionHandler:^(BOOL finished) {
    }];
    [_progressView setProgress:0.0 animated:YES];
    self.lab_currentTime.text=@"00:00";
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


@end
