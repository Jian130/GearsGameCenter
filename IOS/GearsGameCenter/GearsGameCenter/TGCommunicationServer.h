//
//  TGBroadcastingServer.h
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGCommunicationServer : NSObject

@property (nonatomic) int portNumber;

+ (id)sharedManager;

- (void)startCommunicationServer;
- (void)stopCommunicationServer;

@end
