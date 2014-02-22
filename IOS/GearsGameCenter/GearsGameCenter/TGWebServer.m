//
//  TGWebServer.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGWebServer.h"
#import "GCDWebServer.h"

@interface TGWebServer ()

@property (strong, nonatomic) GCDWebServer *webServer;

@end

@implementation TGWebServer

- (void)start {
    _webServer = [[GCDWebServer alloc] init];
    [_webServer addDefaultHandlerForMethod:@"GET"
                              requestClass:[GCDWebServerRequest class]
                              processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                  
                                  NSString *path = [request.path substringWithRange:NSMakeRange(1, request.path.length - 1)];
                                  NSString *ext = nil;
                                  NSRange range = [request.path rangeOfString:@"."];
                                  if (range.location != NSNotFound)
                                  {
                                      ext = [request.path substringWithRange:NSMakeRange(range.location + 1, request.path.length - range.location - 1)];
                                      path = [path substringWithRange:NSMakeRange(0, path.length - (path.length - range.location) - 1)];
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
    [_webServer startWithPort:80 bonjourName:nil];
}

@end
