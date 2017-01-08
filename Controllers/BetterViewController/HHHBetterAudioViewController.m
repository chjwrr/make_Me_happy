//
//  HHHBetterAudioViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterAudioViewController.h"
#import "HHHBetterAudioCell.h"
#import "HHHAudioPlayModel.h"
#import "HHHAudioPlayView.h"

#define kmaxTime    @"maxtime"

@interface HHHBetterAudioViewController ()<UITableViewDataSource,UITableViewDelegate,HHHAudioPlayViewDelegate,HHHBetterAudioCellDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)HHHAudioPlayView *audioPlayView;

@property (nonatomic)NSInteger page;
@property (nonatomic,strong)NSString *maxtime;

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation HHHBetterAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    NSLog(@"声音");

}

- (void)initDataSource {
    
    _page=1;
    
    _dataSource=[[NSMutableArray alloc]init];
    _maxtime=[[NSString alloc]init];
    
    
    NSDate *date=[NSDate date];
    
    int interval=[date timeIntervalSince1970];
    
    _maxtime=[NSString stringWithFormat:@"%d",interval];
    
}

- (void)initSubViews {
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
    
}


- (HHHAudioPlayView *)audioPlayView {
    if (_audioPlayView  == nil) {
        _audioPlayView=[[HHHAudioPlayView alloc]init];
        _audioPlayView.delegate=self;
    }
    return _audioPlayView;
}



/**
 *  关闭音频播放器界面
 */
- (void)didSelectHHHAudioPlayViewClose {
    [_audioPlayView removeFromSuperview];
    _audioPlayView = nil;
}


/**
 *  刷新数据
 */
- (void)refreshData {
    
    _page=1;
    
    NSDate *date=[NSDate date];
    
    int interval=[date timeIntervalSince1970];
    
    _maxtime=[NSString stringWithFormat:@"%d",interval];
    
    
    [self.dataSource removeAllObjects];
    
    [self audioRequest];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    HHHAudioPlayModel *lastModel=[_dataSource lastObject];
    
    _maxtime=lastModel.maxTime;
    
    [self audioRequest];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_dataSource count] == 0) {
        return 0;
    }
    
    if (indexPath.row >= [_dataSource count]) {
        return 0;
    }
    HHHAudioPlayModel *model=[_dataSource objectAtIndex:indexPath.row];
    return [HHHBetterAudioCell cellHeightForData:model];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"HHHBetterAudioCell";
    
    HHHBetterAudioCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell=[[HHHBetterAudioCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if ([_dataSource count] != 0 && indexPath.row < [_dataSource count]) {
        cell.delegate=self;
        cell.tag=100+indexPath.row;
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHHBetterAudioCell *selectCell=[_tableView cellForRowAtIndexPath:indexPath];
    [self showSaveAndReportAlert:selectCell.imageview.image];

}

/*
 节操圈子
 */

- (void)audioRequest {
    NSString *str_url=[NSString stringWithFormat:@"https://api.budejie.com/api/api_open.php?a=list&c=data&type=31&page=%ld&maxtime=%@",(long)_page,_maxtime];

    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *list=[respose objectForKey:@"list"];
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            
            HHHAudioPlayModel *model=[[HHHAudioPlayModel alloc]init];
            
            model.audioURL=kFormatterSring([diction objectForKey:@"voiceuri"]);
            model.audioPicPath=kFormatterSring([diction objectForKey:@"bimageuri"]);
            model.audioTotalTime=kFormatterSring([diction objectForKey:@"voicetime"]);
            model.audioCreatTime=kFormatterSring([diction objectForKey:@"t"]).doubleValue;
            
            NSString *titlee=kFormatterSring([diction objectForKey:@"text"]);
            NSArray *titles=[titlee componentsSeparatedByString:@"\n"];
            if ([titles count] == 1) {
                model.audioTitle=titlee;
            }else{
                model.audioTitle=[titles objectAtIndex:1];
            }
            
            model.maxTime=kFormatterSring([diction objectForKey:@"t"]);
            model.audioHeight=kFormatterSring([diction objectForKey:@"height"]).floatValue;
            model.audioWidth=kFormatterSring([diction objectForKey:@"width"]).floatValue;

            [_dataSource addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
}

/**
 *  HHHBetterAudioCell Delegate
 *
 *  @param index 点击的第几个cell
 */
- (void)didSelectHHHBetterAudioCellIndex:(NSInteger)index {
    [self.audioPlayView showWithData:[_dataSource objectAtIndex:index] inView:self.view];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
