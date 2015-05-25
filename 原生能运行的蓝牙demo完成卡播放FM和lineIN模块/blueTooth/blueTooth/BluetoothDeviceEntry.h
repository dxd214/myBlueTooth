//
//  BluetoothDeviceEntry.h
//  blueTooth
//
//  Created by duluyang on 15/4/28.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBPeripheral;

@interface BluetoothDeviceEntry : NSObject

@property (copy ,nonatomic)   NSString     *name;
@property (copy ,nonatomic)   NSString     *disName;
@property (copy ,nonatomic)   NSString     *mac;
@property (assign,nonatomic)  BOOL         isPaired;    //设备是否曾经连接过
@property (assign,nonatomic)  BOOL         enable;      //设备是可以连接：搜索到则为YES，否则为NO
@property (strong,nonatomic)  CBPeripheral *peripheral; //蓝牙设备

@end
