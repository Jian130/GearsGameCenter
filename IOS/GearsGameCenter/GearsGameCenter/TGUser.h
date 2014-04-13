//
//  TGUser.h
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-04-02.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TGUser
@end

@interface TGUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isHost;
@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic, strong) id property;

//+ (TGUser*)userFromJsonData:(NSData *)jsonData;
//+ (NSData *)jsonDataFromUser:(TGUser *)message;

@end
