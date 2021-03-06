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

@interface TGUser : JSONModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString<Optional> *isHost;
@property (nonatomic, strong) NSString<Optional> *sessionID;
//@property (nonatomic, strong) NSDictionary<Optional> *properties;
@property (nonatomic, strong) NSString<Optional> *property;

+ (TGUser*)userFromJsonData:(NSData *)jsonData;
+ (NSData *)jsonDataFromUser:(TGUser *)message;

@end
