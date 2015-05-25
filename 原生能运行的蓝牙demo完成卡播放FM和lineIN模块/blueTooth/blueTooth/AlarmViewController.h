//
//  AlarmViewController.h
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *setAlarm;
@property (weak, nonatomic) IBOutlet UIButton *removeAlarm;
@property (weak, nonatomic) IBOutlet UIButton *getAlarmlist;
@property (weak, nonatomic) IBOutlet UIButton *zoomfive;
@property (weak, nonatomic) IBOutlet UIButton *closeAlarm;
@property (weak, nonatomic) IBOutlet UIButton *removeAllAlarms;
@property (weak, nonatomic) IBOutlet UILabel *showAlarm;
- (IBAction)setAction:(id)sender;
- (IBAction)removeTheAlarm:(id)sender;
- (IBAction)getAlarmList:(id)sender;
- (IBAction)zoomAction:(id)sender;
- (IBAction)closeCurrentAlarm:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getRingLIst;
- (IBAction)getRingList:(id)sender;
- (IBAction)getForld:(id)sender;
- (IBAction)setRepleat:(id)sender;

@end
