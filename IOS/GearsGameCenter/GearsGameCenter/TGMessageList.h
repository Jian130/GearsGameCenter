//
//  TGMessageList.h
//  GearsGameCenter
//
//  Created by Peter Rau on 2014-03-29.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TGMessageList : JSONModel

@property (nonatomic, strong) NSString *action;
//@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSDate *timestamp;
//@property (nonatomic, assign) BOOL *isBroadcasting;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSMutableArray<Optional> *body;

+ (TGMessageList*)messageFromJsonData:(NSData *)jsonData;
+ (NSData *)jsonDataFromMessage:(TGMessageList *)message;

@end
