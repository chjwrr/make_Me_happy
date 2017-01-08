//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HHHSettingViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "HHHMyDownLoadViewController.h"

@interface HHHSettingViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *titleSource;


@end

@implementation HHHSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)initDataSource {
    _dataSource=@[@[@"清理缓存",@"我的下载"],@[@"意见反馈",@"给个好评"],@[@"玩弄股掌间",@"Redo.me"]];
    _titleSource=@[@"系统设置",@"建议反馈",@"应用推荐"];
}

- (void)initSubViews{
    self.title=@"设置";
    
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

#pragma  mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_titleSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_dataSource objectAtIndex:section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == [_titleSource count]-1) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        if (!cell) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];

        }
        
        cell.textLabel.text=[[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text=@"让生活玩弄于股掌之间";
            cell.imageView.image=kImageName(@"hhh_tuijian_image");
        }else{
            cell.detailTextLabel.text=@"既然时间无法Undo,那么就 Redo.Me";
            cell.imageView.image=kImageName(@"hhh_tuijian_image1");
        }
        
        cell.imageView.layer.cornerRadius=5;
        cell.imageView.layer.masksToBounds=YES;
        
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 60)];
        [cell.contentView addSubview:button];
        button.tag=104+indexPath.row;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        if (!cell) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
            
        }
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.accessoryType=UITableViewCellAccessoryNone;
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%0.2f M",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0];
                
                
                UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 60)];
                [cell.contentView addSubview:button];
                button.tag=100;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 60)];
                [cell.contentView addSubview:button];
                button.tag=101;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

            }
            
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 60)];
            [cell.contentView addSubview:button];
            button.tag=102+indexPath.row;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        cell.textLabel.text=[[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
        
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [_titleSource count]-1) {
        return 60.0f;
    }
    return 44.0f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
    view.backgroundColor=kColorHexString(@"ededed");
    UILabel *lab_2=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 20)];
    [view addSubview:lab_2];
    lab_2.text=[_titleSource objectAtIndex:section];
    lab_2.font=kSYS_FONT(14);
    
    return view;
}

- (void)buttonAction:(UIButton *)button {
    
    switch (button.tag) {
        case 100:{
            //清理缓存
            
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            
            
            [self showMessage:@"缓存清理成功"];
            
            [_tableView reloadData];
        }
            break;
        case 101:{
            //我的下载
            HHHMyDownLoadViewController *downLoadVC=[[HHHMyDownLoadViewController alloc]init];
            [self.navigationController pushViewController:downLoadVC animated:YES];

        }
            break;
        case 102:{
            //意见反馈
            [self sendEmail];
        }
            break;
        case 103:{
            //给个好评
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1156411807&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
            
        }
            break;
       
            
        case 104:{
            //应用推荐 玩弄鼓掌间
            kOPEN_URL(@"itms-apps://itunes.apple.com/app/id1137035730");
        }
            
            break;
            
        case 105:{
            //应用推荐 red0.me
            kOPEN_URL(@"itms-apps://itunes.apple.com/app/id1144002840");
        }
            
            break;

        default:
            break;
    }
    
}


/**
 *    发送邮件
 */
- (void)sendEmail {
    Class mainlClass=NSClassFromString(@"MFMailComposeViewController");
    if (!mainlClass) {
        [self showMessage:@"当前系统版本不支持应用内发送邮件功能"];
        return;
    }
    
    if (![mainlClass canSendMail]) {
        [self showMessage:@"你还没有设置邮件账户"];
        
        return;
    }
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate=self;
    
    //设置主题
    [mailPicker setSubject:@"自嗨 意见反馈"];
    
    //添加收件人
    NSArray *toRecipients=[NSArray arrayWithObject:@"chjwrr@163.com"];
    [mailPicker setToRecipients:toRecipients];
    
    NSString *emailBody=@"<font color='red'> 无人嗨？<br />那么就 自嗨 </font>";
    NSString *msg=[NSString stringWithFormat:@"<br />手机型号：%@<br />系统版本：%.2f<br />应用版本：%@",[self deviceName],kAPP_System_Version,kAPP_Bundle_Version];
    
    
    [mailPicker setMessageBody:[NSString stringWithFormat:@"%@\n%@",emailBody,msg] isHTML:YES];
    
    [self presentViewController:mailPicker animated:YES completion:^{
        
    }];
    
    
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MFMailComposeResultSent:{
            [self showMessage:@"邮件已发送"];
            
        }
            break;
        case MFMailComposeResultCancelled:{
            [self showMessage:@"邮件已取消"];
            
        }
            break;
        case MFMailComposeResultFailed:{
            [self showMessage:@"邮件发送失败，请重试"];
            
        }
            break;
        case MFMailComposeResultSaved:{
            [self showMessage:@"邮件保存成功"];
            
        }
            break;
            
        default:
            break;
    }
    
    
}




@end
