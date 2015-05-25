//
//  CGAlarmManager.m
//  blueTooth
//
//  Created by duluyang on 15/5/23.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "CGAlarmManager.h"
#import "AlarmManager.h"
#import "BluetoothDeviceManager.h"

@interface CGAlarmManager ()<AlarmDelegate>

@property (nonatomic,weak) id<AlarmManager> alarmManager;
@property (nonatomic,weak) id<CGAlarmDelegate> cgalarmdelegate;

@end

@implementation CGAlarmManager


#pragma mark AlarmDelegate 

-(void)managerReady:(UInt32)mode
{
    if ([self.cgalarmdelegate respondsToSelector:@selector(CGmanagerReady:)]) {
        [self.cgalarmdelegate CGmanagerReady:mode];
    }
}

- (void)alarmStateChanged:(UInt32)state
{
    if ([self.cgalarmdelegate respondsToSelector:@selector(CGalarmStateChanged:)]) {
        [self.cgalarmdelegate CGalarmStateChanged:state];
    }
}

-(void)alarmListArrived:(NSMutableArray*)alarmList
{
    if ([self.cgalarmdelegate respondsToSelector:@selector(CGalarmListArrived:)]) {
        [self.cgalarmdelegate CGalarmListArrived:alarmList];
    }
}

-(void)ringListArrived:(NSMutableArray*)ringList
{
    if ([self.cgalarmdelegate respondsToSelector:@selector(CGringListArrived:)]) {
        [self.cgalarmdelegate CGringListArrived:ringList];
    }
}

-(void)folderListArrived:(NSMutableArray*)folderList
{
    if ([self.cgalarmdelegate respondsToSelector:@selector(CGfolderListArrived:)]) {
        [self.cgalarmdelegate CGfolderListArrived:folderList];
    }
}

#pragma mark 成员方法

- (void)setWithCGAlarmDelegate:(id<CGAlarmDelegate>)delegate
{
    self.cgalarmdelegate = delegate;
    self.alarmManager = [[BluetoothDeviceManager sharedInstance].bluzManager getAlarmManager:self];
}


-(void)setAlarm:(AlarmEntry*)alarm
{
    [_alarmManager setAlarm:alarm];
}

-(void)removeAlarm:(AlarmEntry*)alarm
{
    [_alarmManager removeAlarm:alarm];
}

-(void)removeAll
{
    [_alarmManager removeAll];
}

-(void)getAlarmList
{
    [_alarmManager getAlarmList];
}

-(void)getRingList
{
    [_alarmManager getRingList];
}

-(void)snooze
{
    [_alarmManager snooze];
}

-(void)off
{
    [_alarmManager off];
}

-(void)getRingFolderList
{
    [_alarmManager getRingFolderList];
}

@end
