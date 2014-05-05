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

+ (TGUser*)userFromJsonData:(NSData *)jsonData withSessionID:(int)sessionID {
    
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    return [self userFromObject:object withSessionID:sessionID];
}

+ (TGUser*)userFromObject:(id)object withSessionID:(int)sessionID {
    
    TGUser *newUser = [[TGUser alloc] init];
    newUser.name 		= [object objectForKey:KEY_USER_NAME];
    newUser.userID		= [object objectForKey:KEY_USER_ID];
    newUser.isHost 		= [object objectForKey:KEY_USER_ISHOST];
    newUser.properties	= [object objectForKey:KEY_USER_PROPERTIES];
    newUser.sessionID	= sessionID;
    
    return newUser;
}

+ (NSDictionary *)dictionaryFromUser:(TGUser *)user {
	NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
									user.name, KEY_USER_NAME,
                                    user.userID, KEY_USER_ID,
                                    user.isHost, KEY_USER_ISHOST,
                                    user.properties, KEY_USER_PROPERTIES, nil];
	return userDictionary;
}

+ (NSData *)jsonDataFromUser:(TGUser *)user {
	NSError *error = nil;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self dictionaryFromUser:user]
                                                       options:0
                                                         error:&error];
    
    if (error) {
    	NSLog(@"error: %@", error);
    }
	return jsonData;
}

@end
