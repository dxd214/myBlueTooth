//
//  BluetoothDeviceEntry.m
//  blueTooth
//
//  Created by duluyang on 15/4/28.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "BluetoothDeviceEntry.h"

@implementation BluetoothDeviceEntry

-(NSString *)description{
    if(self.isPaired){
        return [NSString stringWithFormat:@"BluetoothDeviceEntry: have paired,name=%@,disName=%@,mac=%@,peripheral=%@",self.name,self.disName,self.mac,self.peripheral];
    }else{
        return [NSString stringWithFormat:@"BluetoothDeviceEntry: not paired,name=%@,disName=%@,mac=%@,peripheral=%@",self.name,self.disName,self.mac,self.peripheral];
    }
}

@end
