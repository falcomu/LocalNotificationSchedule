//
//  ViewController.m
//  myLocalNotifications
//
//  Created by falcomu on 13/10/22.
//  Copyright (c) 2013年 falcomu. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - Refresh Table View
-(void)refreshTableView:(NSNotification *)notification{
    [self.listTableView reloadData];
}

#pragma mark - View
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    //宣告新的Notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTableView:)
                                                 name:@"RefreshTableViewDatas"
                                               object:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //刪除observe
}


#pragma mark -table view relate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{   //回傳的table view多少列...
    
    return [[[UIApplication sharedApplication] scheduledLocalNotifications]count];      //可獲得陣列有多少筆
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];    //測試是否可以連接到table view
    
    NSArray *notifs=[[UIApplication sharedApplication] scheduledLocalNotifications];    //讀取所有陣列有幾筆資料
    UILocalNotification *notif=[notifs objectAtIndex:indexPath.row];        //看有幾筆資料
    
    cell.textLabel.text=[NSString stringWithFormat:@"(%d) %@", notif.applicationIconBadgeNumber,notif.alertBody];    //可以用點方法將文字顯示在text label上面
    
    
    //取出時間，並坐當地時間的轉換，因為原始為格林威自時間
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];      //日期格式(將依照對應格式顯示字串)
    
    cell.detailTextLabel.text=[dateFormat stringFromDate:notif.fireDate];        //取得時間
    
    
    return cell;
}


#pragma mark -add methods
- (IBAction)scheduleAction:(id)sender {
    UILocalNotification *localNotif=[[UILocalNotification alloc] init];
    localNotif.fireDate=[self.datePicker date];     //取得datepicker上的時間
    localNotif.timeZone=[NSTimeZone defaultTimeZone];   //將目前的時區給他
    localNotif.alertBody=self.eventText.text;      //顯示的內容，textview的輸入內容
    localNotif.soundName=UILocalNotificationDefaultSoundName;   //內建的警示聲音
    localNotif.applicationIconBadgeNumber=0;        //應用程式的提醒號碼
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];   //設定Notification
    
    //重新安排applicationBedgeNumber
    AppDelegate *appDelegete=[[UIApplication sharedApplication]delegate];   //當進入
    [appDelegete ReOrderApplicationIconBadgeNumber];
    
    [self.listTableView reloadData];    //要重新讀取資料，table內容才會更新
    [self.eventText resignFirstResponder];  //輸入完，收鍵盤
    self.eventText.text=@"";
    
    //顯示所有notification的內容．
    /*
    NSArray *notifs=[[UIApplication sharedApplication] scheduledLocalNotifications];   //將notification的內容全部抓取出來
    NSLog(@"%@",notifs);
    */
}


- (IBAction)textDoneAction:(id)sender { //本text filed的事件設定為，did End On Exit，也就是當按下return 後則會進入本方法
    [sender resignFirstResponder];          //如果虛擬鍵盤按下return，則會將小鍵盤關閉
    self.eventText.text=@"";
}

@end
