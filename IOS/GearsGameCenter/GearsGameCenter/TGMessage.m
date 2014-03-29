//  TGMessage.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-03-15.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGMessage.h"

@implementation TGMessage

+ (TGMessage *)messageFromJsonData:(NSData *)jsonData {
	
    NSError* error = nil;
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    TGMessage *newMessage = [[TGMessage alloc] initWithString:jsonString error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return newMessage;
}

+ (NSData *)jsonDataFromMessage:(TGMessage *)message {
	NSString* jsonString = [message toJSONString];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	return jsonData;
}

@end