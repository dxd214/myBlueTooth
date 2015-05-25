//
//  OABluetoothDeviceEntry.m
//  blueTooth
//
//  Created by duluyang on 15/4/18.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "OABluetoothDeviceEntry.h"

@implementation OABluetoothDeviceEntry

-(NSString *)description{
    if(self.isPaired){
        return [NSString stringWithFormat:@"LMBluetoothDeviceEntry: have paired,name=%@,disName=%@,mac=%@,peripheral=%@",self.name,self.disName,self.mac,self.peripheral];
    }else{
        return [NSString stringWithFormat:@"LMBluetoothDeviceEntry: not paired,name=%@,disName=%@,mac=%@,peripheral=%@",self.name,self.disName,self.mac,self.peripheral];
    }
}

@end
