//
//  TGViewController.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGViewController.h"
#import "TGWebServer.h"

@interface TGViewController ()

@property (strong, nonatomic) TGWebServer *webServer;

@end

@implementation TGViewController

@synthesize webServer = _webServer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //start web server
    _webServer = [[TGWebServer alloc] init];
    [_webServer start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
