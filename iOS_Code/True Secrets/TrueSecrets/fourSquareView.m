//
//  fourSquareView.m
//  TrueSecrets
//
//  Created by Madhur Kumaria on 28/05/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import "fourSquareView.h"

@interface fourSquareView ()

@end

@implementation fourSquareView
@synthesize page2;

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
    
    self.navigationController.navigationBarHidden = NO;
    int x = [page2 intValue];
    if(x == 1)
    {
        NSString *fullURL = @"https://foursquare.com/v/1--prostitute-paid-with-stolen-crown-jewels--true-secrets-melbourne-stop-1/4deb126022713dd973a5beeb";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 2)
    {
        NSString *fullURL = @"https://foursquare.com/v/2--murder-victims-body-inside-dim-sims--true-secrets-melbourne-stop-2/4deb14f0ae60e989236b2666";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 3)
    {
        NSString *fullURL = @"https://foursquare.com/v/3--police-desert-city-centre-on-cup-day--true-secrets-melbourne-stop-3/4deb16a022713dd973a61dd2";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 4)
    {
        NSString *fullURL = @"https://foursquare.com/v/4--beatles-assassination-attempt-from-tower--true-secrets-melbourne-stop-4/4deb17c445dd3993a89e5260";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 5)
    {
        NSString *fullURL = @"https://foursquare.com/v/5--witness-of-secret-bank-deals-breaks-silence--true-secrets-melbourne-stop-5/4deb1a2efa76cc1b8af7f525";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 6)
    {
        NSString *fullURL = @"https://foursquare.com/v/6--landlord-brings-down-major-telco-at-midnight--true-secrets-melbourne-stop-6/4deb1b5b1f6e3ddebddf1ca4";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 7)
    {
        NSString *fullURL = @"https://foursquare.com/v/7--400-people-stripsearched--true-secrets-melbourne-stop-7/4deb1902fa76cc1b8af7da38";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
