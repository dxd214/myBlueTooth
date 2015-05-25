//
//  cardPlayViewController.m
//  blueTooth
//
//  Created by duluyang on 15/4/18.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "cardPlayViewController.h"
//#import "OABlueToothManager.h"


@interface cardPlayViewController ()<UITableViewDataSource,UITableViewDelegate,CGMusicDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIButton *scanButton;
@property(nonatomic,strong)UIButton *disconnect;
@property(nonatomic,strong)UIButton *cardbutton;
@property(nonatomic,strong)UIButton *loopButton;
@property(nonatomic,strong)UILabel *loopLabel;
@property(nonatomic,strong)UILabel *musicName;


@property(nonatomic,strong)MusicEntry *music;
@property(nonatomic,strong)NSMutableArray *musicArray;

@end

@implementation cardPlayViewController

int loop_x = 0;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    CMTabbarViewController *tab = (CMTabbarViewController *)self.tabBarController;
//    [tab setTabbarHidden:YES];
//    [_musicTableView reloadData];
   // [OABlueToothManager sharedInstance].cardMusicManager = [[OABlueToothManager sharedInstance].bluzManager getMusicManager:self];
//    CGMusicManager *cgmg = [[BluetoothDeviceManager sharedInstance] getCGMusicManagerWithDelegate:self];
//    [cgmg setCgMusciDelegate:self];
  
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     _musicManager = [[BluetoothDeviceManager sharedInstance] getCGMusicManagerWithDelegate:self];
    [_musicManager setWithCGMusciDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _musicArray = [[NSMutableArray alloc] init];
    
    self.title = @"卡播放模式";
    self.view.backgroundColor = [UIColor clearColor];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, 320, 200)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableview];
    
    
    _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanButton.frame = CGRectMake(15, 70, 80, 40);
    [_scanButton setTitle:@"上一曲" forState:UIControlStateNormal];
    [_scanButton addTarget:self action:@selector(scanbluetooth:) forControlEvents:UIControlEventTouchUpInside];
    _scanButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_scanButton];
    
    _disconnect = [UIButton buttonWithType:UIButtonTypeCustom];
    _disconnect.frame = CGRectMake(120, 70, 80, 40);
    [_disconnect setTitle:@"播放" forState:UIControlStateNormal];
    [_disconnect addTarget:self action:@selector(disconnectAction:) forControlEvents:UIControlEventTouchUpInside];
    _disconnect.backgroundColor = [UIColor greenColor];
    _disconnect.selected = YES;
    [self.view addSubview:_disconnect];
    
    _cardbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cardbutton.frame = CGRectMake(220, 70, 80, 40);
    [_cardbutton setTitle:@"下一曲" forState:UIControlStateNormal];
    [_cardbutton addTarget:self action:@selector(nextpage:) forControlEvents:UIControlEventTouchUpInside];
    _cardbutton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_cardbutton];
    
    _loopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loopButton.frame = CGRectMake(15, 115, 80, 40 );
    [_loopButton setTitle:@"循环模式" forState:UIControlStateNormal];
    [_loopButton addTarget:self action:@selector(setloopAction:) forControlEvents:UIControlEventTouchUpInside];
    _loopButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_loopButton];
    
    _loopLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 115, 80, 40)];
    _loopLabel.text = @"暂无设置";
    _loopLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_loopLabel];
    
    _musicName = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 200, 40)];
    _musicName.text = @"无歌曲";
    _musicName.backgroundColor = [UIColor greenColor];
    [_musicName setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_musicName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_musicArray.count>0) {
        return _musicArray.count;
    } else {
        return 6;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    if (_musicArray.count>0) {
        MusicEntry *music = [_musicArray objectAtIndex:indexPath.row];
        cell.textLabel.text = music.name;
        cell.detailTextLabel.text = music.artist;
    } else {
         cell.textLabel.text = @"无歌曲";
    }
   
    return cell;
}




#pragma mark 按钮功能
- (void)scanbluetooth:(id)sender
{
    NSLog(@"上一曲");
    [_musicManager previous];
}
- (void)disconnectAction:(id)sender
{
   
    if (_disconnect.isSelected == YES) {
         NSLog(@"已暂停");
        [_musicManager pause];
        _disconnect.selected = NO;
        [_disconnect setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        NSLog(@"已播放");
        [_musicManager play];
        [_disconnect setTitle:@"暂停" forState:UIControlStateNormal];
        _disconnect.selected = YES;
    }
    
    
}
- (void)nextpage:(id)sender
{
    NSLog(@"下一曲");
    [_musicManager next];
}
/*
typedef enum {
    LOOP_MODE_UNKNOWN   = -1,
    LOOP_MODE_ALL       = 0,
    LOOP_MODE_SINGLE    = 1,
    LOOP_MODE_SHUFFLE   = 3
}LoopMode;
 
*/
- (void)setloopAction:(id)sender
{
    NSLog(@"设置循环模式");
    loop_x = (loop_x +1)%4;
    switch (loop_x) {
        case 0:
            [_musicManager setLoopMode:LOOP_MODE_UNKNOWN];
            break;
        case 1:
            [_musicManager setLoopMode:LOOP_MODE_ALL];
            break;
        case 2:
            [_musicManager setLoopMode:LOOP_MODE_SINGLE];
            break;
        case 3:
            [_musicManager setLoopMode:LOOP_MODE_SHUFFLE];
            break;
            
        default:
            break;
    }
}




#pragma mark MusicDelegate  音箱 卡播放模式的代理方法

/*!
 *  @method managerReady:
 *
 *  @param mode 音箱当前的模式
 *
 *  @abstract {@link MusicManager}对象准备就绪
 *
 *  @seealso FuncMode
 */
-(void)CGmanagerReady:(UInt32)mode
{
    NSLog(@"MusicManager 对象准备就绪");
    
    [_musicManager getPListFrom:1 withCount:10];
}
/*!
 *  @method lyricReady:lyric:
 *
 *  @param lyric 歌曲数据
 *
 *  @abstract 音箱返回指定歌曲的歌词信息
 *
 *  @seealso getLyric:
 */
-(void)CGlyricReady:(UInt32)index lyric:(NSData*)lyric
{
    NSLog(@"音箱返回指定歌曲的歌词信息");
}
/*!
 *  @method musicEntryChanged:
 *
 *  @param entry 当前播放的音乐条目
 *
 *  @abstract 音箱播放音乐条目切换
 */
-(void)CGmusicEntryChanged:(MusicEntry*) entry
{
    NSLog(@"音箱播放音乐条目切换");
    NSLog(@"当前播放音乐名字：%@",entry.name);
    _musicName.text = entry.name;
}
/*!
 *  @method loopModeChanged:
 *
 *  @param mode 当前循环播放
 *
 *  @abstract 音箱当前循环模式变化
 *
 *  @seealso LoopMode
 */
-(void)CGloopModeChanged:(UInt32) mode
{
    NSLog(@"音箱当前循环模式变化");
    switch (mode) {
        case LOOP_MODE_UNKNOWN:
            _loopLabel.text =@"未知模式";
            break;
        case LOOP_MODE_ALL:
             _loopLabel.text =@"顺序播放";
            break;

        case LOOP_MODE_SINGLE:
             _loopLabel.text =@"单曲循环";
            break;

        case LOOP_MODE_SHUFFLE:
             _loopLabel.text =@"随机模式";
            break;
        default:
            break;
    }
}

/*!
 *  @method stateChanged:
 *
 *  @param state 当前播放状态
 *
 *  @abstract 音箱播放状态变化
 *
 *  @seealso PlayStatus
 */
-(void)CGstateChanged:(UInt32) state
{
    NSLog(@"音箱播放状态变化");
}
/*!
 *  @method contentChanged
 *
 *  @abstract 音箱播放列表变化，应用需重新同步播放列表。
 */
-(void)CGcontentChanged
{
    NSLog(@"音箱播放列表变化，应用需重新同步播放列表。");
}
/*!
 *  @method pListEntryReady:
 *
 *  @param entryList 播放列表
 *
 *  @abstract 音箱发送播放列表。
 *
 *  @seealso getPListFrom:withCount:
 */
-(void)CGpListEntryReady:(NSMutableArray*)entryList
{
    NSLog(@"获取的歌曲列表:%@",entryList);
    [_musicArray addObjectsFromArray:entryList];
    [_tableview reloadData];
    
}



@end
