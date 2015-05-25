//
//  BluetoothDeviceManager.m
//  blueTooth
//
//  Created by duluyang on 15/4/28.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "BluetoothDeviceManager.h"

@implementation BluetoothDeviceManager

static BluetoothDeviceManager *_instance;

+(BluetoothDeviceManager *)sharedInstance {
    if (_instance == nil) {
        NSLog(@"初始化单例 BluetoothDeviceManager Instance");
        _instance =  [[BluetoothDeviceManager alloc] init];
        _instance.bluzDeviceConnector = [[BluzDevice alloc] init]; //初始化 蓝牙连接器
        
        //初始化 bluzDeviceConnector 的状态量
        _instance.bluetoothConnector_deviceBeanArray = [[NSMutableArray alloc] init];
        _instance.bluetoothConnector_connectedBluetoothDeviceEntry = nil;
        _instance.connected = NO;
        _instance.global_deviceMacFilterMutableSet = [[NSMutableSet alloc] init];
        
        //m_GlobalManager的状态变量
        _instance.global_currentMode = MODE_UNKNOWN;     //当前蓝牙模式
        _instance.global_currentVolume = 0;    //当前音量
        _instance.global_maxVolume = 0;        //最大音量
        _instance.global_minVolume= 0;         //最小音量
        _instance.global_isMute = NO;          //是否静音
        _instance.global_currentBattery= 0;    //当前电池电量
        _instance.global_isTFAvaiable= NO;     //TF卡是否可用
    }
    return _instance;
}


#pragma mark ConnectDelegate  蓝牙连接相关的回调方法
-(void)foundPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData
{
    if ([self.blueDeviceDelegate respondsToSelector:@selector(SLfoundPeripheral:advertisementData:)]) {
        [self.blueDeviceDelegate SLfoundPeripheral:peripheral advertisementData:advertisementData];
    }
}
-(void)connectedPeripheral:(CBPeripheral*) peripheral
{
    //连接成功后 设置connect值为YES
    [BluetoothDeviceManager sharedInstance].connected = YES;
    if ([self.blueDeviceDelegate respondsToSelector:@selector(SLconnectedPeripheral:)]) {
        [self.blueDeviceDelegate SLconnectedPeripheral:peripheral];
    }
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral
{
    //断开连接 设置connect值为NO
    [BluetoothDeviceManager sharedInstance].connected = NO;
    if ([self.blueDeviceDelegate respondsToSelector:@selector(SLdisconnectedPeripheral:)]) {
        [self.blueDeviceDelegate SLdisconnectedPeripheral:peripheral];
    }
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative
{
    //断开连接 设置connect值为NO
    [BluetoothDeviceManager sharedInstance].connected = NO;
    if ([self.blueDeviceDelegate respondsToSelector:@selector(SLdisconnectedPeripheral:initiative:)]) {
        [self.blueDeviceDelegate SLdisconnectedPeripheral:peripheral initiative:onInitiative];
    }
}

#pragma mark GlobalDelegate  蓝牙全局信息的回调方法
-(void)managerReady
{
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLmanagerReady)]) {
       [self.slGlobalDelegate SLmanagerReady];
    }
}

-(void)soundEffectChanged:(UInt32)mode
{
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLsoundEffectChanged:)]) {
      [self.slGlobalDelegate SLsoundEffectChanged:mode];
    }
}

-(void)eqModeChanged:(UInt32)mode
{
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLeqModeChanged:)]) {
      [self.slGlobalDelegate SLeqModeChanged:mode];
    }
}

-(void)daeModeChangedWithVBASS:(BOOL)vbassEnable andTreble:(BOOL)trebleEnable
{
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLdaeModeChangedWithVBASS:andTreble:)]) {
      [self.slGlobalDelegate SLdaeModeChangedWithVBASS:vbassEnable andTreble:trebleEnable];
    }
}

-(void)batteryChanged:(UInt32)battery charging:(BOOL)charging
{
    //回调一次后，保存电池电量
    [BluetoothDeviceManager sharedInstance].global_currentBattery = battery;
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLbatteryChanged:charging:)]) {
      [self.slGlobalDelegate SLbatteryChanged:battery charging:charging];
    }
}

-(void)volumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute
{
    //bao存最大、最小、是否静音
    [BluetoothDeviceManager sharedInstance].global_maxVolume = max;
    [BluetoothDeviceManager sharedInstance].global_minVolume = min;
    [BluetoothDeviceManager sharedInstance].global_isMute = mute;
    
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLvolumeChanged:max:min:isMute:)]) {
        [self.slGlobalDelegate SLvolumeChanged:current max:max min:min isMute:mute];
    }
}

-(void)modeChanged:(UInt32)mode
{
    //模式变化后保存当前模式
    [BluetoothDeviceManager sharedInstance].global_currentMode = mode;
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLmodeChanged:)]) {
       [self.slGlobalDelegate SLmodeChanged:mode];
    }
}

-(void)hotplugCardChanged:(BOOL)visibility
{
    //保存卡状态
    [BluetoothDeviceManager sharedInstance].global_isTFAvaiable = visibility;
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLhotplugCardChanged:)]) {
        [self.slGlobalDelegate SLhotplugCardChanged:visibility];
    }
}

-(void)hotplugUhostChanged:(BOOL)visibility
{
    //保存U盘状态
    [BluetoothDeviceManager sharedInstance].global_isUhostAvaiable = visibility;
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLhotplugUhostChanged:)]) {
      [self.slGlobalDelegate SLhotplugUhostChanged:visibility];
    }
}

-(void)lineinChanged:(BOOL)visibility
{
    //保存LinIn状态
    [BluetoothDeviceManager sharedInstance].global_isLineinAvaiable = visibility;
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLlineinChanged:)]) {
       [self.slGlobalDelegate SLlineinChanged:visibility];
    }
}

-(void)dialogMessageArrived:(UInt32)type messageID:(UInt32)messageId
{
    if ( [self.slGlobalDelegate respondsToSelector:@selector(SLdialogMessageArrived:messageID:)]) {
        [self.slGlobalDelegate SLdialogMessageArrived:type messageID:messageId];
    }
}

-(void)toastMessageArrived:(UInt32)messageId
{
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLtoastMessageArrived:)]) {
        [self.slGlobalDelegate SLtoastMessageArrived:messageId];
    }
}

-(void)dialogCancel
{
    if ([self.slGlobalDelegate respondsToSelector:@selector(SLdialogCancel)]) {
        [self.slGlobalDelegate SLdialogCancel];
    }
}

-(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data
{
    Byte *byteData = (Byte*)malloc([data length]);
    memcpy(byteData, [data bytes], [data length]);
    for (int i=0; i<[data length]; i++) {
        NSLog(@"data[%d]=%d",i,byteData[i]);
    }
    
    //收到的数据，转化为点读书上的int值
    Byte bytes[] = {byteData[5],byteData[6],byteData[7],byteData[8]};
    int valueOfBook = 0;  //点读书上的int值
    // 由高位到低位
    for (int i = 0; i < 4; i++){
        int shift = (4 - 1 - i) * 8;
        valueOfBook += (bytes[i] & 0x000000FF) << shift;// 往高位游
    }
    NSLog(@"书上的值valueOfBook=%d",valueOfBook);
    
    if (byteData[2]==7) { //点读笔设备
        if([self.slBluetoothDeviceReadingPenDelegate respondsToSelector:@selector(SLvalueOfBook:)]) {
            [self.slBluetoothDeviceReadingPenDelegate SLvalueOfBook:valueOfBook];
        }else{
            NSLog(@"点读笔设备未实现 SLBluetoothDeviceReadingPenDelegate 代理的 SLvalueOfBook: 方法");
        }
    }else{ //非点读笔设备
        if([self.slGlobalDelegate respondsToSelector:@selector(SLcustomCommandArrived:param1:param2:others:)]){
          [self.slGlobalDelegate SLcustomCommandArrived:cmdKey param1:arg1 param2:arg2 others:data];
        }
    }
}


#pragma Mark BlueToothDeviceManager 的成员方法

-(void)setConnectDelegate:(id<SLBlueDeviceDelegate>) delegate
{
    self.blueDeviceDelegate = delegate;
    [_instance.bluzDeviceConnector setConnectDelegate:self];
}

-(void)scanStop
{
    [_instance.bluzDeviceConnector scanStop];
}

-(void)scanStart
{
    [_instance.bluzDeviceConnector scanStart];
}

-(void)connect:(CBPeripheral*)peripheral
{
    [_instance.bluzDeviceConnector connect:peripheral];
}

-(void)disconnect:(CBPeripheral*)peripheral
{
    [_instance.bluzDeviceConnector disconnect:peripheral];
}

-(void)setAppForeground:(BOOL)foreground
{
    [_instance.bluzDeviceConnector setAppForeground:foreground];
}
-(void)close
{
    [_instance.bluzDeviceConnector close];
}

- (BOOL)initBluzManager
{
    if ([BluetoothDeviceManager sharedInstance].bluzDeviceConnector == nil) {
        return NO;
    }
   [BluetoothDeviceManager sharedInstance].bluzManager = [[BluzManager alloc]initWithConnector:[BluetoothDeviceManager sharedInstance].bluzDeviceConnector];
    return YES;
}

- (BOOL)initGlobalManagerWithDelegate:(id<SLGlobalDelegate>)delegate;
{
    if ([BluetoothDeviceManager sharedInstance].bluzManager == nil) {
         NSLog(@"error  bluzManager 没有初始化");
        return NO;
    }
    [BluetoothDeviceManager sharedInstance].slGlobalDelegate = delegate;
    [BluetoothDeviceManager sharedInstance].globalManager = [[BluetoothDeviceManager sharedInstance].bluzManager getGlobalManager:self];
    return YES;
}

-(CGMusicManager*)getCGMusicManagerWithDelegate:(id<CGMusicDelegate>)delegate
{
    if ([BluetoothDeviceManager sharedInstance].bluzManager == nil) {
        NSLog(@"error  bluzManager 没有初始化");
        return nil;
    }
    return [[CGMusicManager alloc] init];
}

-(CGRadioManager *)getCGRadioManagerWithDelegate:(id<CGRadioDelegate>)delegate
{
    if ([BluetoothDeviceManager sharedInstance].bluzManager == nil) {
        NSLog(@"error  bluzManager 没有初始化");
        return nil;
    }
    return [[CGRadioManager alloc] init];
}

-(CGAuxManager *)getCGAuxManagerWithDelegate:(id<CGAuxDelegate>)delegate
{
    if ([BluetoothDeviceManager sharedInstance].bluzManager == nil) {
        NSLog(@"error  bluzManager 没有初始化");
        return nil;
    }
    return [[CGAuxManager alloc] init];
}

-(CGAlarmManager *)getCGAlarmManagerWithDelegate:(id<CGAlarmDelegate>)delegate
{
    if ([BluetoothDeviceManager sharedInstance].bluzManager == nil) {
        NSLog(@"error  bluzManager 没有初始化");
        return nil;
    }
    return [[CGAlarmManager alloc] init];
}

#pragma mark BluetoothDeviceManager 成员方法 需要在globalManager初始化成功才生效


-(BOOL)isFeatureSupport:(UInt32)offset
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return NO;
    }
    return [[BluetoothDeviceManager sharedInstance].globalManager isFeatureSupport:offset];
}

-(NSMutableArray *)getMusicFolder
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return nil;
    }
    return [[BluetoothDeviceManager sharedInstance].globalManager getMusicFolder];

}

-(void)setVolume:(UInt32)volume
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager setVolume:volume];
}

-(void)switchMute
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager switchMute];
}

-(void)setMode:(UInt32)mode
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager setMode:mode];
}

-(void)setEQMode:(UInt32)mode
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager setEQMode:mode];
}

-(void)setEQParam:(int[])values
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager setEQParam:values];
}

-(void)setSoundEffect:(UInt32)effect eqMode:(UInt32)eq userEQParam:(int[])values vbassState:(BOOL)vbassEnable trebleState:(BOOL)trebleEnable
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager setSoundEffect:effect eqMode:eq userEQParam:values vbassState:vbassEnable trebleState:trebleEnable];
}

-(void)setDialogTimeout:(UInt32)timeout
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager setDialogTimeout:timeout];
}

-(void)dialogResponse:(UInt32)response
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager dialogResponse:response];
}

-(void)sendCustomCommand:(int)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return ;
    }
    [[BluetoothDeviceManager sharedInstance].globalManager sendCustomCommand:cmdKey param1:arg1 param2:arg2 others:data];
}

-(int)buildKey:(int)cmdType cmdID:(int)cmdId
{
    if ([BluetoothDeviceManager sharedInstance].globalManager == nil) {
        return -1;
    }
    return [[BluetoothDeviceManager sharedInstance].globalManager buildKey:cmdType cmdID:cmdId];
}

@end
