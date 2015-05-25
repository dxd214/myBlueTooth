//
//  CGMusicManager.h
//  blueTooth
//
//  Created by duluyang on 15/5/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicEntry;

/*!
 *  @protocol CGMusicDelegate;
 *
 *  @discussion 对象的代理需遵循 <code>CGMusicDelegate</code>协议.
 */
@protocol CGMusicDelegate <NSObject>
/*!
 *  @method managerReady:
 *
 *  @param mode 音箱当前的模式
 *
 *  @abstract {@link MusicManager}对象准备就绪
 *
 *  @seealso FuncMode
 */
-(void)CGmanagerReady:(UInt32)mode;
/*!
 *  @method CGlyricReady:lyric:
 *
 *  @param lyric 歌曲数据
 *
 *  @abstract 音箱返回指定歌曲的歌词信息
 *
 *  @seealso getLyric:
 */
-(void)CGlyricReady:(UInt32)index lyric:(NSData*)lyric;
/*!
 *  @method CGmusicEntryChanged:
 *
 *  @param entry 当前播放的音乐条目
 *
 *  @abstract 音箱播放音乐条目切换
 */
-(void)CGmusicEntryChanged:(MusicEntry*) entry;
/*!
 *  @method CGloopModeChanged:
 *
 *  @param mode 当前循环播放
 *
 *  @abstract 音箱当前循环模式变化
 *
 *  @seealso LoopMode
 */
-(void)CGloopModeChanged:(UInt32) mode;
/*!
 *  @method CGstateChanged:
 *
 *  @param state 当前播放状态
 *
 *  @abstract 音箱播放状态变化
 *
 *  @seealso PlayStatus
 */
-(void)CGstateChanged:(UInt32) state;
/*!
 *  @method CGcontentChanged
 *
 *  @abstract 音箱播放列表变化，应用需重新同步播放列表。
 */
-(void)CGcontentChanged;
/*!
 *  @method CGpListEntryReady:
 *
 *  @param entryList 播放列表
 *
 *  @abstract 音箱发送播放列表。
 *
 *  @seealso getPListFrom:withCount:
 */
-(void)CGpListEntryReady:(NSMutableArray*)entryList;

@end

@interface CGMusicManager : NSObject 

/**
 *  设置CGMusicDelegate代理方法
 *
 *  @param delegate 
 */
- (void)setWithCGMusciDelegate:(id<CGMusicDelegate>)delegate;

/*!
 *  @method play
 *
 *  @abstract 播放
 */
-(void)play;
/*!
 *  @method pause
 *
 *  @abstract 暂停
 */
-(void)pause;
/*!
 *  @method next
 *
 *  @abstract 下一首
 */
-(void)next;
/*!
 *  @method previous
 *
 *  @abstract 上一首
 */
-(void)previous;
/*!
 *  @method select:
 *
 *  @param index 音乐序号
 *
 *  @abstract 设置指定序号音乐播放
 */
-(void)select:(UInt32)index;
/*!
 *  @method getCurrentPosition
 *
 *  @return 音乐当前播放时间
 *
 *  @abstract 获取音乐当前播放时间
 */
-(UInt32)getCurrentPosition;
/*!
 *  @method getDuration
 *
 *  @return 音乐总时间
 *
 *  @abstract 获取音乐总时间
 */
-(UInt32)getDuration;
/*!
 *  @method setLoopMode:
 *
 *  @param mode 循环模式
 *
 *  @abstract 设置音乐播放循环模式
 *
 *  @seealso LoopMode
 */
-(void)setLoopMode:(UInt32)mode;
/*!
 *  @method setPList:length:
 *
 *  @param pList 播放列表
 *  @param length 列表长度
 *
 *  @abstract 设置指定长度的播放列表到音箱
 */
-(void)setPList:(UInt32[])pList length:(UInt32)length;
/*!
 *  @method getPListSize
 *
 *  @return 歌曲列表大小
 *
 *  @abstract 获取歌曲列表大小
 */
-(UInt32)getPListSize;
/*!
 *  @method getPListFrom:withCount:
 *
 *  @param start 开始序号
 *  @param count 音乐个数
 *
 *  @abstract 从start位置开始获取count个音乐文件信息
 *
 * @seealso pListEntryReady:
 */
-(void)getPListFrom:(UInt32)start withCount:(UInt32)count;
/*!
 *  @method getLyric:
 *
 *  @param index 音乐序号
 *
 *  @abstract 获取指定序号歌曲歌词信息
 */
-(void)getLyric:(UInt32)index;

@end
