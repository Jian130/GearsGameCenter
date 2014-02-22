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

@property (nonatomic) int seq;

@end

@implementation TGBroadcastingServer

@synthesize seq = _seq;

- (void)start {
    
	[[BLWebSocketsServer sharedInstance] startListeningOnPort:81 withProtocolName:NULL andCompletionBlock:^(NSError *error) {
        if (!error) {
            NSLog(@"Server started");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    
    self.seq = 0;
    
    [[BLWebSocketsServer sharedInstance] setHandleRequestBlock:^NSData *(NSData *requestData) {
        NSLog(@"request recived: %@", [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding]);
       
    	NSString *mesg = [NSString stringWithFormat:@"message from server  %i", self.seq];
        NSData *data = [mesg dataUsingEncoding:NSUTF8StringEncoding];
        [[BLWebSocketsServer sharedInstance] pushToAll:data];
        
        self.seq ++;
        return NULL;
    }];
}

- (void)stop {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
    }];
}

@end
