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


@interface TGMessage : NSObject

@property (nonatomic, strong) NSString 	*action;
@property (nonatomic, strong) NSString 	*timestamp;
@property (nonatomic, strong) NSString 	*name;
@property (nonatomic) BOOL 				toSelf;
@property (nonatomic, strong) id 		body;

+ (TGMessage*)messageFromJsonData:(NSData *)jsonData;
+ (NSData *)jsonDataFromMessage:(TGMessage *)message;

@end
