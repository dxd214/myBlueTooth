//
//  OABlueToothManager.h
//  blueTooth
//
//  Created by duluyang on 15/4/16.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BluzDevice.h"
//#import "BluzManager.h"
#import "OABluetoothDeviceEntry.h"
#import "OADelegate.h"

@protocol OADelegate <LMBluetoothDelegate>



@end


@interface OABlueToothManager : NSObject

#pragma mark -----------------1.获取单例-----------------

+(OABlueToothManager *)sharedInstance;


#pragma mark -----------------2.蓝牙相关的Manager-----------------
/**
 *  蓝牙连接器：负责蓝牙设备的搜索，连接，断开
 */
@property (nonatomic,strong)   BluzDevice         *bluzDeviceConnector;
/**
 *  蓝牙媒体Manager，负责获取：m_GlobalManager，m_CardMusicManager，m_RadioManager，m_AlarmManager，m_AuxManager
 */
@property (nonatomic,strong)   BluzManager        *bluzManager;
/**
 *  蓝牙全局Manager，负责蓝牙设备的全局性操作：volume设置，EQ设置，自定义命令发送，切换蓝牙设备工作mode
 */
@property (nonatomic,strong)   id<GlobalManager>   globalManager;

/**
 *  蓝牙卡播放/U盘播放Manager，负责卡播放的play/pause/next/pre/loopMode操作，获取card/Uhost列表，获取正在播放歌曲的duration，currentTime
 */
@property (nonatomic,strong)   id<MusicManager>    cardMusicManager;

/**
 *  蓝牙设备的外音Manager
 */
@property (nonatomic,strong)   id<AuxManager>      auxManager;

/**
 *  蓝牙设备的FM收音机Manager
 */
@property (nonatomic,strong)   id<RadioManager>    radioManager;

@property (nonatomic,strong)  id<AlarmManager>     alarmManager;





#pragma mark -----------------3.bluzDeviceConnector 的状态变量和相关方法----------

/**
 *  搜索到的蓝牙设备数组，里面放LMBluetoothDeviceEntry
 */
@property (nonatomic,strong) NSMutableArray *bluetoothConnector_deviceBeanArray;

/**
 *  当前已连接的设备的LMBluetoothDeviceEntry
 */
@property (nonatomic,strong) OABluetoothDeviceEntry *bluetoothConnector_connectedBluetoothDeviceEntry;


#pragma mark -----------------5.m_GlobalManager的状态变量-----------------
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


#pragma mark -----------------6.m_CardMusicManager的状态变量-----------------
/**
 *  播放列表,里面放MusicEntry
 */
@property (nonatomic,strong) NSMutableArray *card_musicEntryArray;
/**
 *  当前播放模式：见LoopMode
 */
@property (nonatomic,assign) UInt32 card_currentLoopMode;
/**
 *  音乐播放状态(TF卡/U盘,两mode互斥)
 */
@property (nonatomic,assign) BOOL   card_isPlaying;
/**
 *  当前选中的歌曲（状态可能是play/pause）
 */
@property (nonatomic,strong) MusicEntry *card_currentMusicEntry;

#pragma mark -----------------9.m_AuxManager的状态变量-----------------
/**
 *  外音模式下是否静音
 */
@property (nonatomic,assign) BOOL aux_isMute;



#pragma mark -----------------7.m_RadioManager的状态变量-----------------
/**
 *  FM收音机的当前频率
 */
@property (nonatomic,assign) UInt32 radio_currentChannel;
/**
 *  FM收音机的当前频带
 */
@property (nonatomic,assign) UInt32 radio_currentBand;

/**
 *  给当前频带的用户添加的channel，增加一条记录。并归档。 重复不添加
 *
 *  @param channel 频率
 *
 *  @return 添加成功与否：1.重复则return NO； 2.归档不成功return NO；3.归档成功return YES
 */
-(BOOL)radio_addUserAddedChannel:(UInt32)channel;

/**
 *  删除当前Band，index位置的用户添加的频道，并更新归档
 *
 *  @param index 想要删除的channel的数组下标
 *
 *  @return 是否删除成功
 */
-(BOOL)radio_delUserAddedChannelOfCurrentBandAtIndex:(UInt32)index;
/**
 *  获取当前Band下，用户添加的channel数组
 */
-(NSMutableArray *)radio_getUserAddedChannelArrayOfCurrentBand;
/**
 *  获取BAND_CHINA_US下，用户添加的channel数组
 */
-(NSMutableArray *)radio_getUserAddedChannelArrayOfBAND_CHINA_US;
/**
 *  获取BAND_JAPAN下，用户添加的channel数组
 */
-(NSMutableArray *)radio_getUserAddedChannelArrayOfBAND_JAPAN;
/**
 *  获取BAND_EUROP下，用户添加的channel数组
 */
-(NSMutableArray *)radio_getUserAddedChannelArrayOfBAND_EUROP;

/**
 *  是否正在自动搜索电台
 */
@property (nonatomic,assign) BOOL radio_isSearching;
/**
 *  FM收音机播放状态：见PlayStatus
 */
@property (nonatomic,assign) BOOL radio_isMute;
/**
 *  BAND_CHINA_US频带：缓存的搜索频道列表(内存缓存，app退出才清除)
 */
@property (nonatomic,strong) NSMutableArray *radio_cachedSearchedChannelArrayOfBAND_CHINA_US;
/**
 *  BAND_JAPAN频带：缓存的搜索频道列表(内存缓存，app退出才清除)
 */
@property (nonatomic,strong) NSMutableArray *radio_cachedSearchedChannelArrayOfBAND_JAPAN;
/**
 *  BAND_EUROP频带：缓存的搜索频道列表(内存缓存，app退出才清除)
 */
@property (nonatomic,strong) NSMutableArray *radio_cachedSearchedChannelArrayOfBAND_EUROP;
/**
 *  当前频带：缓存的搜索频道列表(内存缓存，app退出才清除)。实质是：根据当前频带，获取对应频带的缓存列表
 */
@property (nonatomic,strong) NSMutableArray *radio_cachedSearchedChannelArrayOfCurrentBand;











@end
