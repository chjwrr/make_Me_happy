//
//  HHHBetterImageViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHBetterImageViewController.h"

#import "HHHBetterImageCell.h"
#import "HHHImageModel.h"

@interface HHHBetterImageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger page;
@property (nonatomic,strong)NSString *maxtime;

@property (nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation HHHBetterImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"图片");

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

/**
 *  刷新数据
 */
- (void)refreshData {
    
    _page=0;
    
    _maxtime=@"0";
    
    [self.dataSource removeAllObjects];

    [self imageRequest1];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    HHHImageModel *lastModel=[_dataSource lastObject];
    
    _maxtime=lastModel.maxTime;
    
    [self imageRequest1];
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
    HHHImageModel *model=[_dataSource objectAtIndex:indexPath.row];
    return [HHHBetterImageCell cellHeightForData:model];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"HHHBetterImageCell";
    
    HHHBetterImageCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell=[[HHHBetterImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if ([_dataSource count] != 0 && indexPath.row < [_dataSource count]) {
        cell.tag=100+indexPath.row;
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHHBetterImageCell *selectCell=[_tableView cellForRowAtIndexPath:indexPath];

    [self showSaveAndReportAlert:selectCell.imageview.image];
}


/*
 内涵妹子
 */
- (void)imageRequest1 {
    
    NSString *str_url=[NSString stringWithFormat:@"https://api.jiefu.tv/app2/api/article/list.html?mediaType=1&deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=%ld&pageSize=%ld",(long)_page,(long)_pageSize];
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        if ([kFormatterSring([respose objectForKey:@"code"]) isEqualToString:@"0"]) {
            NSArray *data=[respose objectForKey:@"data"];
            
            for (int i=0; i<[data count]; i++) {
                NSDictionary *diction=[data objectAtIndex:i];
                
                HHHImageModel *model=[[HHHImageModel alloc]init];
                model.title=kFormatterSring([diction objectForKey:@"title"]);
                
                NSDictionary *itemView=[diction objectForKey:@"itemView"];
                
                model.imageURL=kFormatterSring([itemView objectForKey:@"gifPath"]);
                model.imageHeight=kFormatterSring([itemView objectForKey:@"height"]).floatValue;
                model.imageWidth=kFormatterSring([itemView objectForKey:@"width"]).floatValue;
                model.maxTime=@"0";
                model.imageCreatTime=kFormatterSring([diction objectForKey:@"createTime"]).doubleValue/1000;

                [_dataSource addObject:model];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self imageRequest2];
        });
        
    } FailureBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self imageRequest2];
        });
    } FinishBlock:^{

    }];
}



/*
 节操圈子
 */
- (void)imageRequest2 {
    
    NSString *str_url=[NSString stringWithFormat:@"https://api.budejie.com/api/api_open.php?a=list&c=data&type=10&page=%ld&maxtime=%@",(long)_page,_maxtime];
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *list=[respose objectForKey:@"list"];
        
        for (int i=0; i<[list count]; i++) {
            NSDictionary *diction=[list objectAtIndex:i];
            
            HHHImageModel *model=[[HHHImageModel alloc]init];
            model.title=kFormatterSring([diction objectForKey:@"text"]);
            model.imageURL=kFormatterSring([diction objectForKey:@"cdn_img"]);
            model.imageHeight=kFormatterSring([diction objectForKey:@"height"]).floatValue;
            model.imageWidth=kFormatterSring([diction objectForKey:@"width"]).floatValue;
            model.maxTime=kFormatterSring([diction objectForKey:@"t"]);
            model.imageCreatTime=kFormatterSring([diction objectForKey:@"t"]).doubleValue;

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
