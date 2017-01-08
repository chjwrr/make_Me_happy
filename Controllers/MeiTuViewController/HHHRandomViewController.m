//
//  HHHMeiTuDetailViewController.m
//  ModelProduct
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHRandomViewController.h"
#import "HHHSexImageModel.h"
#import "HHHSexRandomCell.h"

@interface HHHRandomViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectView;
@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger page;

@property (nonatomic,assign)NSInteger itemtWidth;
@property (nonatomic,assign)NSInteger itemtHeight;

@property (nonatomic,copy)NSString *str_url;

@property (nonatomic,assign)NSInteger imageID;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic)BOOL isLoadEnd;
@end

@implementation HHHRandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"随机";
}


- (void)initDataSource {
    _pageSize = 10;
    
    _page=1;
    
    _dataSource=[[NSMutableArray alloc]init];
    
    _itemtWidth=(NSInteger)(kSCREEN_WIDTH-2-2-2)/3;
    
    _itemtHeight=(NSInteger)_itemtWidth*316/250;
    
    
     _imageID=arc4random()%640;
    
}

- (void)initSubViews {
    
    [self initLeftNavigationBarButton];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    _collectView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectView];
    _collectView.delegate=self;
    _collectView.dataSource=self;
    
    [_collectView registerClass:[HHHSexRandomCell class] forCellWithReuseIdentifier:@"HHHSexRandomCell"];
    
    self.collectView.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    [self.collectView.mj_header beginRefreshing];
    
}

/**
 *  刷新数据
 */
- (void)refreshData {
    
    _page=1;
    
    _isLoadEnd=NO;

    [self.dataSource removeAllObjects];
    
    [self randomSexImageRequest];
}


/**
 *  加载更多数据
 */
- (void)loadMoreData {
    _page++;
    
    [self randomSexImageRequest];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HHHSexRandomCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HHHSexRandomCell" forIndexPath:indexPath];


    if ([_dataSource count] != 0 && indexPath.row < [_dataSource count]) {
        cell.tag=100+indexPath.row;
        [cell cellForData:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //查看图集
    HHHSexImageModel *model=[_dataSource objectAtIndex:indexPath.row];
    [self loadImageDetail:model.JieID];
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.dataSource count] - 5) {
        if (!_isLoadEnd) {
            [self loadMoreData];
        }
    }
}



#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){_itemtWidth,_itemtHeight};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);//item内边距大小
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0f;
}
/*
 自拍社区   没有图集，只有一张图片  随机
 */

- (void)randomSexImageRequest {
    
  /*
   
   图片全部
   
   id的范围是  0-27
   http://115.159.161.198:8000/clubgallery/?page=1&id=0&type=good
   
   http://115.159.161.198:8000/clubgallery/?page=1&id=1&type=good（唯美图片）
   
   http://115.159.161.198:8000/clubgallery/?page=1&id=2&type=good（美女图片）
   
   http://115.159.161.198:8000/clubgallery/?page=1&id=3&type=good（动漫卡通）
   
   http://115.159.161.198:8000/clubgallery/?page=1&id=4&type=good（图看世界）
   
   
   
   
   id的范围是   12-640
   http://115.159.161.198:8000/tag/?page=1&id=445
   
   
   
   图集
   http://115.159.161.198:8000/galPhoto/?id=236199
   
   */

    if (_imageID < 28) {
        
        _str_url=[NSString stringWithFormat:@"http://115.159.161.198:8000/clubgallery/?page=%ld&id=%d&type=good",(long)_page,_imageID];
        
    }else{
        _str_url=[NSString stringWithFormat:@"http://115.159.161.198:8000/tag/?page=%ld&id=%d",(long)_page,_imageID];
        
    }
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:_str_url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *array=[respose objectForKey:@"list"];
        if ([array count] == 0) {
            _isLoadEnd=YES;
        }
        
        for (int i=0; i<[array count]; i++) {
            NSDictionary *diction=[array objectAtIndex:i];
            HHHSexImageModel *model=[[HHHSexImageModel alloc]init];
            
            model.imageURL=kFormatterSring([diction objectForKey:@"HeadPic"]);//图片大部分固定为 250*316  250*180
            model.imageTitle=kFormatterSring([diction objectForKey:@"JieTitle"]);
            model.JieID=kFormatterSring([diction objectForKey:@"JieID"]);

            model.hasImages=NO;
            
            [_dataSource addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectView reloadData];
        });
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [self endRefresh];
    }];
}

/**
 *  加载图集
 */
- (void)loadImageDetail:(NSString *)imageID {
    
    NSString *url=[NSString stringWithFormat:@"http://115.159.161.198:8000/galPhoto/?id=%@",imageID];
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:url params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *array=[respose objectForKey:@"ListContent"];
        
        NSMutableArray *photos=[NSMutableArray array];
        
        for (int i=0; i<[array count]; i++) {
            
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
            
            [photos addObject:photo];
            
        }
        
      dispatch_async(dispatch_get_main_queue(), ^{
          //跳转图片浏览
          [self jumpBigImageWithSelectIndex:0 WithPhotos:photos];

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
