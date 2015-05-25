//
//  CGRadioManager.m
//  blueTooth
//
//  Created by duluyang on 15/5/22.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "CGRadioManager.h"
#import "BluetoothDeviceManager.h"
#import "RadioManager.h"

@interface CGRadioManager ()<RadioDelegate>

@property (nonatomic,weak) id<RadioManager> radioManger;
@property (nonatomic,weak) id<CGRadioDelegate> cgradioDelegate;

@end

@implementation CGRadioManager


#pragma mark 设置代理
- (void)setWithCGMusciDelegate:(id<CGRadioDelegate>)delegate
{
    self.cgradioDelegate = delegate;
    self.radioManger = [[BluetoothDeviceManager sharedInstance].bluzManager getRadioManager:self];
}

#pragma mark radioDelegate

-(void)managerReady:(UInt32)mode
{
    if ([self.cgradioDelegate respondsToSelector:@selector(CGmanagerReady:)]) {
        [self.cgradioDelegate CGmanagerReady:mode];
    }
}

-(void)radioListChanged:(NSMutableArray*)channelList
{
    if ([self.cgradioDelegate respondsToSelector:@selector(CGradioListChanged:)]) {
        [self.cgradioDelegate CGradioListChanged:channelList];
    }
}

-(void)radioStateChanged:(UInt32)state
{
    if ([self.cgradioDelegate respondsToSelector:@selector(CGradioStateChanged:)]) {
        [self.cgradioDelegate CGradioStateChanged:state];
    }
}

-(void)channelChanged:(UInt32)channel
{
    if ([self.cgradioDelegate respondsToSelector:@selector(CGchannelChanged:)]) {
        [self.cgradioDelegate CGchannelChanged:channel];
    }
}

-(void)bandChanged:(UInt32)band
{
    if ([self.cgradioDelegate respondsToSelector:@selector(CGbandChanged:)]) {
        [self.cgradioDelegate CGbandChanged:band];
    }
}



#pragma 成员方法

-(void)select:(UInt32)channel
{
   [_radioManger select:channel];
}

-(void)scanStart
{
   [_radioManger scanStart];
}

-(void)scanStop
{
   [_radioManger scanStop];
}

-(UInt32)getCurrentChannel
{
  return  [_radioManger getCurrentChannel];
}

-(void)switchMute
{
  [_radioManger switchMute];
}

-(void)getChannelList
{
  [_radioManger getChannelList];
}

-(void)setBand:(UInt32)band
{
  [_radioManger setBand:band];
}

@end
