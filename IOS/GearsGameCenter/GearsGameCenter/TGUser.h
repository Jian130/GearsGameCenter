//
//  TGUser.h
//  GearsGameCenter
//
//  Created by LJ-Jian on 2014-04-02.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TGUser : JSONModel

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *isHost;
@property (nonatomic, strong) NSString<Ignore> *sessionID;


+ (TGUser*)userFromJsonData:(NSData *)jsonData;
+ (NSData *)jsonDataFromUser:(TGUser *)message;

@end
