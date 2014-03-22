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
@property (strong, nonatomic) NSMutableDictionary *userList;
@property (nonatomic, strong) NSMutableDictionary *sharedMemory;
@property (nonatomic, strong) NSMutableArray *messageQueue;

@end

@implementation TGCommunicationServer

@synthesize clients = _clients;
@synthesize userList = _userList;
@synthesize sharedMemory = _sharedMemory;
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

- (NSMutableDictionary *)userList {
	if (!_userList) {
        _userList = [[NSMutableDictionary alloc] init];
    }
    
    return _userList;
}

- (NSMutableDictionary *)sharedMemory {
	if (!_sharedMemory) {
        _sharedMemory = [[NSMutableDictionary alloc] init];
    }
    
    return _sharedMemory;
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
        return nil;
    }];
}

- (TGMessage *)messageHandler:(TGMessage *)message {

    TGMessage *returnedMessage = nil;
    
    if ([message.action isEqualToString:@"broadcasting"]) {
        [self broadcastingMessage:message];
    } else if ([message.action isEqualToString:@"set_shared_memory"]) {
		[self.messageQueue addObject:message];
    } else if ([message.action isEqualToString:@"get_shared_memory"]) {
    	returnedMessage = [self getSharedMemory:message];
    } else if ([message.action isEqualToString:@"set_user"]) {
        [self.userList setObject:message.name forKey:message.body];
    } else if ([message.action isEqualToString:@"get_user_list"]) {
        bool isFirst = YES;
        NSMutableString * body = [[NSMutableString alloc] init];
        [body appendString:@"["];
        for (NSString* key in self.userList) {
            if (!isFirst) {
                [body appendString:@","];
            }
            [body appendString:@"{"];
            [body appendString:key];
            [body appendString:@":"];
            [body appendString:[self.userList objectForKey:key]];
            [body appendString:@"}"];
            isFirst = NO;
        }
        [body appendString:@"]"];
        returnedMessage = [[TGMessage alloc] init];
        returnedMessage.action = @"user_list";
        returnedMessage.timeStamp = [NSDate date];
        returnedMessage.name = @"user_list";
        returnedMessage.body = body;
    }
    
    return returnedMessage;
}

- (void)broadcastingMessage:(TGMessage *)message {
    
    NSData* jsonData = [TGMessage jsonDataFromMessage:message];
    [[BLWebSocketsServer sharedInstance] pushToAll:jsonData];
}

- (void)setSharedMemory:(TGMessage *)message {
    @synchronized(self.sharedMemory)
    {
        [self.sharedMemory setObject:message.body forKey:message.name];
        //if (message.isBroadcasting) {
            message.action = ACTION_SHARED_MESSAGE;
            [self broadcastingMessage:message];
        //}
    }
}

- (TGMessage*)getSharedMemory:(TGMessage *)message {
    @synchronized(self.sharedMemory)
    {
        TGMessage *returnedMessage = nil;
        if ([self.sharedMemory objectForKey:message.name]) {
            returnedMessage = [[TGMessage alloc] init];
            returnedMessage.action = ACTION_SHARED_MESSAGE;
            returnedMessage.timeStamp = [NSDate date];
            returnedMessage.body = [self.sharedMemory objectForKey:message.name];
        }
        
        return returnedMessage;
    }
}


- (void)stopCommunicationServer {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
    }];
}

@end
