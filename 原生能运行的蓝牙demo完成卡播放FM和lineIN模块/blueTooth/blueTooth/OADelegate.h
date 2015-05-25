//
//  LMBluetoothDelegate.h
//  bluetooth_lib
//
//  Created by liuming on 14-12-3.
//  Copyright (c) 2014年 liuming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzDevice.h"
#import "BluzManager.h"

@protocol LMBluetoothDelegate <ConnectDelegate,GlobalDelegate,MusicDelegate,RadioDelegate,AlarmDelegate,AuxDelegate>

@end
