//
//  HHHMyAudioListViewController.m
//  ModelProduct
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHMyAudioListViewController.h"
#import "HHHMyAudioCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HHHMyAudioListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *titles;
@property (nonatomic,strong)NSMutableArray *filePaths;

@property (nonatomic,strong)MPMoviePlayerViewController *playerVc;

@end

@implementation HHHMyAudioListViewController


- (void)initDataSource {
    
 
    
}

- (void)initSubViews {
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[UIView new];

    _titles=[[NSMutableArray alloc]init];
    _filePaths=[[NSMutableArray alloc]init];
    
    NSArray *audioList=[[FileManager shareIntance] getAllAudeoItems];
    
    for (int i=0; i<[audioList count]; i++) {
        NSString *audioPaht=[audioList objectAtIndex:i];
        
        NSArray *array=[audioPaht componentsSeparatedByString:@"/"];
        
        [_titles addObject:[array lastObject]];//标题
        [_filePaths addObject:audioPaht];//路径
        
    }

    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[_titles objectAtIndex:indexPath.row] getStringHeightSizeWidth:kSCREEN_WIDTH WithFontSize:14]+20;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier=@"HHHMyAudioCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSString *title=[_titles objectAtIndex:indexPath.row];
    cell.textLabel.text=[title substringToIndex:title.length-4];
    cell.textLabel.font=kSYS_FONT(14);
    cell.textLabel.numberOfLines=0;
//    [cell cellForData:nil];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[_filePaths objectAtIndex:indexPath.row]]];
    [_playerVc.moviePlayer prepareToPlay];
    
    [_playerVc.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    
    [_playerVc.view setBackgroundColor:[UIColor clearColor]];
    
    [_playerVc.view setFrame:self.view.bounds];
    
    [self presentMoviePlayerViewControllerAnimated:self.playerVc];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[FileManager shareIntance] removeAudeoFilePathWithItemName:[_titles objectAtIndex:indexPath.row]];
    [_titles removeObjectAtIndex:indexPath.row];
    
    [tableView reloadData];
}

@end
