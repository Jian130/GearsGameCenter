//
//  TGMessage.h
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-03-15.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "TGUser.h"


@interface TGMessage : JSONModel

@property (nonatomic, strong) NSString *action;
//@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSDate *timestamp;
//@property (nonatomic, assign) BOOL *isBroadcasting;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSMutableDictionary<Optional> *body;
//@property (nonatomic, strong) NSArray<TGUser> *userList;

+ (TGMessage*)messageFromJsonData:(NSData *)jsonData;
+ (NSData *)jsonDataFromMessage:(TGMessage *)message;

@end
