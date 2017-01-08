//
//  HHHMeiTuSexViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHMeiTuSexViewController.h"
#import "HHHSexImageModel.h"
#import "HHHSexImageCell.h"

@interface HHHMeiTuSexViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger page;

@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HHHMeiTuSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initDataSource {
    _pageSize = 10;
    
    _page=1;
    
    _dataSource=[[NSMutableArray alloc]init];
    
}

- (void)initSubViews {
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
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
    
    _page=1;
    
    [self.dataSource removeAllObjects];

    [self sexImageRequest];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    [self sexImageRequest];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSource count] == 0) {
        return 0;
    }
    return [HHHSexImageCell cellHeightForData:[_dataSource objectAtIndex:indexPath.row]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"HHHSexImageCell";
    
    HHHSexImageCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell=[[HHHSexImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if ([_dataSource count] != 0 && indexPath.row < [_dataSource count]) {
        cell.tag=100+indexPath.row;
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //点击查看图集
    HHHSexImageModel *model=[_dataSource objectAtIndex:indexPath.row];
    
    NSMutableArray *photos=[NSMutableArray array];
    
    for (int i=0; i<[model.imageURLs count]; i++) {
        
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[model.imageURLs objectAtIndex:i]]];
        
        [photos addObject:photo];
        
    }
    
    //跳转图片浏览
    [self jumpBigImageWithSelectIndex:0 WithPhotos:photos];

}

/*
 节操圈子  返回自带图集
 */

- (void)sexImageRequest {
    
    NSString *str_url=[NSString stringWithFormat:@"http://dzp.app888.net/fuli?isSub=1&page=%ld&rows=20&version=1",(long)_page];

    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        [self footerRefreshHiddent:NO];

        NSArray *array=[respose objectForKey:@"rows"];
        
        for (int i=0; i<[array count]; i++) {
            NSDictionary *diction=[array objectAtIndex:i];
            HHHSexImageModel *model=[[HHHSexImageModel alloc]init];
            
            model.imageURL=kFormatterSring([diction objectForKey:@"url"]);
            model.imageTitle=kFormatterSring([diction objectForKey:@"title"]);
            model.hasImages=YES;
            
            //图集
            NSMutableArray *array=[NSMutableArray array];
            
            NSArray *list=[diction objectForKey:@"list"];
            for (int j=0; j<[list count]; j++) {
                NSDictionary *dic=[list objectAtIndex:j];
                [array addObject:[dic objectForKey:@"url"]];
            }
            
            model.imageURLs=array;
            
            [_dataSource addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } FailureBlock:^(NSError *error) {
        [self footerRefreshHiddent:YES];
    } FinishBlock:^{
        [self endRefresh];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
