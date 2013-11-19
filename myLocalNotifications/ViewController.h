//
//  ViewController.h
//  myLocalNotifications
//
//  Created by falcomu on 2013/11/19.
//  Copyright (c) 2013年 falcomu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *eventText;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
