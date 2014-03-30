//
//  TGMessageList.m
//  GearsGameCenter
//
//  Created by Peter Rau on 2014-03-29.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGMessageList.h"

@implementation TGMessageList

+ (TGMessageList *)messageFromJsonData:(NSData *)jsonData {
	
    NSError* error = nil;
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    TGMessageList *newMessage = [[TGMessageList alloc] initWithString:jsonString error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return newMessage;
}

+ (NSData *)jsonDataFromMessage:(TGMessageList *)message {
	NSString* jsonString = [message toJSONString];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	return jsonData;
}

@end
