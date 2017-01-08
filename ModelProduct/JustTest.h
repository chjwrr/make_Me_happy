
//
//  JustTest.h
//  ModelProduct
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 chj. All rights reserved.
//

#ifndef JustTest_h
#define JustTest_h


/*******************************裸露美女图片**************************************/


/*
 图片全部  （裸露美女图片）
 
 0-27
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
/*
 自拍社区
 */
/*
- (void)request3 {
    [[AFHTTPClickManager shareInstance] getRequestWithPath:@"http://115.159.161.198:8000/clubgallery/?page=1&id=0&type=good" params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        
    }];
}
*/




/*
 
 美图  （裸露）
 http://dzp.app888.net/fuli?isSub=1&page=1&rows=20&version=1
 
 
 */

/*
 节操圈子
 */
/*
 - (void)request4 {
 [[AFHTTPClickManager shareInstance] getRequestWithPath:@"http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=NHTxkvi-vAWOgztC&timestamp=1474441256.88645&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7" params:nil isHeader:NO LoadingBolck:^{
 
 } SuccessBlock:^(NSDictionary *respose) {
 
 } FailureBlock:^(NSError *error) {
 
 } FinishBlock:^{
 
 }];
 }
 */




/*******************************正常美女图片**************************************/


/*
 图片列表   （正常美女图片）
 http://b.appcq.cn/beauties?expand=randomImage&page=2&per-page=18&tagId=0
 
 图片最新    （正常美女图片）
 http://b.appcq.cn/newest?expand=randomImage&page=2&per-page=18
 
 点击图片获取图集    （正常美女图片）
 http://b.appcq.cn/newest/6993?expand=images
 
 */
/*
 美图大全
 */
/*
 - (void)request2 {
 [[AFHTTPClickManager shareInstance] getRequestWithPath:@"http://b.appcq.cn/newest?expand=randomImage&page=1&per-page=18" params:nil isHeader:NO LoadingBolck:^{
 } SuccessBlock:^(NSDictionary *respose) {
 
 } FailureBlock:^(NSError *error) {
 
 } FinishBlock:^{
 
 }];
 }
 */



/*******************************精选  视频、图片、段子**************************************/
/*******************************最新  视频、图片、段子**************************************/

/*******************************视频**************************************/
/*******************************图片**************************************/
/*******************************声音**************************************/
/*******************************段子**************************************/

/*
 精选（图片和视频都有） （正常）
 http://api.jiefu.tv/app2/api/article/list.html?bisRecommend=1&deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=0&pageSize=20
 
 最新（图片和视频都有）  （正常）
 http://api.jiefu.tv/app2/api/article/hotList.html?deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=0&pageSize=20
 
 图片        （正常）
 http://api.jiefu.tv/app2/api/article/list.html?mediaType=1&deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=0&pageSize=20
 
 视频         （正常）
 http://api.jiefu.tv/app2/api/article/list.html?mediaType=2&deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=0&pageSize=20
 
 
 */

/*
 内涵妹子
 */
/*
 - (void)request1 {
 [[AFHTTPClickManager shareInstance] getRequestWithPath:@"http://api.jiefu.tv/app2/api/article/list.html?mediaType=1&deviceCode=7EE523B5BBF72B94E3F8D16C3EDF8264&token=&pageNum=1&pageSize=20" params:nil isHeader:NO LoadingBolck:^{
 
 } SuccessBlock:^(NSDictionary *respose) {
 
 } FailureBlock:^(NSError *error) {
 
 } FinishBlock:^{
 
 }];
 }
 */




/*
 全部 （a = newlist  新帖）（a = list  精选）（图片、视频、段子都有）   （正常）
 http://api.budejie.com/api/api_open.php?a=list&c=data&type=1&page=1&maxtime=0
 
 第二页 （maxtime  为上一页最后一条数据的  t  字段 的值）   （正常）
 http://api.budejie.com/api/api_open.php?a=list&c=data&type=1&page=2&maxtime=1474425121
 
 
 
 视频   （正常）
 http://api.budejie.com/api/api_open.php?a=list&c=data&type=41&page=1&maxtime=0
 
 图片   （正常）
 http://api.budejie.com/api/api_open.php?a=list&c=data&type=10&page=1&maxtime=0
 
 声音   （正常）
 http://api.budejie.com/api/api_open.php?a=list&c=data&type=31&page=1&maxtime=0
 
 段子  （正常）
 http://api.budejie.com/api/api_open.php?a=list&c=data&type=29&page=1&maxtime=0
 
*/

/*
 节操圈子
 */
/*
 - (void)request4 {
 [[AFHTTPClickManager shareInstance] getRequestWithPath:@"http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=NHTxkvi-vAWOgztC&timestamp=1474441256.88645&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7" params:nil isHeader:NO LoadingBolck:^{
 
 } SuccessBlock:^(NSDictionary *respose) {
 
 } FailureBlock:^(NSError *error) {
 
 } FinishBlock:^{
 
 }];
 }
 */






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
/*
 - (void)request4 {
 [[AFHTTPClickManager shareInstance] getRequestWithPath:@"http://api.miaopai.com/m/v2_topic.json?os=ios&page=1&per=20&stpid=NHTxkvi-vAWOgztC&timestamp=1474441256.88645&token=CNk4vpEO7TG6arxT~0oPJ~jnthGzbhlA&type=2&unique_id=6d43a571caf7abe9e29f08d6bf94ee792483732007&uuid=6d43a571caf7abe9e29f08d6bf94ee792483732007&vend=miaopai&version=6.5.7" params:nil isHeader:NO LoadingBolck:^{
 
 } SuccessBlock:^(NSDictionary *respose) {
 
 } FailureBlock:^(NSError *error) {
 
 } FinishBlock:^{
 
 }];
 }
 */















#endif /* JustTest_h */
