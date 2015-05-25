//
//  CGAuxManager.m
//  blueTooth
//
//  Created by duluyang on 15/5/22.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "CGAuxManager.h"
#import "AuxManager.h"
#import "BluetoothDeviceManager.h"

@interface CGAuxManager ()<AuxDelegate>

@property (nonatomic,weak) id<AuxManager> auxManager;
@property (nonatomic,weak) id<CGAuxDelegate> cgAuxdelegate;

@end

@implementation CGAuxManager

- (void)setWithCGAuxDelegate:(id<CGAuxDelegate>)delegate
{
    self.cgAuxdelegate = delegate;
    self.auxManager = [[BluetoothDeviceManager sharedInstance].bluzManager getAuxManager:self];
}

#pragma AuxDelegate
-(void)managerReady:(UInt32)mode
{
    if ([self.cgAuxdelegate respondsToSelector:@selector(CGmanagerReady:)]) {
        [self.cgAuxdelegate CGmanagerReady:mode];
    }
}

-(void)stateChanged:(UInt32)state
{
    if ([self.cgAuxdelegate respondsToSelector:@selector(CGstateChanged:)]) {
        [self.cgAuxdelegate CGstateChanged:state];
    }
}

#pragma mark 成员方法
-(void)mute
{
    [_auxManager mute];
}
@end
