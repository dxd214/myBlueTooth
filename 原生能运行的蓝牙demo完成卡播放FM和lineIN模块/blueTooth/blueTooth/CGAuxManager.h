//
//  CGAuxManager.h
//  blueTooth
//
//  Created by duluyang on 15/5/22.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 *  @protocol CGAuxDelegate
 *
 *  @abstract 对象的代理需遵循 <code>CGAuxDelegate</code>协议.
 */
@protocol CGAuxDelegate <NSObject>

/*!
 *  @method CGmanagerReady:
 *
 *  @param mode   设备当前的模式
 *
 *  @abstract {@link AuxManager}对象准备就绪
 */
-(void)CGmanagerReady:(UInt32)mode;
/*!
 *  @method CGstateChanged:
 *
 *  @param state   Linein当前状态
 *
 *  @abstract Linein状态变化
 */
-(void)CGstateChanged:(UInt32)state;

@end

/*!
 *  @protocol CGAuxManager
 *
 *  @abstract Aux(Linein)管理接口，通过{@link BluetoothDeviceManager}的接口来获取。
 */
@interface CGAuxManager : NSObject

/**
 *  设置CGAuxDelegate代理方法
 *
 *  @param delegate
 */
- (void)setWithCGAuxDelegate:(id<CGAuxDelegate>)delegate;

/*!
 *  @method mute
 *
 *  @abstract 控制Linein静音状态。
 */
-(void)mute;
@end
