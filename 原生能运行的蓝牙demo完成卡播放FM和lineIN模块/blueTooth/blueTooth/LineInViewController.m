//
//  LineInViewController.m
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import "LineInViewController.h"
//#import "OABlueToothManager.h"
#import "BluetoothDeviceManager.h"
#import "CGAuxManager.h"



@interface LineInViewController ()<CGAuxDelegate>

@property(nonatomic,strong)CGAuxManager *cgAuxmanager;

@end

@implementation LineInViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    CMTabbarViewController *tab = (CMTabbarViewController *)self.tabBarController;
    //    [tab setTabbarHidden:YES];
    //    [_musicTableView reloadData];
   // [OABlueToothManager sharedInstance].AuxManager = [[OABlueToothManager sharedInstance].bluzManager getAuxManager:self];
    _cgAuxmanager = [[BluetoothDeviceManager sharedInstance] getCGAuxManagerWithDelegate:self];
    [_cgAuxmanager setWithCGAuxDelegate:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LineIn";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)lineInActioon:(id)sender {
    NSLog(@"控制Linein静音状态");
    [_cgAuxmanager mute];
}

#pragma mark CGAuxDelegate 代理方法

-(void)CGmanagerReady:(UInt32)mode
{
    NSLog(@"AuxManager Ready");
}

-(void)CGstateChanged:(UInt32)state
{
    NSLog(@"stateChanged");
}

@end
