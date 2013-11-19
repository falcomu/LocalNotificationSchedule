//
//  AppDelegate.m
//  myLocalNotifications
//
//  Created by falcomu on 13/10/22.
//  Copyright (c) 2013年 falcomu. All rights reserved.
//
//系統資訊，手機與程序溝通的管道，程序想要與系統(iPhone)溝通需要他．

#import "AppDelegate.h"

@implementation AppDelegate
#pragma mark - Added methods

-(void)ReOrderApplicationIconBadgeNumber{         //重新安排應用程式的按鈕的提示數字，針對row的內容
    NSArray *notifs=[[UIApplication sharedApplication]scheduledLocalNotifications];//查看目前剩餘的通知數
    int notifIndex=1;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];    //取消所有本機端的通知 <另外一個可以刪除某一筆資料>
    
    for (UILocalNotification *notif in notifs) {
        notif.applicationIconBadgeNumber=notifIndex;        //安排新的badge number給每一筆資料
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];    //重新安排資料
        notifIndex++;   //替badge num 加加
    }
}



#pragma mark - Application
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application{    //程序到前景時
    application.applicationIconBadgeNumber=0;   //將icon的提示數字歸零
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshTableViewDatas" object:nil]; //重新整理table view
     [self ReOrderApplicationIconBadgeNumber];      //重新排序badge number
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber=0;       //icon上的提醒數字歸零
    [self ReOrderApplicationIconBadgeNumber];       //重新排序badge number

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //系統送過來的本地通知，ＡＰＰ執行時或使用中都會進來這邊
    //或ＡＰＰ在背景，沒有使用時，點選橫幅．提醒都會進來
    NSLog(@"%@",notification);
    
    application.applicationIconBadgeNumber=0;   //icon上的提醒數字歸零
    
    [self ReOrderApplicationIconBadgeNumber];       //重新排序badge number
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshTableViewDatas" object:nil];
}

@end
