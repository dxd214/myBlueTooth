//
//  OABlueToothManager.m
//  blueTooth
//
//  Created by duluyang on 15/4/16.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "OABlueToothManager.h"


@implementation OABlueToothManager

static OABlueToothManager *_instance;
+(OABlueToothManager *)sharedInstance {
    if (_instance == nil) {
        NSLog(@"初始化单例 LMBluetoothManager Instance");
        _instance =  [[OABlueToothManager alloc] init];
        _instance.bluzDeviceConnector = [[BluzDevice alloc] init]; //初始化 蓝牙连接器
       
        //初始化 bluzDeviceConnector 的状态量
        _instance.bluetoothConnector_deviceBeanArray = [[NSMutableArray alloc] init];
        _instance.bluetoothConnector_connectedBluetoothDeviceEntry = nil;
        
        //m_GlobalManager的状态变量
        _instance.global_currentMode = MODE_UNKNOWN;     //当前蓝牙模式
        _instance.global_currentVolume = 0;   //当前音量
        _instance.global_maxVolume = 0;       //最大音量
        _instance.global_minVolume= 0;        //最小音量
        _instance.global_isMute = NO;          //是否静音
        _instance.global_currentBattery= 0;    //当前电池电量
        _instance.global_isTFAvaiable= NO;     //TF卡是否可用
        
        //m_CardMusicManager的状态变量
        _instance.card_musicEntryArray = [[NSMutableArray alloc]init];
        _instance.card_currentLoopMode = LOOP_MODE_ALL;
        _instance.card_isPlaying = NO;
        _instance.card_currentMusicEntry = nil;
        
        //m_AuxManager的状态变量
        _instance.aux_isMute = NO;     //是否静音
        
        //m_RadioManager的状态变量
        //        _instance.radio_currentState = STATE_UNKNOWN;    //状态：STATE_UNKNOWN，STATE_PAUSED，STATE_PLAYING
        _instance.radio_currentBand = 0;    //频带
    }
    return _instance;
}



-(void)setConnectDelegate:(id<ConnectDelegate>) delegate
{
    [_bluzDeviceConnector setConnectDelegate:delegate];
}
-(void)scanStop
{
    [_bluzDeviceConnector scanStop];
}
-(void)scanStart
{
    [_bluzDeviceConnector scanStart];
}
-(void)connect:(CBPeripheral*)peripheral
{
    [_bluzDeviceConnector connect:peripheral];
}

-(void)disconnect:(CBPeripheral*)peripheral
{
    [_bluzDeviceConnector disconnect:peripheral];
}

-(void)setAppForeground:(BOOL)foreground
{
    [_bluzDeviceConnector setAppForeground:foreground];
}

-(void)close
{
    [_bluzDeviceConnector close];
}


@end
