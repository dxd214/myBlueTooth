//
//  modeSViewController.m
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "modeSViewController.h"

#import "cardPlayViewController.h"
#import "RadioViewController.h"
#import "AuxViewController.h"
#import "AlarmViewController.h"
#import "LineInViewController.h"
#import "RadioViewController.h"
#import "BluetoothDeviceManager.h"

@interface modeSViewController ()<SLGlobalDelegate>

@end

@implementation modeSViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    if ([BluetoothDeviceManager sharedInstance].bluzManager != nil) {
        NSLog(@"%@--->监听GlobalManager",self.class);
        
        [[BluetoothDeviceManager sharedInstance] initGlobalManagerWithDelegate:self];
         [BluetoothDeviceManager sharedInstance].slBluetoothDeviceReadingPenDelegate = self;
    }
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蓝牙各种模式";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)musicAction:(id)sender {
    NSLog(@"set Music mode");
    [[BluetoothDeviceManager sharedInstance] setMode:MODE_CARD];
//    [[OABlueToothManager sharedInstance].globalManager setMode:MODE_CARD];
}

- (IBAction)ratioAction:(id)sender {
    NSLog(@"radio mode");
   // [[OABlueToothManager sharedInstance].globalManager setMode:MODE_RADIO];
    [[BluetoothDeviceManager sharedInstance] setMode:MODE_RADIO];
}

- (IBAction)auxAction:(id)sender {
    NSLog(@"Aux mode MODE_A2DP");
   // [[OABlueToothManager sharedInstance].globalManager setMode:MODE_A2DP];
   
}

- (IBAction)alarmAction:(id)sender {
    NSLog(@"alarm mode");
   //  [[OABlueToothManager sharedInstance].globalManager setMode:MODE_ALARM];
    [[BluetoothDeviceManager sharedInstance] setMode:MODE_ALARM];
}

- (IBAction)lineInAction:(id)sender {
    NSLog(@"Line mode 音频输入播放");
//[[OABlueToothManager sharedInstance].globalManager setMode:MODE_LINEIN];
    [[BluetoothDeviceManager sharedInstance] setMode:MODE_LINEIN];
}


-(void)SLmanagerReady
{
    NSLog(@"GlobalManager 对象准备就绪");
}
/*!
 *  @method soundEffectChanged:
 *
 *  @param mode 音效模式
 *
 *  @abstract 音箱音效模式变化
 *
 *  @seealso SoundEffect
 */
-(void)SLsoundEffectChanged:(UInt32)mode
{
    NSLog(@"音箱音效模式变化:%d",mode);
}
/*!
 *  @method eqModeChanged:
 *
 *  @param mode EQ模式
 *
 *  @abstract EQ模式变化
 *
 *  @seealso EQMode
 */
-(void)SLeqModeChanged:(UInt32)mode
{
    NSLog(@"EQ模式变化%D",mode);
}
/*!
 *  @method daeModeChangedWithVBASS:andTreble:
 *
 *  @param vbassEnable 虚拟低音音效使能状态
 *  @param trebleEnable 高音增强音效使能状态
 *
 *  @abstract DAE音效模式变化
 */
-(void)SLdaeModeChangedWithVBASS:(BOOL)vbassEnable andTreble:(BOOL)trebleEnable
{
    NSLog(@"DAE音效模式变化");
}
/*!
 *  @method batteryChanged:charging:
 *
 *  @param battery 电池电量状态
 *  @param charging 充放电状态
 *
 *  @abstract 音箱电池电量或充放电状态变化
 */
-(void)SLbatteryChanged:(UInt32)battery charging:(BOOL)charging
{
    NSLog(@"音箱电池电量或充放电状态变化。battery:%d",battery);
}
/*!
 *  @method volumeChanged:max:min:isMute:
 *
 *  @param current 当前音量
 *  @param max 支持的最大音量
 *  @param min 支持的最小音箱
 *  @param mute 静音状态
 *
 *  @abstract 音箱静音及音量状态变化
 */
-(void)SLvolumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute
{
    NSLog(@"音箱静音及音量状态变化:%D",current);
}
/*!
 *  @method modeChanged:
 *
 *  @param mode 功能模式
 *
 *  @abstract 音箱功能模式变化
 *
 *  @seealso FuncMode
 */
-(void)SLmodeChanged:(UInt32)mode
{
    NSLog(@"音箱功能模式变化%d",mode);
    switch (mode) {
        case MODE_CARD:
        {
            NSLog(@"卡播放模式");
            cardPlayViewController *viewController = [[cardPlayViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES ];
            break;
        }
        case MODE_LINEIN:
        {
            NSLog(@"音箱模式变为LineIn");
            LineInViewController *viewController = [[LineInViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case MODE_RADIO:
        {
            NSLog(@"FM模式");
            RadioViewController *viewController = [[RadioViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case MODE_A2DP:
        {
            NSLog(@"A2DP 模式");
            break;
        }
        case MODE_ALARM:
        {
            NSLog(@"ALARM模式");
            AlarmViewController *viewController = [[AlarmViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
            
        default:
            NSLog(@"error 无效模式");
            break;
    }

}
/*!
 *  @method hotplugCardChanged:
 *
 *  @param visibility 卡状态
 *
 *  @abstract 音箱外置卡插拔状态变化
 */
-(void)SLhotplugCardChanged:(BOOL)visibility
{
    NSLog(@"音箱卡拔状态变化：%d",visibility);
}
/*!
 *  @method hotplugUhostChanged:
 *
 *  @param visibility U盘状态
 *
 *  @abstract 音箱外置U盘插拔状态变化
 */
-(void)SLhotplugUhostChanged:(BOOL)visibility
{
    NSLog(@"音箱外置U盘插拔状态变化:%d",visibility);
}
/*!
 *  @method lineinChanged:
 *
 *  @param visibility linein线状态
 *
 *  @abstract 音箱Linein连接线插拔状态变化
 */
-(void)SLlineinChanged:(BOOL)visibility
{
    NSLog(@"音箱Linein连接线插拔状态变化:%d",visibility);
}
/*!
 *  @method dialogMessageArrived:messageID:
 *
 *  @param type 对话框类型
 *  @param messageId 对话框信息序号
 *
 *  @abstract 显示音箱对话框
 *
 *  @seealso DialogType
 */
-(void)SLdialogMessageArrived:(UInt32)type messageID:(UInt32)messageId
{
    NSLog(@"显示音箱对话框:%d",type);
}
/*!
 *  @method toastMessageArrived:
 *
 *  @param messageId 提示信息序号
 *
 *  @abstract 显示音箱提示信息
 *
 *  @seealso
 */
-(void)SLtoastMessageArrived:(UInt32)messageId
{
    NSLog(@"显示音箱提示信息%d",messageId);
}
/*!
 *  @method dialogCancel
 *
 *  @abstract 取消音箱提示信息
 */
-(void)SLdialogCancel
{
    NSLog(@"取消音箱提示信息");
}
/*!
 *  @method customCommandArrived:param1:param2:others:
 *
 *  @param cmdKey 自定义命令
 *  @param arg1 命令参数一
 *  @param arg2 命令参数二
 *  @param data 其他命令数据
 *
 *  @abstract 自定义命令回调
 *
 *  @seealso buildKey:cmdID:
 *
 *  @discussion 示例代码:
 *
 *      -(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data {
 *
 *      if (cmdKey == [appDele.globalManager buildKey:ANS cmdID:0x80]) {
 *
 *          //收到自定义命令回调，处理返回信息
 *
 *      }
 */
-(void)SLcustomCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data
{
    NSLog(@"自定义命令回调");
}

#pragma mark delegate
- (void)SLvalueOfBook:(int)value
{
    NSLog(@"value of book %D",value);
    UIAlertView *arert = [[UIAlertView alloc] initWithTitle:@"title" message:[NSString stringWithFormat:@"value of book:%d",value]  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [arert show];
}

@end
