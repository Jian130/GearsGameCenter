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
#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "TGUser.h"

NSString* const ACTION_SHARED_MESSAGE = @"shared_message";

@interface TGCommunicationServer()

@property (strong, nonatomic) NSMutableDictionary *userList;
@property (nonatomic, strong) NSMutableDictionary *sharedMemory;
@property (nonatomic, strong) NSMutableArray *messageQueue;

@end

@implementation TGCommunicationServer

@synthesize userList = _userList;
@synthesize sharedMemory = _sharedMemory;

#pragma mark - shared instance

+ (id)sharedManager {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
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

        
		TGMessage* newMessage = [TGMessage messageFromJsonData:requestData];
        
        newMessage = [self messageHandler:newMessage sessionID:sessionID];
        NSData* jsonData = [TGMessage jsonDataFromMessage:newMessage];

        return jsonData;
    }];
}

- (TGMessage *)messageHandler:(TGMessage *)message sessionID:(NSString *)sessionID {

    TGMessage *returnedMessage = nil;
    
    NSLog(@"Incoming message action: %@", message.action);
    
    if ([message.action isEqualToString:@"broadcasting"]) {
        [self broadcastingMessage:message];
    } else if ([message.action isEqualToString:@"set_shared_memory"]) {
		[self.messageQueue addObject:message];
        [self writeSharedMemory:message];
    } else if ([message.action isEqualToString:@"get_shared_memory"]) {
    	returnedMessage = [self readSharedMemory:message];
    } else if ([message.action isEqualToString:@"set_user"]) {
        
        //create user
        TGUser *newUser = [[TGUser alloc] init];
        newUser.name = [message.body objectForKey:@"name"];
        newUser.sessionID = sessionID;
        newUser.property = [message.body objectForKey:@"property"];
        if (self.userList.count == 0) {
            newUser.isHost = @"1";
        } else {
            newUser.isHost = @"0";
        }
        
        //add user to userList
        [self.userList setObject:newUser forKey:sessionID];
        
        //prepare broadcast message
        TGMessage *broadcastMessage = [[TGMessage alloc] init];
        broadcastMessage.action = @"user_list";
        broadcastMessage.timestamp = [NSDate date];
        broadcastMessage.name = @"user_list";
        broadcastMessage.userList = [self.userList allValues];
        
        //broadcast message
        [self broadcastingMessage:broadcastMessage];
        
    } else if ([message.action isEqualToString:@"get_user_list"]) {
        //prepare return message
        returnedMessage = [[TGMessage alloc] init];
        returnedMessage.action = @"user_list";
        returnedMessage.timestamp = [NSDate date];
        returnedMessage.name = @"user_list";
        returnedMessage.userList = [self.userList allValues];
    }
    
    return returnedMessage;
}

- (void)broadcastingMessage:(TGMessage *)message {
    
    NSData* jsonData = [TGMessage jsonDataFromMessage:message];
    [[BLWebSocketsServer sharedInstance] pushToAll:jsonData];
}

- (void)writeSharedMemory:(TGMessage *)message {
    @synchronized(self.sharedMemory)
    {
        [self.sharedMemory setObject:message.body forKey:message.name];
        //if (message.isBroadcasting) {
            message.action = ACTION_SHARED_MESSAGE;
            [self broadcastingMessage:message];
        //}
    }
}

- (TGMessage*)readSharedMemory:(TGMessage *)message {
    @synchronized(self.sharedMemory)
    {
        TGMessage *returnedMessage = nil;
        if ([self.sharedMemory objectForKey:message.name]) {
            returnedMessage = [[TGMessage alloc] init];
            returnedMessage.action = ACTION_SHARED_MESSAGE;
            returnedMessage.timestamp = [NSDate date];
            returnedMessage.body = [self.sharedMemory objectForKey:message.name];
        }
        
        return returnedMessage;
    }
}


- (void)stopCommunicationServer {
	[[BLWebSocketsServer sharedInstance] stopWithCompletionBlock:^{
        NSLog(@"Server stopped");
        [self.userList removeAllObjects];
        [self.sharedMemory removeAllObjects];
    }];
}

@end
