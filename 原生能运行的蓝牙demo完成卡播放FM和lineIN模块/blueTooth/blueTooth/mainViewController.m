//
//  mainViewController.m
//  blueTooth
//
//  Created by duluyang on 15/4/18.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "mainViewController.h"
//#import "cardPlayViewController.h"
#import "modeSViewController.h"

@interface mainViewController ()//<OADelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIButton *scanButton;
@property(nonatomic,strong)UIButton *disconnect;
@property(nonatomic,strong)UIButton *cardbutton;

@property(nonatomic,strong)CBPeripheral *periphral;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *perArray;
@end

@implementation mainViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"蓝牙";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc] init];
    _perArray  = [[NSMutableArray alloc] init];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 300)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableview];
    
    _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanButton.frame = CGRectMake(15, 70, 80, 40);
    [_scanButton setTitle:@"开始扫描" forState:UIControlStateNormal];
    [_scanButton addTarget:self action:@selector(scanbluetooth:) forControlEvents:UIControlEventTouchUpInside];
    _scanButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_scanButton];
    
    _disconnect = [UIButton buttonWithType:UIButtonTypeCustom];
    _disconnect.frame = CGRectMake(120, 70, 80, 40);
    [_disconnect setTitle:@"断开连接" forState:UIControlStateNormal];
    [_disconnect addTarget:self action:@selector(disconnectAction:) forControlEvents:UIControlEventTouchUpInside];
    _disconnect.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_disconnect];
    
    _cardbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cardbutton.frame = CGRectMake(220, 70, 80, 40);
    [_cardbutton setTitle:@"下一页" forState:UIControlStateNormal];
    [_cardbutton addTarget:self action:@selector(nextpage:) forControlEvents:UIControlEventTouchUpInside];
    _cardbutton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_cardbutton];
    
    
    
    //设置蓝牙扫描和连接代理
    [[BluetoothDeviceManager sharedInstance] setConnectDelegate:self];

#pragma mark  通知iBluz应用当前的前、后台状态 ，默认NO，globalDelegate不进行数据返回，设置
    [[BluetoothDeviceManager sharedInstance] setAppForeground:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:showUserInfoCellIdentifier];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击第%d行",indexPath.row);
    //连接蓝牙
    [[BluetoothDeviceManager sharedInstance] connect:[_perArray objectAtIndex:indexPath.row]];
    
}

#pragma mark 按钮功能
- (void)scanbluetooth:(id)sender
{
    NSLog(@"开始扫描");
//    NSInteger *bluetooth = [[BluetoothDeviceManager sharedInstance] getBluetoothState];
//    if (bluetooth) {
//        
//    }
    
    [[BluetoothDeviceManager sharedInstance] scanStart];
}
- (void)disconnectAction:(id)sender
{
    NSLog(@"断开连接");
    [[BluetoothDeviceManager sharedInstance] disconnect:_periphral];
}
- (void)nextpage:(id)sender
{
    NSLog(@"next page");
//    cardPlayViewController *viewController = [[cardPlayViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES ];
}
#pragma mark 判断数组中是否有指定的字符串
- (BOOL)arrayHasSomeString:(NSMutableArray*)array String:(NSString*)string
{
    BOOL has = NO;
    for (int i = 0; i<array.count; i++) {
        if([array[i] isEqualToString:string])
        {
            has = YES;
        }
    }
    return has;
}

-(void)SLfoundPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData
{
    NSLog(@"扫描到蓝牙设备后返回\n");
    
      NSLog(@"扫描到的蓝牙dic：%@",advertisementData);
    NSLog(@"蓝牙设备CBPeripheral:%@",peripheral);
    if (peripheral == nil||[peripheral.name isEqualToString:@""]||([peripheral.name length]<1)) {
        NSLog(@"peripheral为空 return");
        NSLog(@"--------------End:搜索到蓝牙------------------");
        return;
    }
    NSLog(@"扫描到的蓝牙dic：%@",advertisementData);
    NSLog(@"蓝牙设备CBPeripheral:%@",peripheral);
    
    if (![self arrayHasSomeString:_dataArray String:peripheral.name]) {
        [_dataArray addObject:peripheral.name];
        [_perArray addObject:peripheral];
        [[BluetoothDeviceManager sharedInstance].bluetoothConnector_deviceBeanArray addObject:peripheral];
    }
    [_tableview reloadData];

}
-(void)SLconnectedPeripheral:(CBPeripheral*) peripheral
{
    NSLog(@"蓝牙连接成功后");
    NSLog(@"连接的蓝牙名字：%@",peripheral.name);
    NSLog(@"连接的蓝牙状态：%d",peripheral.state);
    NSLog(@"蓝牙连接成功后");
    NSLog(@"连接的蓝牙名字：%@",peripheral.name);
    NSLog(@"连接的蓝牙状态：%d",peripheral.state);
    _periphral = peripheral;
    
    NSString *str = [[NSString alloc] initWithFormat:@"连接的蓝牙名字：%@",peripheral.name];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:str cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
    
    //蓝牙连接成功后 初始化bluzManager
    [[BluetoothDeviceManager sharedInstance] initBluzManager];
    // [OABlueToothManager sharedInstance].globalManager = [[OABlueToothManager sharedInstance].bluzManager getGlobalManager:self];
    
    //根据peripheral，更新:bluetoothConnector_connectedBluetoothDeviceEntry,其中的peripheral是指针
    for (int index = 0 ; index < [BluetoothDeviceManager sharedInstance].bluetoothConnector_deviceBeanArray.count; index ++)
    {
        
    }
    modeSViewController *viewController = [[modeSViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES ];
}
-(void)SLdisconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative
{
     NSLog(@"是否用户主动断开连接 连接失败或断开,请重试");
}

-(void)SLdisconnectedPeripheral:(CBPeripheral*) peripheral
{
    NSLog(@"断开蓝牙时返回已经断开的蓝牙设备信息,请重试");
    NSString *str = [[NSString alloc] initWithFormat:@"蓝牙%@已经断开连接",peripheral.name];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:str cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
    _periphral = nil;
}

@end
