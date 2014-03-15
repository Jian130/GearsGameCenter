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
#import "TGMessage.h"

NSString* const ACTION_SHARED_MESSAGE = @"shared_message";

@interface TGCommunicationServer()

@property (strong, nonatomic) NSMutableDictionary *clients;
@property (nonatomic, strong) NSMutableDictionary *sharedMessages;
@property (nonatomic, strong) NSMutableArray *messageQueue;

@end

@implementation TGCommunicationServer

@synthesize clients = _clients;
@synthesize sharedMessages = _sharedMessages;
@synthesize messageQueue = _messageQueue;

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

- (NSMutableDictionary *)sharedMessages {
	if (!_sharedMessages) {
        _sharedMessages = [[NSMutableDictionary alloc] init];
    }
    
    return _sharedMessages;
}

- (NSMutableArray *)messageQueue {
	if (!_messageQueue) {
        _messageQueue = [[NSMutableArray alloc] init];
    }
    
    return _messageQueue;
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
    
    [[BLWebSocketsServer sharedInstance] setHandleRequestBlock:^NSData *(NSData *requestData, NSString *sessionID) {

        
        BOOL newUser = YES;
        if (![self.clients objectForKey:sessionID]) {
            [self.clients setObject:[NSNumber numberWithBool:newUser] forKey:sessionID];
        } else {
        	newUser = NO;
        }
        
		TGMessage* newMessage = [TGMessage messageFromJsonData:requestData];
        newMessage = [self messageHandler:newMessage];
        return [TGMessage jsonDataFromMessage:newMessage];
    }];
}

- (TGMessage *)messageHandler:(TGMessage *)message {

    TGMessage *returnedMessage = nil;
    
    if ([message.action isEqualToString:@"broadcasting"]) {
        [self broadcastingMessage:message];
    } else if ([message.action isEqualToString:@"set_shared_message"]) {
		[self.messageQueue addObject:message];
    } else if ([message.action isEqualToString:@"get_shared_message"]) {
//		[self.messageQueue addObject:message];
    	returnedMessage = [self getSharedMessage:message];
    }
    
    return returnedMessage;
}

- (void)broadcastingMessage:(TGMessage *)message {
    
    NSData* jsonData = [TGMessage jsonDataFromMessage:message];
    [[BLWebSocketsServer sharedInstance] pushToAll:jsonData];
}

- (void)setSharedMessage:(TGMessage *)message {
	[self.sharedMessages setObject:message.body forKey:message.name];
    if (message.isBroadcasting) {
        message.action = ACTION_SHARED_MESSAGE;
        [self broadcastingMessage:message];
    }
}

- (TGMessage*)getSharedMessage:(TGMessage *)message {
    TGMessage *returnedMessage = nil;
    if ([self.sharedMessages objectForKey:message.name]) {
        returnedMessage = [[TGMessage alloc] init];
        returnedMessage.action = ACTION_SHARED_MESSAGE;
        returnedMessage.timeStamp = [NSDate date];
    	returnedMessage.body = [self.sharedMessages objectForKey:message.name];
    }
    
    return returnedMessage;
}


- (void)stopCommunicationServer {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
    }];
}

@end
