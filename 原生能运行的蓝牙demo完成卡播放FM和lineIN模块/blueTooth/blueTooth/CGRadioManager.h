//
//  CGRadioManager.h
//  blueTooth
//
//  Created by duluyang on 15/5/22.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @protocol RadioDelegate
 *
 *  @discussion 对象的代理需遵循 <code>CGRadioDelegate</code>协议.
 */
@protocol CGRadioDelegate <NSObject>

/*!
 *  @method CGmanagerReady:
 *
 *  @param mode 音箱当前的模式
 *
 *  @abstract {@link RadioManager}对象准备就绪
 *
 *  @seealso FuncMode
 */
-(void)CGmanagerReady:(UInt32)mode;
/*!
 *  @method CGradioListChanged:
 *
 *  @param channelList 电台列表
 *
 *  @abstract 音箱返回搜到得电台列表
 */
-(void)CGradioListChanged:(NSMutableArray*)channelList;
/*!
 *  @method CGradioStateChanged:
 *
 *  @param state 当前模式
 *
 *  @abstract 收音机当前模式变化
 */
-(void)CGradioStateChanged:(UInt32)state;
/*!
 *  @method CGchannelChanged:
 *
 *  @param channel 当前电台频率
 *
 *  @abstract 当前电台频率变化
 *
 *  @seealso select:
 */
-(void)CGchannelChanged:(UInt32)channel;
/*!
 *  @method CGbandChanged:
 *
 *  @param band 当前频段
 *
 *  @abstract 收音机当前频段变化
 *
 *  @seealso setBand:
 *  @seealso RadioBand
 */
-(void)CGbandChanged:(UInt32)band;

@end

@interface CGRadioManager : NSObject

/**
 *  设置CGRadioDelegate代理方法
 *
 *  @param delegate
 */
- (void)setWithCGMusciDelegate:(id<CGRadioDelegate>)delegate;

/*!
 *  @method select:
 *
 *  @param channel 电台频率
 *
 *  @abstract 设置电台频率
 *
 *  @seealso channelChanged:
 */
-(void)select:(UInt32)channel;
/*!
 *  @method scanStart:
 *
 *  @abstract 开始搜台
 */
-(void)scanStart;
/*!
 *  @method scanStop
 *
 *  @abstract 结束搜台
 */
-(void)scanStop;
/*!
 *  @method getCurrentChannel
 *
 *  @return 当前电台频率
 *
 *  @abstract 获取当前电台频率
 */
-(UInt32)getCurrentChannel;
/*!
 *  @method switchMute
 *
 *  @abstract 设置收音机静音状态
 */
-(void)switchMute;
/*!
 *  @method getChannelList
 *
 *  @abstract 获取电台列表
 *
 *  @seealso radioListChanged:
 */
-(void)getChannelList;
/*!
 *  @method setBand:
 *
 *  @param band 收音机频段
 *
 *  @abstract 切换收音机频段
 *
 *  @discussion 可选中/美、日本、欧洲，三种频段。
 *
 *  @seealso bandChanged:
 *  @seealso RadioBand
 */
-(void)setBand:(UInt32)band;

@end
