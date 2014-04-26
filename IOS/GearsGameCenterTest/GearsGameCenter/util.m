//
//  gBroadcastServer.m
//  gameserver
//
//  Created by Peter Rau on 2/12/2014.
//  Copyright (c) 2014 Peter Rau. All rights reserved.
//

#import "util.h"
#include <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

#include <sys/types.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <netdb.h>
#include <arpa/inet.h>

#include <unistd.h>


@implementation Util : NSObject

+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    
    if ([address isEqualToString:@"error"]) {
        address = [self getlocalIPAddress];
    }
    
   // NSArray *addresses = [[NSHost ] addresses];
    
    
    return address;
    
}

+ (NSString *)getlocalIPAddress
{
    NSMutableArray *ipAddresses = [NSMutableArray array] ;
    
    struct ifaddrs *allInterfaces;
    
    // Get list of all interfaces on the local machine:
    if (getifaddrs(&allInterfaces) == 0) {
        struct ifaddrs *interface;
        
        // For each interface ...
        for (interface = allInterfaces; interface != NULL; interface = interface->ifa_next) {
            unsigned int flags = interface->ifa_flags;
            struct sockaddr *addr = interface->ifa_addr;
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if ((flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING)) {
                if (addr->sa_family == AF_INET ){//|| addr->sa_family == AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    char host[NI_MAXHOST];
                    getnameinfo(addr, addr->sa_len, host, sizeof(host), NULL, 0, NI_NUMERICHOST);
                    
                    [ipAddresses addObject:[[NSString alloc] initWithUTF8String:host]];
                } else if (addr->sa_family == AF_INET6) {
                    // Convert interface address to a human readable string:
                    char host[NI_MAXHOST];
                    getnameinfo(addr, addr->sa_len, host, sizeof(host), NULL, 0, NI_NUMERICHOST);
                    
                    [ipAddresses addObject:[[NSString alloc] initWithUTF8String:host]];
                }
            }
        }
        
        freeifaddrs(allInterfaces);
    }
    
    NSString *ipAddress;
    
    for (NSString *ip in ipAddresses) {
        if ([ip rangeOfString:@"172"].location != NSNotFound) {
            ipAddress = ip;
        }
    }
    return ipAddress;
}



@end
