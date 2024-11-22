//
//  popoverViewController.m
//  TrueSecrets
//
//  Created by Madhur Kumaria on 29/05/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import "popoverViewController.h"

@interface popoverViewController ()

@end

@implementation popoverViewController

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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
