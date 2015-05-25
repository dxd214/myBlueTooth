//
//  mainViewController.h
//  blueTooth
//
//  Created by duluyang on 15/4/18.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothDeviceManager.h"


@interface mainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SLBlueDeviceDelegate>

@end
