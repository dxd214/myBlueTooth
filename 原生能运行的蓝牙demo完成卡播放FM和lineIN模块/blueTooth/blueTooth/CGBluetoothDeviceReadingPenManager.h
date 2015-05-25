//
//  CGBluetoothDeviceReadingPenManager.h
//  blueTooth
//
//  Created by duluyang on 15/5/19.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLBluetoothDeviceReadingPenDelegate <NSObject>

@required
/**
 *  SLBluetoothDeviceReadingPenDelegate 代理方法 获取点读笔的码值
 *
 *  @param value 返回的码值
 */
- (void)SLvalueOfBook:(int)value;

@end


@interface CGBluetoothDeviceReadingPenManager : NSObject

@end
