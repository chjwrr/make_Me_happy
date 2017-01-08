//
//  HHHBetterVideoViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterVideoViewController.h"
#import "HHHBetterVedioCell.h"
#import "HHHVedioPlayModel.h"
#import "HHHVedioPlayView.h"


@interface HHHBetterVideoViewController ()<UITableViewDataSource,UITableViewDelegate,HHHVedioPlayViewDelegate,HHHBetterVedioCellDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)HHHVedioPlayView *vedioPlayView;

@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger page;
@property (nonatomic,strong)NSString *maxtime;

@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HHHBetterVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initDataSource {
    _pageSize = 10;
   
    _page=0;
    
    _dataSource=[[NSMutableArray alloc]init];
    _maxtime=[[NSString alloc]init];
    _maxtime=@"0";

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

- (HHHVedioPlayView *)vedioPlayView {
    if (_vedioPlayView  == nil) {
        _vedioPlayView=[[HHHVedioPlayView alloc]init];
        _vedioPlayView.delegate=self;
    }
    return _vedioPlayView;
}


/**
 *  HHHVedioPlayView Delegate   点击视频关闭按钮
 */

- (void)didSelectHHHVedioPlayViewColse {
    [_vedioPlayView removeFromSuperview];
    _vedioPlayView = nil;
}



/**
 *  刷新数据
 */
- (void)refreshData {
    
    _page=0;
    
    _maxtime=@"0";
    
    [self.dataSource removeAllObjects];

    
    [self videoRequest1];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    HHHVedioPlayModel *lastModel=[_dataSource lastObject];
    
    _maxtime=lastModel.maxTime;
    
    [self videoRequest1];
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
    HHHVedioPlayModel *model=[_dataSource objectAtIndex:indexPath.row];
    return [HHHBetterVedioCell cellHeightForData:model];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"HHHBetterVedioCell";
    
    HHHBetterVedioCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell=[[HHHBetterVedioCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if ([_dataSource count] != 0 && indexPath.row < [_dataSource count]) {
        cell.delegate=self;
        cell.tag=100+indexPath.row;
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

/*
 内涵妹子
 */

- (void)videoRequest1 {
    
    NSString *str_url=[NSString stringWithFormat:@"https://api.jiefu.tv/app2/api/article/list.html?mediaType=2&deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=%ld&pageSize=%ld",(long)_page,(long)_pageSize];
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        if ([kFormatterSring([respose objectForKey:@"code"]) isEqualToString:@"0"]) {
            NSArray *data=[respose objectForKey:@"data"];

            if (_page == 0) {
                //加载第一页数据，清空数组中的数据
                [_dataSource removeAllObjects];
            }
            
            for (int i=0; i<[data count]; i++) {
                NSDictionary *diction=[data objectAtIndex:i];
                
                HHHVedioPlayModel *model=[[HHHVedioPlayModel alloc]init];
                
                model.vedioTitle=kFormatterSring([diction objectForKey:@"title"]);
                
                NSDictionary *dic=[diction objectForKey:@"itemView"];
                
                model.vedioURL=kFormatterSring([dic objectForKey:@"gifPath"]);
                model.vedioPicPath=kFormatterSring([dic objectForKey:@"picPath"]);
                model.vedioTotalTime=[NSString stringWithFormat:@"%d",[kFormatterSring([dic objectForKey:@"playTime"]) formatDateToSecond]];
                
                model.vedioCreatTime=kFormatterSring([diction objectForKey:@"createTime"]).doubleValue/1000;
                model.vedioHeight=kFormatterSring([dic objectForKey:@"height"]).floatValue;
                model.vedioWidth=kFormatterSring([dic objectForKey:@"width"]).floatValue;
                
                long int size=kFormatterSring([dic objectForKey:@"gifSize"]).intValue;
                model.vedioSize=[NSString stringWithFormat:@"%0.2f M",size/1024.0/1024.0];
                model.maxTime=@"0";

                
                [_dataSource addObject:model];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self videoRequest2];
        });
        
        
    } FailureBlock:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self videoRequest2];
        });
        
    } FinishBlock:^{
        
    }];
}



/*
 节操圈子
 */
- (void)videoRequest2 {
    
    NSString *str_url=[NSString stringWithFormat:@"https://api.budejie.com/api/api_open.php?a=list&c=data&type=41&page=%d&maxtime=%@",_page+1,_maxtime];
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {

        NSArray *list=[respose objectForKey:@"list"];
        
        for (int i=9; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            
            HHHVedioPlayModel *model=[[HHHVedioPlayModel alloc]init];
            
            model.vedioTitle=kFormatterSring([diction objectForKey:@"text"]);
            model.vedioURL=kFormatterSring([diction objectForKey:@"videouri"]);
            model.vedioPicPath=kFormatterSring([diction objectForKey:@"bimageuri"]);
            model.vedioTotalTime=kFormatterSring([diction objectForKey:@"videotime"]);
            
            model.vedioCreatTime=kFormatterSring([diction objectForKey:@"t"]).doubleValue;
            model.vedioHeight=kFormatterSring([diction objectForKey:@"height"]).floatValue;
            model.vedioWidth=kFormatterSring([diction objectForKey:@"width"]).floatValue;
            model.vedioSize=@"";
            model.maxTime=kFormatterSring([diction objectForKey:@"t"]);

            [_dataSource addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            
        });
        
    } FailureBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } FinishBlock:^{

        [self endRefresh];
    }];
}

/**
 *  HHHBetterVedioCellDelegate
 *
 *  @param index 点击的第几个cell
 */
- (void)didSelectHHHBetterVedioCellIndex:(NSInteger)index {
    [self.vedioPlayView showWithData:[_dataSource objectAtIndex:index] inView:self.view Y:20.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
