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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_480_320.png"]];
    self.textInfoBox.backgroundColor = [UIColor clearColor];
    
    self.hidesBottomBarWhenPushed = YES;
}

- (IBAction)mazeStartTapped:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"maze";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)whoisStartTapped:(id)sender {

//    TGViewController *vc = [[TGViewController alloc] init];
//    vc.gameName = @"WhoIs";
//    [self.navigationController pushViewController:vc animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"whois";
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
