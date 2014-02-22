//
//  TGBroadcastingServer.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGBroadcastingServer.h"
#import "BLWebSocketsServer.h"

@interface TGBroadcastingServer()

@end

@implementation TGBroadcastingServer

//- (id)init {
//	self = [super init];
//    if (self) {
//    	[self initBroadcastingServer];
//    }
//    
//    return self;
//}

- (void)start {
	[[BLWebSocketsServer sharedInstance] startListeningOnPort:8080 withProtocolName:@"TCP" andCompletionBlock:^(NSError *error) {
        if (!error) {
            NSLog(@"Server started");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)stop {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
    }];
}

@end
