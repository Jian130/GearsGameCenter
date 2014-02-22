//
//  TGAppDelegate.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGAppDelegate.h"
#import "Util.h"

@implementation TGAppDelegate

@synthesize ipAddress = _ipAddress;
@synthesize webServer = _webServer;
@synthesize broadcasetingServer = _broadcasetingServer;

- (TGWebServer *)webServer {
	if (!_webServer) {
        _webServer = [[TGWebServer alloc] init];
    }
    
    return _webServer;
}

- (TGBroadcastingServer *)broadcasetingServer {
	if (!_broadcasetingServer) {
        _broadcasetingServer = [[TGBroadcastingServer alloc] init];
    }
    
    return _broadcasetingServer;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.ipAddress = [Util getlocalIPAddress];
    
    [self.webServer start];
    [self.broadcasetingServer start];
    
    NSLog(@"server ip address: %@", self.ipAddress);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self.broadcasetingServer stop];
}


@end
