//
//  googleplusShareView.m
//  TrueSecrets
//
//  Created by Madhur Kumaria on 28/05/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import "googleplusShareView.h"

@interface googleplusShareView ()

@end

@implementation googleplusShareView

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
       NSString *fullURL = @"https://plus.google.com/b/117818034641922846101/117818034641922846101/posts";
        NSURL *url = [NSURL URLWithString:fullURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    
  
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
