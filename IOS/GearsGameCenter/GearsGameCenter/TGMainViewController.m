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

@end

@implementation TGMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ipAddress.text = [Util getIPAddress];
}

- (IBAction)mazeStartTapped:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"Maze";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)pongStartTapped:(id)sender {

//    TGViewController *vc = [[TGViewController alloc] init];
//    vc.gameName = @"WhoIs";
//    [self.navigationController pushViewController:vc animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"WhoIs";
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mazeStartButton:(id)sender {
}

- (IBAction)pongStartButton:(id)sender {
}
@end
