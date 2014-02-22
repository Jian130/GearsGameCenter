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

- (void)start {
	[[BLWebSocketsServer sharedInstance] startListeningOnPort:81 withProtocolName:NULL andCompletionBlock:^(NSError *error) {
        if (!error) {
            NSLog(@"Server started");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    
    
    [[BLWebSocketsServer sharedInstance] setHandleRequestBlock:^NSData *(NSData *requestData) {
        NSLog(@"request recived: %@", [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding]);
        
        return requestData;
    }];
}

- (void)stop {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
    }];
}

@end
