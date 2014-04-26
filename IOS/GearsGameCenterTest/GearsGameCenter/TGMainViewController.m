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
@property (nonatomic) BOOL isServerOn;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation TGMainViewController

@synthesize isServerOn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ipAddress.text = [Util getIPAddress];
    [self.navigationController setNavigationBarHidden:YES];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    if (self.isServerOn) {
        self.isServerOn = NO;
        [[TGWebServer sharedManager] stopWebServer];
        [[TGCommunicationServer sharedManager] stopCommunicationServer];
        self.startButton.backgroundColor = [UIColor colorWithRed:0.0f green:1.0f blue:178.0/255.0f alpha:1.0f];
        self.startButton.tintColor = [UIColor colorWithRed:0.0f green:122.0/255.0f blue:1.0f alpha:1.0f];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    } else {
        self.isServerOn = YES;
        [[TGWebServer sharedManager] startWebServer];
        [[TGCommunicationServer sharedManager] startCommunicationServer];
        self.startButton.backgroundColor = [UIColor redColor];
        self.startButton.tintColor = [UIColor whiteColor];
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
}



@end

