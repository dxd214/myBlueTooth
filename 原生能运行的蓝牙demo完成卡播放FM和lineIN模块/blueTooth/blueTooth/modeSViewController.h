//
//  modeSViewController.h
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OABlueToothManager.h"

@interface modeSViewController : UIViewController<GlobalDelegate,GlobalManager>

@property (weak, nonatomic) IBOutlet UIButton *musicButton;
@property (weak, nonatomic) IBOutlet UIButton *lineIn;
@property (weak, nonatomic) IBOutlet UIButton *radio;
@property (weak, nonatomic) IBOutlet UIButton *auxButton;
@property (weak, nonatomic) IBOutlet UIButton *alarm;
- (IBAction)musicAction:(id)sender;
- (IBAction)lineInAction:(id)sender;
- (IBAction)ratioAction:(id)sender;
- (IBAction)auxAction:(id)sender;
- (IBAction)alarmAction:(id)sender;



@end
