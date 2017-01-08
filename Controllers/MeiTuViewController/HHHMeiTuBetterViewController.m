//
//  HHHMeiTuBetterViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHMeiTuBetterViewController.h"
#import "HHHMeiTuModel.h"
#import "HHHCollectViewCell.h"

#import "CHJShowImageView.h"

#define kspacewidth       2
#define ktableViewWidth   (kSCREEN_WIDTH - kspacewidth)/2


typedef enum : NSUInteger {
    leftTableViewTag = 100,
    rightTableViewTag,
} TableViewTag;

@interface HHHMeiTuBetterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic,strong)NSMutableArray *leftDataSource;

@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic,strong)NSMutableArray *rightDataSource;

@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger page;
@property (nonatomic,assign)BOOL isloadEnd;

@end

@implementation HHHMeiTuBetterViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.leftTableView.contentSize.height >= self.rightTableView.contentSize.height) {
        [self.rightTableView setContentSize:self.leftTableView.contentSize];
    }else{
        [self.leftTableView setContentSize:self.rightTableView.contentSize];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initDataSource {
    _pageSize = 20;
    
    _page=1;
    
    _leftDataSource=[[NSMutableArray alloc]init];
    _rightDataSource=[[NSMutableArray alloc]init];
}

- (void)initSubViews {
    
    //创建瀑布流布局
    UICollectionViewFlowLayout *waterfall = [[UICollectionViewFlowLayout alloc]init];
    
    [waterfall setScrollDirection:UICollectionViewScrollDirectionVertical]; //设置横向还是竖向

    //创建左侧tableview
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ktableViewWidth, kSCREEN_HEIGHT-64)];
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate=self;
    [self.view addSubview:self.leftTableView];
    self.leftTableView.tag=leftTableViewTag;
    self.leftTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.leftTableView.showsVerticalScrollIndicator=NO;
    //创建右侧tableview
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftTableView.width+kspacewidth, 0, ktableViewWidth, kSCREEN_HEIGHT-64)];
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.dataSource = self;
    self.rightTableView.delegate=self;
    [self.view addSubview:self.rightTableView];
    self.rightTableView.tag=rightTableViewTag;
    self.rightTableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    [self meiTurequest];

}
/*
 美图大全 精选
 */

- (void)meiTurequest {
    
    NSString *str_url=[NSString stringWithFormat:@"http://b.appcq.cn/beauties?expand=randomImage&page=%ld&per-page=%ld&tagId=0",(long)_page,(long)_pageSize];
    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *array=(NSArray *)respose;
        if ([array count] == 0) {
            _isloadEnd=YES;
        }

        for (int i=0; i<[array count]; i++) {
            NSDictionary *diction=[array objectAtIndex:i];
            
            HHHMeiTuModel *model=[[HHHMeiTuModel alloc]init];
            model.str_id=kFormatterSring([diction objectForKey:@"id"]);
            model.album_name=kFormatterSring([diction objectForKey:@"album_name"]);
            model.creat_time=kFormatterSring([diction objectForKey:@"collect_time"]).doubleValue;
            model.imageNum=kFormatterSring([diction objectForKey:@"imageNum"]).intValue;

            NSDictionary *dic=[diction objectForKey:@"randomImage"];
            
            model.originUrl=kFormatterSring([dic objectForKey:@"originUrl"]);
            model.thumbUrl=kFormatterSring([dic objectForKey:@"thumbUrl"]);
            model.imageHeight=kFormatterSring([dic objectForKey:@"height"]).floatValue;
            model.imageWidth=kFormatterSring([dic objectForKey:@"width"]).floatValue;
            model.imageSize=kFormatterSring([dic objectForKey:@"size"]).intValue;

            if (i % 2 == 0) {
                //左侧
                
                [_leftDataSource addObject:model];
                
            }else{
                //右侧
                
                [_rightDataSource addObject:model];
            }
        }
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        if (self.leftTableView.contentSize.height >= self.rightTableView.contentSize.height) {
            [self.rightTableView setContentSize:self.leftTableView.contentSize];
        }else{
            [self.leftTableView setContentSize:self.rightTableView.contentSize];
        }
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];

    }];
}

/**
 *  根据图片ID获取图集
 *
 *  @param str_ID 图片ID
 */
- (void)imageDetail:(NSString *)str_ID {
    
    NSString *str_url=[NSString stringWithFormat:@"http://b.appcq.cn/newest/%@?expand=images",str_ID];

    [[AFHTTPClickManager shareInstance] getRequestWithPath:str_url params:nil isHeader:NO LoadingBolck:^{
    } SuccessBlock:^(NSDictionary *respose) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSArray *images=[respose objectForKey:@"images"];
            
            NSMutableArray *photos=[NSMutableArray array];
            
            for (int i=0; i<[images count]; i++) {
                
                NSDictionary *diction=[images objectAtIndex:i];
                
                MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[diction objectForKey:@"originUrl"]]];
                
                [photos addObject:photo];
                
            }
            
            //跳转图片浏览
            [self jumpBigImageWithSelectIndex:0 WithPhotos:photos];
            
            
        });
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftDataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == leftTableViewTag) {
        
        if ([self.leftDataSource count] == 0) {
            return 0;
        }
        return [HHHCollectViewCell cellHeightForData:[_leftDataSource objectAtIndex:indexPath.row]];
        
    }
    
    if ([self.rightDataSource count] == 0) {
        return 0;
    }
    return [HHHCollectViewCell cellHeightForData:[_rightDataSource objectAtIndex:indexPath.row]];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == leftTableViewTag) {
        HHHCollectViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"left"];
        if (!cell) {
            cell=[[HHHCollectViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"left"];
        }
        
        if ([self.leftDataSource count] !=0) {

            if (indexPath.row < [self.leftDataSource count]) {
                [cell cellForData:[self.leftDataSource objectAtIndex:indexPath.row]];
            }
            
        }
        return cell;
    }
    
    HHHCollectViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"right"];
    if (!cell) {
        cell=[[HHHCollectViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"right"];
    }
    
    if ([self.rightDataSource count] !=0) {
        if (indexPath.row < [self.rightDataSource count]) {
            [cell cellForData:[self.rightDataSource objectAtIndex:indexPath.row]];
        }

    }

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == [self.leftDataSource count] - 2) {
        //加载到倒数第二个的时候，自动加载下一页的数据
        if (!_isloadEnd) {
            _page++;
            
            [self meiTurequest];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == leftTableViewTag) {
        HHHMeiTuModel *model=[self.leftDataSource objectAtIndex:indexPath.row];
        
        [self imageDetail:model.str_id];
    }else{
        HHHMeiTuModel *model=[self.rightDataSource objectAtIndex:indexPath.row];
        
        [self imageDetail:model.str_id];

    }

//    HHHCollectViewCell *selectCell=[tableView cellForRowAtIndexPath:indexPath];
//    
//    selectCell.hidden=YES;
//    
//    if (tableView.tag == leftTableViewTag) {
//        
//        HHHMeiTuModel *model=[self.leftDataSource objectAtIndex:indexPath.row];
//        
//        //cell相对于tableview的位置
//        CGRect rect= [self.leftTableView rectForRowAtIndexPath:indexPath];
//        
//        //cell相对于屏幕的位置
//        CGRect rect1= [self.leftTableView convertRect:rect toView:[self.leftTableView superview]];
//
//        //图片的高度(整个屏幕)
//        CGFloat height=model.imageHeight/model.imageWidth*ktableViewWidth;
//        
//        //cell里面的图片相对于屏幕的位置  (1 是 cell 里面图片相对于cell的间隙)
//        //动画开始时，图片的起始位置
//        CGRect imageRect=CGRectMake(0, 64+rect1.origin.y+1, ktableViewWidth, height);
//        
//        //查看大图
//        [[CHJShowImageView shareInstance] showImageURL:model.originUrl BeginFrame:imageRect dismissComplete:^{
//            selectCell.hidden=NO;
//        }];
//        
//    }else{
//        
//        HHHMeiTuModel *model=[self.rightDataSource objectAtIndex:indexPath.row];
//        
//        //cell相对于tableview的位置
//        CGRect rect= [self.rightTableView rectForRowAtIndexPath:indexPath];
//        
//        //cell相对于屏幕的位置
//        CGRect rect1= [self.rightTableView convertRect:rect toView:[self.rightTableView superview]];
//        
//        //图片的高度(整个屏幕)
//        CGFloat height=model.imageHeight/model.imageWidth*ktableViewWidth;
//        
//        //cell里面的图片相对于屏幕的位置  (1 是 cell 里面图片相对于cell的间隙)
//        //动画开始时，图片的起始位置
//        CGRect imageRect=CGRectMake(ktableViewWidth+kspacewidth, 64+rect1.origin.y+1, ktableViewWidth, height);
//
//        //查看大图
//        [[CHJShowImageView shareInstance] showImageURL:model.originUrl BeginFrame:imageRect dismissComplete:^{
//            selectCell.hidden=NO;
//        }];
//    }
//    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.leftTableView.contentSize.height >= self.rightTableView.contentSize.height) {
        [self.rightTableView setContentSize:self.leftTableView.contentSize];
    }else{
        [self.leftTableView setContentSize:self.rightTableView.contentSize];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.leftTableView.contentOffset=CGPointMake(0, scrollView.contentOffset.y);
    self.rightTableView.contentOffset=CGPointMake(0, scrollView.contentOffset.y);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
