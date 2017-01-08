//
//  HHHBetterTextViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterTextViewController.h"
#import "HHHBetterTextCell.h"
#import "HHHTextModel.h"

@interface HHHBetterTextViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *maxtime;
@property (nonatomic)NSInteger page;

@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HHHBetterTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    NSLog(@"段子");

}

- (void)initDataSource {
    
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

/**
 *  刷新数据
 */
- (void)refreshData {
    
    _page=0;
    
    _maxtime=@"0";
    
    [self.dataSource removeAllObjects];

    [self textRequest];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    HHHTextModel *lastModel=[_dataSource lastObject];
    
    _maxtime=lastModel.maxTime;
    
    [self textRequest];
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
    HHHTextModel *model=[_dataSource objectAtIndex:indexPath.row];
    return [HHHBetterTextCell cellHeightForData:model];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"HHHBetterTextCell";
    
    HHHBetterTextCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell=[[HHHBetterTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if ([_dataSource count] != 0 && indexPath.row < [_dataSource count]) {
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


/*
 节操圈子
 */

- (void)textRequest {
    
    NSString *str_url=[NSString stringWithFormat:@"https://api.budejie.com/api/api_open.php?a=list&c=data&type=29&page=%ld&maxtime=%@",(long)_page,_maxtime];
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *list=[respose objectForKey:@"list"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            
            HHHTextModel *model=[[HHHTextModel alloc]init];
            
            model.title=kFormatterSring([diction objectForKey:@"text"]);
            model.maxTime=kFormatterSring([diction objectForKey:@"t"]);
            model.textCreatTime=kFormatterSring([diction objectForKey:@"t"]).doubleValue;

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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
