//  TGMessage.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-03-15.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGMessage.h"

NSString* const KEY_MESSAGE_TIMESTAMP = @"timestamp";
NSString* const KEY_MESSAGE_ACTION = @"action";
NSString* const KEY_MESSAGE_NAME = @"name";
NSString* const KEY_MESSAGE_BODY = @"body";

@implementation TGMessage

+ (TGMessage *)messageFromJsonData:(NSData *)jsonData {
	
    TGMessage *newMessage = [[TGMessage alloc] init];
    NSError *error = nil;
    
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    newMessage.timestamp = [object objectForKey:KEY_MESSAGE_TIMESTAMP];
    newMessage.action = [object objectForKey:KEY_MESSAGE_ACTION];
	newMessage.name = [object objectForKey:KEY_MESSAGE_NAME];
	newMessage.body = [object objectForKey:KEY_MESSAGE_BODY];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return newMessage;
}

+ (NSData *)jsonDataFromMessage:(TGMessage *)message {
    NSError *error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:message options:0 error:&error];
    
    if (error) {
    	NSLog(@"error: %@", error);
    }
	return jsonData;
}

@end