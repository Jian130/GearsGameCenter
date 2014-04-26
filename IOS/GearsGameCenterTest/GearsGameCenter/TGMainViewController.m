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

@interface TGMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ipAddress;
@property (weak, nonatomic) IBOutlet UITextView *textInfoBox;

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
//    self.edgesForExtendedLayout=UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars=NO;
//    self.automaticallyAdjustsScrollViewInsets=NO;
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

