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

@interface TGMainViewController ()

@end

@implementation TGMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)mazeStartTapped:(id)sender {
//    TGViewController *viewController = [[TGViewController alloc] init];
//    viewController.gameName = @"Maze";
    
    TGAppDelegate *delegate = (TGAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.broadcasetingServer start];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"Maze";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)pongStartTapped:(id)sender {
    
    TGAppDelegate *delegate = (TGAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.broadcasetingServer start];
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TGViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TGViewController"];
    vc.gameName = @"Pong";
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
