//
//  TGQRCodeViewController.m
//  GearsGameCenter
//
//  Created by Peter Rau on 2014-04-26.
//  Copyright (c) 2014 Gears. All rights reserved.
//

#import "TGQRCodeViewController.h"
#import "QREncoder.h"
#import "util.h"

@interface TGQRCodeViewController ()

@end

@implementation TGQRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    DataMatrix *qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:self.url];
    UIImage *qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:250];
    
    UIImageView* qrcodeImageView = [[UIImageView alloc] initWithImage:qrcodeImage];
    qrcodeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:qrcodeImageView];
    
    UIButton* closeButton = [[UIButton alloc] init];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(closeButtonTapped)forControlEvents:UIControlEventTouchDown];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(qrcodeImageView, closeButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[qrcodeImageView(==250)]-35-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[closeButton]-35-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[qrcodeImageView(==250)]-[closeButton]-35-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:viewsDictionary]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
