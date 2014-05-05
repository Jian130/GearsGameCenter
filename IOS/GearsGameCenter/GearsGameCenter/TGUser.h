//
//  TGUser.h
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-04-02.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TGUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *isHost;
@property (nonatomic, strong) id properties;
@property (nonatomic) int sessionID;
@property (nonatomic) int status;

+ (TGUser*)userFromJsonData:(NSData *)jsonData withSessionID:(int)sessionID;
+ (TGUser*)userFromObject:(id)object withSessionID:(int)sessionID;
+ (NSData *)jsonDataFromUser:(TGUser *)user;
+ (NSDictionary *)dictionaryFromUser:(TGUser *)user;
@end
