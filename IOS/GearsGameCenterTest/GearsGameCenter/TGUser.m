//
//  TGUser.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-04-02.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGUser.h"

@implementation TGUser


+ (TGUser*)userFromJsonData:(NSData *)jsonData {

	NSError* error = nil;
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    TGUser *newUser = [[TGUser alloc] initWithString:jsonString error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return newUser;
}

+ (NSData *)jsonDataFromUser:(TGUser *)user {
	NSString* jsonString = [user toJSONString];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	return jsonData;
}

@end
