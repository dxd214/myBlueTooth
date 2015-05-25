//
//  AlarmViewController.m
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "AlarmViewController.h"
//#import "OABlueToothManager.h"
#import "AlarmTableViewCell.h"
#import "BluetoothDeviceManager.h"


@interface AlarmViewController ()<CGAlarmDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView  *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)CGAlarmManager *cgalarmManager;

@end

@implementation AlarmViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   // [OABlueToothManager sharedInstance].alarmManager = [[OABlueToothManager sharedInstance].bluzManager getAlarmManager:self];
    _cgalarmManager = [[BluetoothDeviceManager sharedInstance] getCGAlarmManagerWithDelegate:self];
    [_cgalarmManager setWithCGAlarmDelegate:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"alarm";
    
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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

- (IBAction)setAction:(id)sender {
   
     //获取当前时间
        NSDate *now = [NSDate date];
        NSLog(@"now date is: %@", now);
    
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
        int year = [dateComponent year];
        int month = [dateComponent month];
        int day = [dateComponent day];
        int hour = [dateComponent hour];
        int minute = [dateComponent minute];
        int second = [dateComponent second];
    
        NSLog(@"year is: %d", year);
        NSLog(@"month is: %d", month);
        NSLog(@"day is: %d", day);
        NSLog(@"hour is: %d", hour);
        NSLog(@"minute is: %d", minute);
        NSLog(@"second is: %d", second);
    
    NSLog(@"设置闹钟");
    AlarmEntry *alarm = [[AlarmEntry alloc] init];
    alarm.state = YES;
    alarm.index = 1;
    alarm.hour = hour;
    alarm.minute = minute+1;
    alarm.second = second ;
    Byte byteDay = 0x01;
    alarm.repeat = byteDay;
    alarm.ringType = INTERNAL;
    [_dataArray addObject:alarm];
    [_cgalarmManager setAlarm:alarm];
    [_tableView reloadData];
}

- (IBAction)removeTheAlarm:(id)sender {
     NSLog(@"移除所有闹钟");
     [_cgalarmManager removeAll];
}

- (IBAction)getAlarmList:(id)sender {
    NSLog(@"获取闹钟列表");
    [_cgalarmManager getAlarmList];
}

- (IBAction)zoomAction:(id)sender {
    NSLog(@"贪睡5分钟");
    [_cgalarmManager snooze];
}

- (IBAction)closeCurrentAlarm:(id)sender {
    NSLog(@"关闭当前闹铃");
    [_cgalarmManager off];
}

- (IBAction)getRingList:(id)sender {
     NSLog(@"获取闹钟铃声列表");
     [_cgalarmManager getRingList];
}

- (IBAction)getForld:(id)sender {
     NSLog(@"获取闹钟目录列表");
     [_cgalarmManager getRingFolderList];
}

- (IBAction)setRepleat:(id)sender {
    UIButton *button = (UIButton *)sender;
    int nNum=0;
    Byte byteDay=0x00;
    
    switch (button.tag) {
        case 100:
        {
            nNum++;
            byteDay |= 0x01;
            break;
        }
        case 101:
        {
            nNum++;
            byteDay |= 0x02;
            break;
        }
        case 102:
        {
            nNum++;
            byteDay |= 0x04;
            break;
        }
        case 103:
        {
            nNum++;
            byteDay |= 0x08;
            break;
        }
        case 104:
        {
            nNum++;
            byteDay |= 0x10;
            break;
        }
        case 105:
        {
            nNum++;
            byteDay |= 0x20;
            break;
        }
        case 106:
        {
            nNum++;
            byteDay |= 0x40;
            break;
        }
        default:
            break;
    }
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
        cell.detailTextLabel.text = @"无闹钟";
    } else {
        AlarmEntry *alarm = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"闹钟为：%d:%d:%d",alarm.hour,alarm.minute,alarm.second];
    }
    return cell;
}



#pragma mark Alarm Delegate
/*!
 *  @method managerReady:
 *
 *  @param mode 设备当前的模式
 *
 *  @abstract {@link AlarmManager}对象准备就绪
 *
 *  @seealso  FuncMode
 */
-(void)CGmanagerReady:(UInt32)mode
{
    NSLog(@"AlarmManager对象准备就绪,mode:%d",mode);
}
/*!
 *  @method alarmStateChanged:
 *
 *  @param state 闹铃当前状态
 *
 *  @abstract 闹铃状态变化
 */
- (void)CGalarmStateChanged:(UInt32)state
{
    NSLog(@"闹铃状态变化:%d",state);
}
/*!
 *  @method alarmListArrived:
 *
 *  @param alarmList 音箱闹钟条目列表
 *
 *  @abstract 获取到闹钟条目{@link AlarmEntry}列表对象
 *
 *  @seealso getAlarmList
 */
-(void)CGalarmListArrived:(NSMutableArray*)alarmList
{
    NSLog(@"音箱闹钟条目列表%@",alarmList);
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:alarmList];
    [_tableView reloadData];
}
/*!
 *  @method ringListArrived:
 *
 *  @param ringList 闹钟铃声条目列表
 *
 *  @abstract 获取到铃声条目{@link RingEntry}列表对象
 *
 *  @seealso getRingList
 */
-(void)CGringListArrived:(NSMutableArray*)ringList
{
    NSLog(@"闹钟铃声条目列表%@",ringList);
    for (RingEntry *ring in ringList) {
        NSLog(@"source :%d",ring.source);
        NSLog(@"index:%d",ring.index);
        NSLog(@"name:%@",ring.name);
    }
}
/*!
 *  @method folderListArrived:
 *
 *  @param folderList 闹钟铃声目录列表
 *
 *  @abstract 获取到铃声目录{@link FolderEntry}列表对象
 *
 *  @seealso getRingFolderList
 */
-(void)CGfolderListArrived:(NSMutableArray*)folderList
{
    NSLog(@"闹钟铃声目录列表%@",folderList);
    for (FolderEntry *thefolder in folderList) {
        NSLog(@"目录类型：%d",thefolder.value);
        NSLog(@"应用模式参数：%d",thefolder.modeComand);
        NSLog(@"目录名称：%@",thefolder.name);
    }
}

@end
