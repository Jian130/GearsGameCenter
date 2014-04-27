//
//  TGWebServer.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGWebServer.h"
#import "GCDWebServer.h"
#import "GCDSingleton.h"

@interface TGWebServer ()

@property (strong, nonatomic) GCDWebServer *webServer;

@end

@implementation TGWebServer

@synthesize webServer = _webServer;
@synthesize portNumber = _portNumber;

- (GCDWebServer *)webServer {
    if (!_webServer) {
        _webServer = [[GCDWebServer alloc] init];
    }
    
    return _webServer;
}

#pragma mark - shared instance

+ (id)sharedManager {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (void)startWebServer {
    
    self.portNumber = 8080;
    [self.webServer addDefaultHandlerForMethod:@"GET"
                                  requestClass:[GCDWebServerRequest class]
                                  processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                      
                                      NSString *gameFolder = @"games";
                                      
                                      //                                      NSString *path = [request.path substringWithRange:NSMakeRange(1, request.path.length - 1)];
                                      //                                      path = [path lowercaseString];
                                      NSString *path = [[gameFolder stringByAppendingString:request.path] lowercaseString];
                                      NSString *ext = nil;
                                      NSRange range = [path rangeOfString:@"." options:NSBackwardsSearch];
                                      
                                      if (range.location != NSNotFound) {
                                          ext = [path substringWithRange:NSMakeRange(range.location + 1, path.length - range.location - 1)];
                                          path = [path substringWithRange:NSMakeRange(0, range.location)];
                                      } else {
                                          ext = @"html";
                                          path = [path stringByAppendingString:@"index"];
                                      }
                                      
                                      NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:ext];
                                      
                                      if (filePath != nil) {
                                          NSData *data = [NSData dataWithContentsOfFile:filePath];
                                          if (data) {
                                              return [GCDWebServerDataResponse responseWithData:data contentType:ext];
                                          }
                                      }
                                      
                                      return [GCDWebServerDataResponse responseWithHTML:@"<html><body><p>Game file not found.</p></body></html>"];
                                      
                                  }];
    
    [self.webServer startWithPort:self.portNumber bonjourName:NULL];
}



- (void)stopWebServer {
    [self.webServer stop];
}

@end
