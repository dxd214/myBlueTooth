//
//  RadioViewController.h
//  blueTooth
//
//  Created by duluyang on 15/4/21.
//  Copyright (c) 2015年 duluyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *channelButton;
@property (weak, nonatomic) IBOutlet UIButton *startSearch;
@property (weak, nonatomic) IBOutlet UIButton *stopSearch;
@property (weak, nonatomic) IBOutlet UIButton *changeChannel;
@property (weak, nonatomic) IBOutlet UIButton *setMute;
@property (weak, nonatomic) IBOutlet UIButton *getChannelList;
@property (weak, nonatomic) IBOutlet UIButton *getCurrentChannel;
@property (weak, nonatomic) IBOutlet UIButton *saveChannal;
@property (weak, nonatomic) IBOutlet UITextField *inputChannal;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;


- (IBAction)setChannelAction:(id)sender;
- (IBAction)startSearchAction:(id)sender;
- (IBAction)stopSearchAction:(id)sender;
- (IBAction)changeChannelAction:(id)sender;
- (IBAction)setMuteAction:(id)sender;
- (IBAction)getChannelListAction:(id)sender;
- (IBAction)getCurrentChannel:(id)sender;
- (IBAction)saveChannalAction:(id)sender;


@end
