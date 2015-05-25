//
//  RadioViewController.m
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "RadioViewController.h"
//#import "OABlueToothManager.h"
#import "CGRadioManager.h"
#import "BluetoothDeviceManager.h"

@interface RadioViewController ()<CGRadioDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView  *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)CGRadioManager *cgRadioManager;

@end

@implementation RadioViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
   // [OABlueToothManager sharedInstance].radioManager = [[OABlueToothManager sharedInstance].bluzManager getRadioManager:self];
    _cgRadioManager = [[BluetoothDeviceManager sharedInstance] getCGRadioManagerWithDelegate:self];
    [_cgRadioManager setWithCGMusciDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"radio";
    
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // Do any additional setup after loading the view from its nib.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count <1) {
        return 6;
    }else{
        return _dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"cellIdentify";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify forIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify];
    }
    if (_dataArray.count<1) {
        cell.detailTextLabel.text = @"无电台";
    } else {
        RadioEntry *radio = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d",radio.channel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioEntry *radio = [_dataArray objectAtIndex:indexPath.row];
    [_cgRadioManager select:radio.channel];
}

- (IBAction)setChannelAction:(id)sender {
    NSLog(@"设置电台频率");
    int channal = [_inputChannal.text intValue];
    [_cgRadioManager select:channal];
}

- (IBAction)startSearchAction:(id)sender {
    NSLog(@"开始搜台");
   [_cgRadioManager scanStart];
}

- (IBAction)stopSearchAction:(id)sender {
    NSLog(@"停止搜台");
    [_cgRadioManager scanStop];
}

- (IBAction)changeChannelAction:(id)sender {
    NSLog(@"切换收音机频段");
   // [[OABlueToothManager sharedInstance].radioManager setBand:];
}

- (IBAction)setMuteAction:(id)sender {
    NSLog(@"设置收音机静音状态");
    [_cgRadioManager switchMute];
}

- (IBAction)getChannelListAction:(id)sender {
    NSLog(@"获取电台列表");
    [_cgRadioManager getChannelList];
}

- (IBAction)getCurrentChannel:(id)sender {
    NSLog(@"获取当前频段");
  int channel = [_cgRadioManager getCurrentChannel];
    
    NSString *channelstr  = [[NSString alloc] initWithFormat:@"%d",channel];
    _showLabel.text = channelstr;
}

- (IBAction)saveChannalAction:(id)sender {
    RadioEntry *radio = [[RadioEntry alloc] init];
    radio.channel = [_showLabel.text intValue];
    [_dataArray addObject:radio];
    [_tableView reloadData];
}

#pragma mark CGRadioDelegate 

/*!
 *  @method CGmanagerReady:
 *
 *  @param mode 音箱当前的模式
 *
 *  @abstract {@link RadioManager}对象准备就绪
 *
 *  @seealso FuncMode
 */
-(void)CGmanagerReady:(UInt32)mode
{
    NSLog(@"RadioManager ready");
}
/*!
 *  @method CGradioListChanged:
 *
 *  @param channelList 电台列表
 *
 *  @abstract 音箱返回搜到得电台列表
 */
-(void)CGradioListChanged:(NSMutableArray*)channelList
{
    [_dataArray removeAllObjects];
    NSLog(@"返回搜索到的电台列表%@",channelList);
    [_dataArray addObjectsFromArray:channelList];
    [_tableView reloadData];
}
/*!
 *  @method CGradioStateChanged:
 *
 *  @param state 当前模式
 *
 *  @abstract 收音机当前模式变化
 */
-(void)CGradioStateChanged:(UInt32)state
{
    NSLog(@"收音机当前模式的变化%d",state);
}
/*!
 *  @method CGchannelChanged:
 *
 *  @param channel 当前电台频率
 *
 *  @abstract 当前电台频率变化
 *
 *  @seealso select:
 */
-(void)CGchannelChanged:(UInt32)channel
{
    NSLog(@"当前电台频率变化:%d",channel);
    NSString *channelstr  = [[NSString alloc] initWithFormat:@"%d",channel];
    _showLabel.text = channelstr;
}
/*!
 *  @method CGbandChanged:
 *
 *  @param band 当前频段
 *
 *  @abstract 收音机当前频段变化
 *
 *  @seealso setBand:
 *  @seealso RadioBand
 */
-(void)CGbandChanged:(UInt32)band
{
    NSLog(@"收音机当前频段变化:%d",band);
}


@end
