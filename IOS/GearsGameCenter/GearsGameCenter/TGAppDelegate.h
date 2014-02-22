//
//  TGAppDelegate.h
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGBroadcastingServer.h"

@interface TGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TGBroadcastingServer *broadcasetingServer;

@end
