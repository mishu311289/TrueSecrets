//
//  facebookProfileView.m
//  TrueSecrets
//
//  Created by Madhur Kumaria on 29/05/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import "facebookProfileView.h"

@interface facebookProfileView ()

@end

@implementation facebookProfileView
@synthesize page;

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
    int x = [page intValue];
    if(x == 1)
    {
    NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-1-The-Disappearance-Of-The-Parliamentary-Mace/134799926596521";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    }
    if(x == 2)
    {
        NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-2-Suspicious-Origins-Of-Dim-Sim/215536975133635";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 3)
    {
        NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-3-Cup-Day-Police-Strike/204494506261833";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 4)
    {
        NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-4-Boy-In-The-Tower/135878946486443";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 5)
    {
        NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-5-Gargoyles-Know-Secrets/215835468437904";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 6)
    {
        NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-6-Last-Minutes-Of-Onetel/206627439374509";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    if(x == 7)
    {
        NSString *fullURL = @"https://www.facebook.com/pages/True-Secrets-Melbourne-Stop-7-Tasty-Nightclub-Raid/160955067303807";
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
