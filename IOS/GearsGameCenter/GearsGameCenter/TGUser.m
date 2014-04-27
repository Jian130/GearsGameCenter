//
//  TGUser.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-04-02.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGUser.h"

NSString* const KEY_USER_NAME 			= @"name";
NSString* const KEY_USER_ID 			= @"userId";
NSString* const KEY_USER_ISHOST 		= @"isHost";
NSString* const KEY_USER_PROPERTIES 	= @"properties";

@implementation TGUser

+ (TGUser*)userFromJsonData:(NSData *)jsonData {
    
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return [self userFromObject:object];
}

+ (TGUser*)userFromObject:(id)object {
    
    TGUser *newUser = [[TGUser alloc] init];
    newUser.name 		= [object objectForKey:KEY_USER_NAME];
    newUser.userID		= [object objectForKey:KEY_USER_ID];
    newUser.isHost 		= [object objectForKey:KEY_USER_ISHOST];
    newUser.properties	= [object objectForKey:KEY_USER_PROPERTIES];
    
    return newUser;
}

+ (NSData *)jsonDataFromUser:(TGUser *)user {
	NSError *error = nil;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
									user.name, KEY_USER_NAME,
                                    user.userID, KEY_USER_ID,
                                    user.isHost, KEY_USER_ISHOST,
                                    user.properties, KEY_USER_PROPERTIES, nil];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:0 error:&error];
    
    if (error) {
    	NSLog(@"error: %@", error);
    }
	return jsonData;
}

@end
