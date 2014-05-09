//  TGMessage.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-03-15.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGMessage.h"

NSString* const KEY_MESSAGE_TIMESTAMP 	= @"timestamp";
NSString* const KEY_MESSAGE_ACTION 		= @"action";
NSString* const KEY_MESSAGE_NAME 		= @"name";
NSString* const KEY_MESSAGE_BODY 		= @"body";
NSString* const KEY_MESSAGE_TOSELF 		= @"toSelf";

@implementation TGMessage

+ (TGMessage *)messageFromJsonData:(NSData *)jsonData {

    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];

    TGMessage *newMessage = [[TGMessage alloc] init];
    newMessage.timestamp	= [object objectForKey:KEY_MESSAGE_TIMESTAMP];
    newMessage.action 		= [object objectForKey:KEY_MESSAGE_ACTION];
	newMessage.name 		= [object objectForKey:KEY_MESSAGE_NAME];
	newMessage.body 		= [object objectForKey:KEY_MESSAGE_BODY];
    newMessage.toSelf		= [[object objectForKey:KEY_MESSAGE_TOSELF] boolValue];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return newMessage;
}

+ (NSData *)jsonDataFromMessage:(TGMessage *)message {
    NSError *error = nil;
    
    if ([message.body isKindOfClass:[TGUser class]]) {
        message.body = [TGUser dictionaryFromUser:message.body];
    }
    
    NSDictionary *messageDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       message.action, KEY_MESSAGE_ACTION,
                                       message.name, KEY_MESSAGE_NAME,
                                       message.timestamp, KEY_MESSAGE_TIMESTAMP,
                                       message.body, KEY_MESSAGE_BODY, nil];
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:messageDictionary options:0 error:&error];
    
    if (error) {
    	NSLog(@"error: %@", error);
    }
	return jsonData;
}

@end