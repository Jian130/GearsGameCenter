//
//  TGBroadcastingServer.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGCommunicationServer.h"
#import "BLWebSocketsServer.h"
#import "GCDSingleton.h"
#import "JSONKit.h"

@interface TGCommunicationServer()

@property (strong, nonatomic) NSMutableDictionary *clients;
@property (strong, nonatomic) NSString *mazeID;
@end

@implementation TGCommunicationServer

@synthesize clients = _clients;
@synthesize mazeID = _mazeID;

#pragma mark - shared instance

+ (id)sharedManager {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (NSMutableDictionary *)clients {
	if (!_clients) {
        _clients = [[NSMutableDictionary alloc] init];
    }
    
    return _clients;
}

- (void)startCommunicationServer {
    
	[[BLWebSocketsServer sharedInstance] startListeningOnPort:81 withProtocolName:NULL andCompletionBlock:^(NSError *error) {
        if (!error) {
            NSLog(@"Server started");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    
    self.mazeID = [NSString stringWithFormat:@"%d", (arc4random() % 100)];
    
    [[BLWebSocketsServer sharedInstance] setHandleRequestBlock:^NSData *(NSData *requestData, NSString *sessionID) {
        NSLog(@"request recived: %@", [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding]);
       
//    	NSString *mesg = [NSString stringWithFormat:@"message from server  %i", self.seq];
//        NSMutableData *data = [NSMutableData dataWithData:[mesg dataUsingEncoding:NSUTF8StringEncoding]];
//        [data appendData:requestData];
//        [[BLWebSocketsServer sharedInstance] pushToAll:data];
        
//        self.seq ++;
        
        NSString *msg = [JSONDecoder  o]
        BOOL newUser = YES;
        if (![self.clients objectForKey:sessionID]) {
            [self.clients setObject:[NSNumber numberWithBool:newUser] forKey:sessionID];
        } else {
        	newUser = NO;
        }
        
		NSData *response = NULL;
        if (newUser) {
            response = [[NSString stringWithFormat:@"{\"user_id\":\"%@\", \"maze_id\":\"%@\"}", sessionID, self.mazeID] dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        [[BLWebSocketsServer sharedInstance] pushToAll:requestData];
        
        return response;
    }];
}

- (void)stopCommunicationServer {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
    }];
}

@end
