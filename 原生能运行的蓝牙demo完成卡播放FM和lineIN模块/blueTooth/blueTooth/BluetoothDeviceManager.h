/*!
 *  @header BluetoothDeviceManager.h
 *
 *  @abstract 蓝牙BLE设备扫描及连接对象、全局控制对象、Bluz控制对象
 *
 *  @author Actions Semi.
 */
//  BluetoothDeviceManager.h
//  blueTooth
//
//  Created by duluyang on 15/4/28.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzDevice.h"
#import "BluzManager.h"
#import "GlobalManager.h"
#import "BluetoothDeviceEntry.h"
#import "CGBluetoothDeviceReadingPenManager.h"
#import "CGMusicManager.h"
#import "CGRadioManager.h"
#import "CGAuxManager.h"
#import "CGAlarmManager.h"


/*!
 *  @protocol ConnectDelegate
 *
 *  @abstract 蓝牙BLE搜索及连接协议.
 */

@protocol SLBlueDeviceDelegate <NSObject>

@required
/*!
 *  @method foundPeripheral:advertisementData:
 *
 *  @param peripheral 蓝牙设备对象
 *  @param advertisementData 包含蓝牙设备广播信息或者蓝牙搜索回应数据的字典容器。
 *
 *  @abstract 搜索蓝牙时返回的蓝牙设备信息。
 *
 *  @seealso scanStart
 */
-(void)SLfoundPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData;
/*!
 *  @method connectedPeripheral:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 连接蓝牙时返回已经连接上的蓝牙设备信息。
 *
 *  @seealso connect:
 */
-(void)SLconnectedPeripheral:(CBPeripheral*) peripheral;

@optional
/*!
 *  @method disconnectedPeripheral:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 断开蓝牙时返回已经断开的蓝牙设备信息。
 *
 *  @seealso disconnect:
 */
-(void)SLdisconnectedPeripheral:(CBPeripheral*) peripheral;
/*!
 *  @method disconnectedPeripheral:initiative:
 *
 *  @param peripheral 蓝牙设备对象
 *  @param onInitiative 是否用户主动断开连接
 *
 *  @abstract 断开蓝牙时返回已经断开的蓝牙设备信息。
 *
 *  @seealso disconnect:
 */
-(void)SLdisconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative;

@end


/**
 *  SLGlobalDelegate, 全局状态监听回调
 */
@protocol SLGlobalDelegate <NSObject>

/*!
 *  @method managerReady
 *
 *  @abstract {@link GlobalManager}对象准备就绪
 */
-(void)SLmanagerReady;
/*!
 *  @method soundEffectChanged:
 *
 *  @param mode 音效模式
 *
 *  @abstract 音箱音效模式变化
 *
 *  @seealso SoundEffect
 */
-(void)SLsoundEffectChanged:(UInt32)mode;
/*!
 *  @method eqModeChanged:
 *
 *  @param mode EQ模式
 *
 *  @abstract EQ模式变化
 *
 *  @seealso EQMode
 */
-(void)SLeqModeChanged:(UInt32)mode;
/*!
 *  @method daeModeChangedWithVBASS:andTreble:
 *
 *  @param vbassEnable 虚拟低音音效使能状态
 *  @param trebleEnable 高音增强音效使能状态
 *
 *  @abstract DAE音效模式变化
 */
-(void)SLdaeModeChangedWithVBASS:(BOOL)vbassEnable andTreble:(BOOL)trebleEnable;
/*!
 *  @method batteryChanged:charging:
 *
 *  @param battery 电池电量状态
 *  @param charging 充放电状态
 *
 *  @abstract 音箱电池电量或充放电状态变化
 */
-(void)SLbatteryChanged:(UInt32)battery charging:(BOOL)charging;
/*!
 *  @method volumeChanged:max:min:isMute:
 *
 *  @param current 当前音量
 *  @param max 支持的最大音量
 *  @param min 支持的最小音箱
 *  @param mute 静音状态
 *
 *  @abstract 音箱静音及音量状态变化
 */
-(void)SLvolumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute;
/*!
 *  @method modeChanged:
 *
 *  @param mode 功能模式
 *
 *  @abstract 音箱功能模式变化
 *
 *  @seealso FuncMode
 */
-(void)SLmodeChanged:(UInt32)mode;
/*!
 *  @method hotplugCardChanged:
 *
 *  @param visibility 卡状态
 *
 *  @abstract 音箱外置卡插拔状态变化
 */
-(void)SLhotplugCardChanged:(BOOL)visibility;
/*!
 *  @method hotplugUhostChanged:
 *
 *  @param visibility U盘状态
 *
 *  @abstract 音箱外置U盘插拔状态变化
 */
-(void)SLhotplugUhostChanged:(BOOL)visibility;
/*!
 *  @method lineinChanged:
 *
 *  @param visibility linein线状态
 *
 *  @abstract 音箱Linein连接线插拔状态变化
 */
-(void)SLlineinChanged:(BOOL)visibility;
/*!
 *  @method dialogMessageArrived:messageID:
 *
 *  @param type 对话框类型
 *  @param messageId 对话框信息序号
 *
 *  @abstract 显示音箱对话框
 *
 *  @seealso DialogType
 */
-(void)SLdialogMessageArrived:(UInt32)type messageID:(UInt32)messageId;
/*!
 *  @method toastMessageArrived:
 *
 *  @param messageId 提示信息序号
 *
 *  @abstract 显示音箱提示信息
 *
 *  @seealso
 */
-(void)SLtoastMessageArrived:(UInt32)messageId;
/*!
 *  @method dialogCancel
 *
 *  @abstract 取消音箱提示信息
 */
-(void)SLdialogCancel;
/*!
 *  @method customCommandArrived:param1:param2:others:
 *
 *  @param cmdKey 自定义命令
 *  @param arg1 命令参数一
 *  @param arg2 命令参数二
 *  @param data 其他命令数据
 *
 *  @abstract 自定义命令回调
 *
 *  @seealso buildKey:cmdID:
 *
 *  @discussion 示例代码:
 *
 *      -(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data {
 *
 *      if (cmdKey == [appDele.globalManager buildKey:ANS cmdID:0x80]) {
 *
 *          //收到自定义命令回调，处理返回信息
 *
 *      }
 */
-(void)SLcustomCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data;

@end



@interface BluetoothDeviceManager : NSObject<ConnectDelegate,GlobalDelegate,GlobalManager>

#pragma mark -----------------1.获取单例-----------------

+(BluetoothDeviceManager *)sharedInstance;


#pragma mark -----------------2.蓝牙相关的Manager-----------------

/**
 *  蓝牙连接器：负责蓝牙设备的搜索，连接，断开
 */
@property (nonatomic,strong)   BluzDevice         *bluzDeviceConnector;
@property (nonatomic,weak) id<SLBlueDeviceDelegate> blueDeviceDelegate;

@property (nonatomic,assign) BOOL connected;
/**
 *  搜索到的蓝牙设备数组，里面放LMBluetoothDeviceEntry
 */
@property (nonatomic,strong) NSMutableArray *bluetoothConnector_deviceBeanArray;

/**
 *  当前已连接的设备的LMBluetoothDeviceEntry
 */
@property (nonatomic,strong) BluetoothDeviceEntry *bluetoothConnector_connectedBluetoothDeviceEntry;




/**
 *  蓝牙媒体Manager，负责获取：m_GlobalManager，m_CardMusicManager，m_RadioManager，m_AlarmManager，m_AuxManager
 */
@property (nonatomic,strong)   BluzManager        *bluzManager;
/**
 *  蓝牙全局Manager，负责蓝牙设备的全局性操作：volume设置，EQ设置，自定义命令发送，切换蓝牙设备工作mode
 */
@property (nonatomic,weak) id<GlobalManager>   globalManager;

@property (nonatomic,weak) id<SLGlobalDelegate> slGlobalDelegate;

/**
 *  点读笔相关的代理
 */
@property (nonatomic,weak) id<SLBluetoothDeviceReadingPenDelegate> slBluetoothDeviceReadingPenDelegate;
/**
 *  当前蓝牙工作模式：见FuncMode
 */
@property (nonatomic,assign) UInt32 global_currentMode;
/**
 *  当前音量
 */
@property (nonatomic,assign) UInt32 global_currentVolume;
/**
 *  最大音量
 */
@property (nonatomic,assign) UInt32 global_maxVolume;
/**
 *  最小音量
 */
@property (nonatomic,assign) UInt32 global_minVolume;
/**
 *  是否静音
 */
@property (nonatomic,assign) BOOL   global_isMute;
/**
 *  当前电池电量
 */
@property (nonatomic,assign) UInt32 global_currentBattery;
/**
 *  TF卡是否可用
 */
@property (nonatomic,assign) BOOL   global_isTFAvaiable;
/**
 *  U盘是否可用
 */
@property (nonatomic,assign) BOOL   global_isUhostAvaiable;
/**
 *  外音是否可用（AUX就是Linein）
 */
@property (nonatomic,assign) BOOL   global_isLineinAvaiable;
/**
 *  自定义命令key：在m_GlobalManager的onManagerReady时候初始化，一般就初始化一次
 */
@property (nonatomic,assign)  int   global_cmdKey;
/**
 *  检验chipsID的随机数
 */
@property (nonatomic,assign)  int   global_randomNumber4CheckChipsID;
/**
 *  自定义命令的设备id
 */
@property (nonatomic,assign)  int   global_BTDeviceID;
/**
 *  设备的mac(mac地址不区分大小写)地址过滤set:
 *     1.set中没有Object则不做mac地址过滤
 *     2.set中有Object，则mac地址前缀在set中的才会显示
 *     3.增加mac地址过滤例子：[[LMBluetoothManager sharedInstance].global_deviceMacFilterMutableSet addObject:@"C9:3"]，mac地址前缀为C9:3/c9:3才显示
 */
@property (nonatomic,strong) NSMutableSet *global_deviceMacFilterMutableSet;


#pragma mark ----------------3.蓝牙连接成功后初始化 bluzManager -----------------------
/**
 *  初始化 bluzManager ,需要在蓝牙连接成功后调用
 *
 *  @return 初始化成功返回YES
 */
- (BOOL)initBluzManager;

#pragma mark -------4.初始化 SLglobalManager、CGMusicManager、CGMusicManager、CGAuxManager、CGAlarmManager------------
/**
 *  初始化 globalManager, 需要在bluzManager初始化完成之后调用
 *
 *  @return 初始化成功返回YES
 */
- (BOOL)initGlobalManagerWithDelegate:(id<SLGlobalDelegate>)delegate;

/**
 *  获取CGMusicManager的方法
 *
 *  @param delegate CGMusicDelegate 代理
 *
 *  @return CGMusicManager
 */
-(CGMusicManager *)getCGMusicManagerWithDelegate:(id<CGMusicDelegate>)delegate;

/**
 *  获取CGRadioManager的方法
 *
 *  @param delegate CGRadioDelegate 代理
 *
 *  @return CGRadioManager
 */
-(CGRadioManager *)getCGRadioManagerWithDelegate:(id<CGRadioDelegate>)delegate;
/**
 *  获取CGAuxManager的方法
 *
 *  @param delegate CGAuxDelegate 代理
 *
 *  @return CGAuxManager
 */
-(CGAuxManager *)getCGAuxManagerWithDelegate:(id<CGAuxDelegate>)delegate;

/**
 *  获取CGAlarmManager的方法
 *
 *  @param delegate CGAlarmDelegate 代理
 *
 *  @return CGAlarmManager
 */
-(CGAlarmManager *)getCGAlarmManagerWithDelegate:(id<CGAlarmDelegate>)delegate;


#pragma mark ----------------5.蓝牙连接相关的操作-----------------------
/*!
 *  @method setConnectDelegate:
 *
 *  @param delegate 蓝牙设备搜索及连接协议
 *
 *  @abstract 设置蓝牙设备搜索及连接协议。
 *
 *  @seealso ConnectDelegate
 */
-(void)setConnectDelegate:(id<SLBlueDeviceDelegate>) delegate;
/*!
 *  @method scanStop
 *
 *  @abstract 停止搜索周围蓝牙设备。
 */
-(void)scanStop;
/*!
 *  @method scanStart
 *
 *  @abstract 开始搜索周围的蓝牙设备。
 *
 *  @seealso foundPeripheral:advertisementData:
 */
-(void)scanStart;
/*!
 *  @method connect:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 主动连接设定的蓝牙设备。
 *
 *  @seealso connectedPeripheral:
 */
-(void)connect:(CBPeripheral*)peripheral;
/*!
 *  @method disconnect:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 主动断开当前已经连接的蓝牙设备。
 *
 *  @seealso disconnectedPeripheral:
 */
-(void)disconnect:(CBPeripheral*)peripheral;
/*!
 *  @method setAppForeground:
 *
 *  @param foreground 应用前后台状态
 *
 *  @abstract 通知iBluz应用当前的前、后台状态
 *
 *  @discussion 在后台时iBluz不进行BLE的数据收发，用以优化音箱资源开销。
 */
-(void)setAppForeground:(BOOL)foreground;
/*!
 *  @method close
 *
 *  @abstract 关闭并清理<code>BluzDevice</code>类对象。
 */
-(void)close;


#pragma mark --------------6、全局控制接口 globalManager 初始化成功后调用--------------------

/*!
 *  @method isFeatureSupport:
 *
 *  @param offset 偏移量
 *
 *  @return 是否支持该功能
 *
 *  @abstract 根据特定offset判断音箱是否支持相应功能
 *
 *  @seealso FeatureSupport
 */
-(BOOL)isFeatureSupport:(UInt32)offset;
/*!
 *  @method getMusicFolder
 *
 *  @return 特殊目录列表
 *
 *  @abstract 获取音箱特殊目录
 */
-(NSMutableArray *)getMusicFolder;
/*!
 *  @method setVolume:
 *
 *  @param volume 音量值
 *
 *  @abstract 设置音箱音量
 */
-(void)setVolume:(UInt32)volume;
/*!
 *  @method switchMute
 *
 *  @abstract 设置音箱静音状态
 */
-(void)switchMute;
/*!
 *  @method setMode:
 *
 *  @param mode 功能模式
 *
 *  @abstract 切换音箱的功能模式
 *
 *  @seealso FuncMode
 */
-(void)setMode:(UInt32)mode;
/*!
 *  @method setEQMode:
 *
 *  @param mode EQ模式
 *
 *  @abstract 设置音箱的EQ模式
 *
 *  @seealso EQMode
 */
-(void)setEQMode:(UInt32)mode;
/*!
 *  @method setEQParam:
 *
 *  @param values EQ各频点值
 *
 *  @abstract 设置用户EQ的各个频点值
 */
-(void)setEQParam:(int[])values;
/*!
 *  @method setSoundEffect:eqMode:userEQParam:vbassState:trebleState:
 *
 *  @param effect 音效模式
 *  @param eq EQ模式
 *  @param values 用户EQ频点值
 *  @param vbassEnable 虚拟低音音效使能状态
 *  @param trebleEnable 高音增强音效使能状态
 *
 *  @abstract 设置音箱的音效模式和参数
 *
 *  @seealso SoundEffect
 *  @seealso EQMode
 */
-(void)setSoundEffect:(UInt32)effect eqMode:(UInt32)eq userEQParam:(int[])values vbassState:(BOOL)vbassEnable trebleState:(BOOL)trebleEnable;
/*!
 *  @method setDialogTimeout:
 *
 *  @param timeout 超时时间
 *
 *  @abstract 设置对话框的超时时间
 */
-(void)setDialogTimeout:(UInt32)timeout;
/*!
 *  @method dialogResponse:
 *
 *  @param response 按键序号
 *
 *  @abstract 通知音箱用户点击的按键序号
 *
 *  @seealso DialogAnswer
 */
-(void)dialogResponse:(UInt32)response;
/*!
 *  @method sendCustomCommand:param1:param2:others:
 *
 *  @param cmdKey 命令号
 *  @param arg1 参数一
 *  @param arg2 参数二
 *  @param data 其他参数
 *
 *  @abstract 发送用户自定义命令
 *
 *  @seealso buildKey:cmdID:
 *
 *  @discussion 示例代码:
 *
 *      int key = [appDele.globalManager buildKey:QUE cmdID:0x80];
 *
 *      if (key != -1) {
 *
 *         [appDele.globalManager sendCustomCommand:key param1:0 param2:0 others:nil];
 *
 *      }
 *
 */
-(void)sendCustomCommand:(int)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data;
/*!
 *  @method buildKey:cmdID:
 *
 *  @param cmdType 命令类型
 *  @param cmdId 命令号
 *
 *  @return 自定义命令,-1为无效命令
 *
 *  @abstract 生成自定义命令
 */
-(int)buildKey:(int)cmdType cmdID:(int)cmdId;

#pragma mark ------------7、获取蓝牙设备状态------------------

/**
 *  获取蓝牙设备电池电量
 *
 *  @return 电池电量
 */
- (UInt32)getbattery;

/**
 *  获取蓝牙设备SD卡插拔状态
 *
 *  @return 1表示有卡；0表示没卡。
 */
- (int)getCardState;

/**
 *  获取蓝牙设备lineIn线的插拔状态
 *
 *  @return 1表示已插入；0表示已拔出
 */
- (int)getLineInState;
/**
 *  获取蓝牙设备USB插入状态
 *
 *  @return 1表示已插入；0表示已拔出
 */
- (int)getUSBState;

@end


