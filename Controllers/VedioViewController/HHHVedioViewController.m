//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHVedioViewController.h"
#import "HHHVedioItemView.h"
#import "HHHBetterVedioCell.h"
#import "HHHVedioPlayModel.h"
#import "HHHVedioPlayView.h"
@interface HHHVedioViewController ()<HHHVedioItemViewDelegate,UITableViewDataSource,UITableViewDelegate,HHHVedioPlayViewDelegate,HHHBetterVedioCellDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)HHHVedioPlayView *vedioPlayView;

@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger page;
@property (nonatomic)NSInteger currentItemIndex;

@property (nonatomic,strong)NSString *vedioURL;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *dataSource1;
@property (nonatomic,strong)NSMutableArray *dataSource2;
@property (nonatomic,strong)NSMutableArray *dataSource3;
@property (nonatomic,strong)NSMutableArray *dataSource4;
@property (nonatomic,strong)NSMutableArray *dataSource5;

@end

@implementation HHHVedioViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"视频";

}

- (void)initDataSource {
    _pageSize = 10;
    
    _page=1;
    
    _dataSource=[[NSMutableArray alloc]init];

    _dataSource1=[[NSMutableArray alloc]init];
    _dataSource2=[[NSMutableArray alloc]init];
    _dataSource3=[[NSMutableArray alloc]init];
    _dataSource4=[[NSMutableArray alloc]init];
    _dataSource5=[[NSMutableArray alloc]init];

    _currentItemIndex=0;
    
    _vedioURL=[NSString stringWithFormat:@"https://api.miaopai.com/m/cate2_channel.json?cateid=132&extend=1&os=ios&page=%ld&per=20&timestamp=1474441405.7232&type=news&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7",(long)_page];

}

- (void)initSubViews {
    
    HHHVedioItemView *itemView=[[HHHVedioItemView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, [HHHVedioItemView viewHeight])];
    [self.view addSubview:itemView];
    itemView.delegate=self;
 
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, itemView.y+itemView.height, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-[HHHVedioItemView viewHeight])];
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
    
    _page=1;
    
    [self.dataSource removeAllObjects];
    
    switch (_currentItemIndex) {
        case 0:{
            [self.dataSource1 removeAllObjects];

        }
            break;
        case 1:{
            [self.dataSource2 removeAllObjects];

        }
            break;
        case 2:{
            [self.dataSource3 removeAllObjects];

        }
            break;
        case 3:{
            [self.dataSource4 removeAllObjects];

        }
            break;
        case 4:{
            [self.dataSource5 removeAllObjects];

        }
            break;

        default:
            break;
    }
    
    [self vedioRequest];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    [self vedioRequest];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height=0.0f;
    if ([_dataSource count] == 0) {
        height= 0;
    }
    
    if (indexPath.row >= [_dataSource count]) {
        height= 0;
    }
    HHHVedioPlayModel *model=[_dataSource objectAtIndex:indexPath.row];
    height= [HHHBetterVedioCell cellHeightForData:model];
    
    return height;
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



/*******************************美女视频**************************************/


/*
 
 
 视频（最新）  （有点裸露）
 http://api.miaopai.com/m/cate2_channel.json?cateid=132&extend=1&os=ios&page=1&per=20&timestamp=1474441405.7232&type=news&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7
 
 舞蹈女神   （有点裸露）
 http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=XqLH1jhWz5L1decQ&timestamp=1474441447.7419&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7
 
 性感女神   （有点裸露）
 http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=NHTxkvi-vAWOgztC&timestamp=1474441510.45871&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7
 
 音乐女神   （有点裸露）
 http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=PPr93pHiTrOqgTns&timestamp=1474441526.06112&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7
 
 日系宅舞   （有点裸露）
 http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=7yTmL6MJ9Rx0pFk~&timestamp=1474441539.30977&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7
 
 */

/*
 节操圈子
 */

- (void)vedioRequest {
    
    switch (_currentItemIndex) {
        case 0:{
            _vedioURL=[NSString stringWithFormat:@"https://api.miaopai.com/m/cate2_channel.json?cateid=132&extend=1&os=ios&page=%ld&per=20&timestamp=1474441405.7232&type=news&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7",(long)_page];
        }
            break;
        case 1:{
            _vedioURL=[NSString stringWithFormat:@"https://api.miaopai.com/m/v2_topic.json?os=ios&page=%ld&per=20&stpid=XqLH1jhWz5L1decQ&timestamp=1474441447.7419&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7",(long)_page];
            
        }
            break;
        case 2:{
            _vedioURL=[NSString stringWithFormat:@"https://api.miaopai.com/m/v2_topic.json?os=ios&page=%ld&per=20&stpid=NHTxkvi-vAWOgztC&timestamp=1474441510.45871&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7",(long)_page];
            
        }
            break;
        case 3:{
            _vedioURL=[NSString stringWithFormat:@"https://api.miaopai.com/m/v2_topic.json?os=ios&page=%ld&per=20&stpid=PPr93pHiTrOqgTns&timestamp=1474441526.06112&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7",(long)_page];
            
        }
            break;
        case 4:{
            _vedioURL=[NSString stringWithFormat:@"https://api.miaopai.com/m/v2_topic.json?os=ios&page=%ld&per=20&stpid=7yTmL6MJ9Rx0pFk~&timestamp=1474441539.30977&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7",(long)_page];
            
        }
            break;
        default:
            break;
    }

    [[AFHTTPClickManager shareInstance] getRequestWithPath:_vedioURL params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *list=[respose objectForKey:@"result"];
    
        for (int i=0; i<[list count]; i++) {
            HHHVedioPlayModel *model=[[HHHVedioPlayModel alloc]init];

            NSDictionary *diction=[list objectAtIndex:i];
            
            NSDictionary *channel=[diction objectForKey:@"channel"];
            
            
            NSDictionary *ext=[channel objectForKey:@"ext"];
            model.vedioTitle=kFormatterSring([ext objectForKey:@"ft"]);
            model.vedioTotalTime=[NSString stringWithFormat:@"%d",[kFormatterSring([ext objectForKey:@"lengthNice"]) formatDateToSecond]];
            model.vedioHeight=kFormatterSring([ext objectForKey:@"h"]).floatValue;
            model.vedioWidth=kFormatterSring([ext objectForKey:@"w"]).floatValue;


            NSDictionary *stream=[channel objectForKey:@"stream"];
            model.vedioURL=kFormatterSring([stream objectForKey:@"base"]);
            
            
            NSDictionary *pic=[channel objectForKey:@"pic"];
            model.vedioPicPath=[NSString stringWithFormat:@"%@%@",[pic objectForKey:@"base"],[pic objectForKey:@"m"]];

            
            NSDictionary *ext2=[channel objectForKey:@"ext2"];
            NSString *createTime=kFormatterSring([ext2 objectForKey:@"createTime"]);
            model.vedioCreatTime=[createTime substringToIndex:createTime.length-3].doubleValue;

            
            model.vedioSize=@"";
            model.maxTime=@"";

            
            switch (_currentItemIndex) {
                case 0:{
                    [self.dataSource1 addObject:model];
                    
                }
                    break;
                case 1:{
                    [self.dataSource2 addObject:model];
                    
                }
                    break;
                case 2:{
                    [self.dataSource3 addObject:model];
                    
                }
                    break;
                case 3:{
                    [self.dataSource4 addObject:model];
                    
                }
                    break;
                case 4:{
                    [self.dataSource5 addObject:model];
                    
                }
                    break;
                    
                default:
                    break;
            }

        }
        
        
        switch (_currentItemIndex) {
            case 0:{
                _dataSource=self.dataSource1;
                
            }
                break;
            case 1:{
                _dataSource=self.dataSource2;
                
            }
                break;
            case 2:{
                _dataSource=self.dataSource3;
                
            }
                break;
            case 3:{
                _dataSource=self.dataSource4;
                
            }
                break;
            case 4:{
                _dataSource=self.dataSource5;
                
            }
                break;
                
            default:
                break;
        }

        NSLog(@"1111=======%d",[_dataSource count]);
        
        [_tableView reloadData];
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
}


/**
 *  HHHVedioItemView Delegate
 *
 *  @param index itemIndex
 */
- (void)didSelectHHHVedioItemViewIndex:(NSInteger)index {

    _currentItemIndex=index;
    
    
    switch (_currentItemIndex) {
        case 0:{
            if ([self.dataSource1 count] == 0) {
                [self vedioRequest];
            }else{
                _dataSource=self.dataSource1;
                [_tableView reloadData];
            }
            
        }
            break;
        case 1:{
            if ([self.dataSource2 count] == 0) {
                [self vedioRequest];
            }else{
                _dataSource=self.dataSource2;
                [_tableView reloadData];
            }
        }
            break;
        case 2:{
            if ([self.dataSource3 count] == 0) {
                [self vedioRequest];
            }else{
                _dataSource=self.dataSource3;
                [_tableView reloadData];
            }
        }
            break;
        case 3:{
            if ([self.dataSource4 count] == 0) {
                [self vedioRequest];
            }else{
                _dataSource=self.dataSource4;
                [_tableView reloadData];
            }
        }
            break;
        case 4:{
            if ([self.dataSource5 count] == 0) {
                [self vedioRequest];
            }else{
                _dataSource=self.dataSource5;
                [_tableView reloadData];
            }        }
            break;
            
        default:
            break;
    }
    

    
}


/**
 *  HHHBetterVedioCellDelegate
 *
 *  @param index 点击的第几个cell
 */
- (void)didSelectHHHBetterVedioCellIndex:(NSInteger)index {
    [self.vedioPlayView showWithData:[_dataSource objectAtIndex:index] inView:self.view Y:0.0f];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
