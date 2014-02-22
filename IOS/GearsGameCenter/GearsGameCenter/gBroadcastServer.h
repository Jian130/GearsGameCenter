//
//  gBroadcastServer.h
//  gameserver
//
//  Created by Peter Rau on 2/12/2014.
//  Copyright (c) 2014 Peter Rau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gBroadcastServer : NSObject

- (NSString *)getIPAddress;

@property id delegate;

@end

@protocol BroadcastDelegate

- (void)gotConnection:(NSData *)addr inputStream:(NSInputStream *)istr outputStream:(NSOutputStream *)ostr;

@end