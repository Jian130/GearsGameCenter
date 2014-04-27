//
//  TGViewController.m
//  GearsGameCenter
//
//  Created by LJ-Jian on 2/22/2014.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <MessageUI/MessageUI.h>

#include <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

#include <sys/types.h>
#include <net/if.h>
#include <netdb.h>

#include "util.h"

#import "TGAppDelegate.h"

#import "MMPDeepSleepPreventer.h"

#import "TGQRCodeViewController.h"


@interface TGViewController () <MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIActionSheet *inviteOptionsList;
@property (strong, nonatomic) MMPDeepSleepPreventer *preventDeepSleep;

@end

@implementation TGViewController

@synthesize webView = _webView;
@synthesize inviteOptionsList = _inviteOptionsList;
@synthesize preventDeepSleep = _preventDeepSleep;

- (UIActionSheet *)inviteOptionsList {
	if (!_inviteOptionsList) {
        _inviteOptionsList = [[UIActionSheet alloc] initWithTitle:nil
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"SMS", @"Copy game link to Clipboard", @"QR Code", nil];
    }
    
    return _inviteOptionsList;
}

- (MMPDeepSleepPreventer *)preventDeepSleep {
    if (!_preventDeepSleep) {
        _preventDeepSleep = [[MMPDeepSleepPreventer alloc] init];
    }
    
    return _preventDeepSleep;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[TGWebServer sharedManager] startWebServer];
    [[TGCommunicationServer sharedManager] startCommunicationServer];
    
    NSString *fullURL = [[@"http://" stringByAppendingString:@"127.0.0.1:8080/"] stringByAppendingString:self.gameName];
    
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    
    //[self.preventDeepSleep startPreventSleep];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareTapped:(id)sender {
    [self.inviteOptionsList showInView:self.view];
    
    
    
    /*
    
     */
}

- (IBAction)doneTapped:(id)sender {
    [[TGWebServer sharedManager] stopWebServer];
    [[TGCommunicationServer sharedManager] stopCommunicationServer];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //[self.preventDeepSleep stopPreventSleep];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self showSMSView];
            break;
        case 1:
            [self copyToClipboard];
            break;
        case 2:
            [self createQRCode];
            break;
    }
}

- (void)showSMSView {
    @try {
        if(![MFMessageComposeViewController canSendText]) {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            return;
        }
        
        NSString *gameLink = [self getGameUrl];
        
        NSString *message = [NSString stringWithFormat:@"Please join the %@ game by clicking on the link : %@", self.gameName, gameLink];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setBody:message];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }
    @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                        message:@"You must connect to a Wi-Fi network."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (NSString *)getGameUrl {
    
    NSString *gameURL;
    if ([Util getIPAddress]) {
        gameURL = [[[@"http://" stringByAppendingString:[Util getIPAddress]] stringByAppendingString:@":8080/"] stringByAppendingString:self.gameName];
    } else {
    	gameURL  = nil;
    }
    
    return gameURL;
}

- (void)copyToClipboard {
    [UIPasteboard generalPasteboard].string = [self getGameUrl];
}

- (void)createQRCode {
    NSString * url = [[[[@"http://" stringByAppendingString:[Util getIPAddress]] stringByAppendingString:@":8080/"] stringByAppendingString:self.gameName] stringByAppendingString:@""];
    
    TGQRCodeViewController *qrCodeViewController = [[TGQRCodeViewController alloc] init];
    qrCodeViewController.url = url;
    
    //[self.navigationController pushViewController:qrCodeViewController animated:YES];
    [self presentViewController:qrCodeViewController animated:YES completion:nil];
}

@end
