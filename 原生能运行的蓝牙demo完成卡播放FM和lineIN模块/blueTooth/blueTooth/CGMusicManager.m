//
//  CGMusicManager.m
//  blueTooth
//
//  Created by duluyang on 15/5/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "CGMusicManager.h"
#import "BluetoothDeviceManager.h"
#import "MusicManager.h"

@interface CGMusicManager ()<MusicDelegate>

@property (nonatomic,weak) id<MusicManager> musicManger;
@property (nonatomic,weak) id<CGMusicDelegate> cgMusciDelegate;

@end

@implementation CGMusicManager



#pragma mark MusicDelegate 

-(void)managerReady:(UInt32)mode
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGmanagerReady:)]) {
        [self.cgMusciDelegate CGmanagerReady:mode];
    }
}

-(void)lyricReady:(UInt32)index lyric:(NSData*)lyric
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGlyricReady:lyric:)]) {
        [self.cgMusciDelegate CGlyricReady:index lyric:lyric];
    }
}

-(void)musicEntryChanged:(MusicEntry*) entry
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGmusicEntryChanged:)]) {
        [self.cgMusciDelegate CGmusicEntryChanged:entry];
    }
}

-(void)loopModeChanged:(UInt32) mode
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGloopModeChanged:)]) {
        [self.cgMusciDelegate CGloopModeChanged:mode];
    }
}

-(void)stateChanged:(UInt32) state
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGstateChanged:)]) {
        [self.cgMusciDelegate CGstateChanged:state];
    }
}

-(void)contentChanged
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGcontentChanged)]) {
        [self.cgMusciDelegate CGcontentChanged];
    }
}

-(void)pListEntryReady:(NSMutableArray*)entryList
{
    if ([self.cgMusciDelegate respondsToSelector:@selector(CGpListEntryReady:)]) {
        [self.cgMusciDelegate CGpListEntryReady:entryList];
    }
}


#pragma mark 成员方法
- (void)setWithCGMusciDelegate:(id<CGMusicDelegate>)delegate
{
    self.cgMusciDelegate = delegate;
    self.musicManger = [[BluetoothDeviceManager sharedInstance].bluzManager getMusicManager:self];
}


-(void)play
{
    [self.musicManger play];
}

-(void)pause
{
    [self.musicManger pause];
}

-(void)next
{
   [self.musicManger next];
}

-(void)previous
{
   [self.musicManger previous];
}

-(void)select:(UInt32)index
{
   [self.musicManger select:index];
}

-(UInt32)getCurrentPosition
{
  return [self.musicManger getCurrentPosition];
}

-(UInt32)getDuration
{
   return [self.musicManger getDuration];
}

-(void)setLoopMode:(UInt32)mode
{
    [self.musicManger setLoopMode:mode];
}

-(void)setPList:(UInt32[])pList length:(UInt32)length
{
    [self.musicManger setPList:pList length:length];
}

-(UInt32)getPListSize
{
    return [self.musicManger getPListSize];
}

-(void)getPListFrom:(UInt32)start withCount:(UInt32)count
{
   [self.musicManger getPListFrom:start withCount:count];
}

-(void)getLyric:(UInt32)index
{
   [self.musicManger getLyric:index];
}

@end
