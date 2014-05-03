//
//  TGMainViewController.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGMainViewController.h"
#import "TGViewController.h"
#import "TGAppDelegate.h"
#import "TGWebServer.h"
#import "util.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface TGMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ipAddress;
@property (weak, nonatomic) IBOutlet UITextView *textInfoBox;
@property (weak, nonatomic) IBOutlet UILabel *wifiLabel;
@property (nonatomic) BOOL isWifiConnected;

@end

@implementation TGMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ipAddress.text = [Util getIPAddress];
    [self.navigationController setNavigationBarHidden:YES];
    self.gameCell.backgroundColor = [UIColor colorWithRed:157.0/255 green:141.0/255 blue:70.0/255 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.textInfoBox.backgroundColor = [UIColor clearColor];
    
    if(&UIApplicationWillEnterForegroundNotification) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(enteredForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
}

- (void)enteredForeground:(NSNotification*) not
{
    [self updateWiFiLabel];
}

- (void)viewDidAppear:(BOOL)animated {
    //update 1. wifi label
    [self updateWiFiLabel];
}

- (void)updateWiFiLabel {
    CFArrayRef interfaceArray = CNCopySupportedInterfaces();
    CFDictionaryRef interfaceDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(interfaceArray, 0));
    
    @try {
        if (interfaceDict) {
            NSString *networkName = CFDictionaryGetValue(interfaceDict, kCNNetworkInfoKeySSID);
            
            self.wifiLabel.text = [[[@"Ask you friend to join the same Wi-Fi network " stringByAppendingString:@": ( "] stringByAppendingString:networkName] stringByAppendingString:@" )"];
            self.wifiLabel.textColor = [UIColor colorWithRed:157.0f/255.0f green:141.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
            self.isWifiConnected = YES;
        } else {
            self.wifiLabel.text = @"Please connect to a Wi-Fi netweok.";
            self.wifiLabel.textColor = [UIColor redColor];
            self.isWifiConnected = NO;
        }
    }
    @catch (NSException *exception) {
        self.wifiLabel.text = @"Please connect to a Wi-Fi netweok.";
        self.wifiLabel.textColor = [UIColor redColor];
        self.isWifiConnected = NO;
    }
}

- (void)startMazeGame {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"maze";
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)startWhoISGame {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"whois/";
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self startWhoISGame];
    }
}

@end

