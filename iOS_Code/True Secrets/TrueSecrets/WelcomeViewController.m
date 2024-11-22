
//
//  WelcomeViewController.m
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import "WelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "Secret1ViewController.h"
#import "Secret1ViewController.h"
#import "Secret2ViewController.h"
#import "Secret3ViewController.h"
#import "Secret4ViewController.h"
#import "Secret5ViewController.h"
#import "Secret6ViewController.h"
#import "Secret7ViewController.h"
@interface WelcomeViewController ()
{
    UIActivityIndicatorView *indicator;
    UIView *DisableView;
}
@end

@implementation WelcomeViewController
@synthesize scrollView,welcomePlayImage,welcomeAudioPlayer,enterCouponTxt,couponView,cancelbtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    cancelbtn.hidden = YES;
}
- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.center = self.view.center;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    DisableView.backgroundColor=[UIColor blackColor];
    DisableView.alpha=0.5;
    [self.view addSubview:DisableView];
    indicator.color=[UIColor grayColor];
    [DisableView addSubview:indicator];
    [indicator startAnimating];
    [DisableView bringSubviewToFront:self.view];
    scrollView.userInteractionEnabled = YES;
     toggle = true;
    DisableView.hidden = YES;
 //com.whatwasthat.${PRODUCT_NAME:rfc1034identifier}
    
    //self.navigationController.navigationBarHidden = YES;
    
    
    NSUserDefaults *user_default = [NSUserDefaults standardUserDefaults];
   // [user_default setObject:@"Purchased" forKey:@"Products"];
   // [user_default setObject:@"Purchased123" forKey:@"Products"];
    check_status = [NSString stringWithFormat:@"%@",[user_default valueForKey:@"Products"]];
    //
    //check_status = [NSString stringWithFormat:@"Purchased"];
    
    
    MytableView = NULL;
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
    {
        self.navigationController.navigationBarHidden = YES;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setBackgroundColor:[UIColor blackColor]];
        //scrollView.bounces = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide:)];
        
        
        tap.delegate=self;
        tap.cancelsTouchesInView = NO;
        tap.numberOfTapsRequired = 1;
        
        self.view.userInteractionEnabled = YES;
        [self.view addGestureRecognizer:tap];
        
        [scrollView setContentSize: CGSizeMake(768 , 1024)];
        //[scrollView setContentOffset:scrollView.contentOffset animated:YES];
        
        
//        backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1150)];
//        backgroundImg.image = [UIImage imageNamed:@"bgfinal.png"];
//        [scrollView addSubview:backgroundImg];
        
        
        UIView *imageViewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 30)];
        backgroundImgNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 30)];
        backgroundImgNew.image = [UIImage imageNamed:@"navigation.png"];
        [imageViewTop addSubview:backgroundImgNew];
        imageViewTop.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:imageViewTop];
        
        
        
        logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 30, 250, 50)];
        logoImage.image = [UIImage imageNamed:@"logo1.png"];
        [scrollView addSubview:logoImage];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(235, 90, 300, 25)];
        lable1.text = @"Welcome to the tour";
        lable1.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:23];
        lable1.textAlignment=UITextAlignmentCenter;
        lable1.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lable1.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lable1];
        
        UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(257, 120, 280, 25)];
        lable4.text = @"Just swipe to the left to start,or click below";
        lable4.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
        lable4.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lable4.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lable4];
        
        UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(334, 146, 300, 25)];
        lable5.text = @"Before you start:";
        lable5.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
        lable5.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lable5.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lable5];
        
        UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(87, 161, 300, 25)];
        lable6.text = @"Best enjoyed with headphones and some friends.";
        lable6.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
        lable6.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lable6.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lable6];
        
        UILabel *lable7 = [[UILabel alloc] initWithFrame:CGRectMake(375, 161, 300, 25)];
        lable7.text = @"You can get a discount coupon";
        lable7.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
        lable7.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lable7.backgroundColor = [UIColor clearColor];
       // [scrollView addSubview:lable7];
        
        UILabel *btn7 = [[UILabel alloc] initWithFrame:CGRectMake(555, 161, 300, 25)];
        
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @2};
        btn7.attributedText = [[NSAttributedString alloc] initWithString:@"for a friend here"
                                                              attributes:underlineAttribute];
        
        //btn7.text = @"for a friend here";
        btn7.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
        btn7.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        btn7.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutView:)];
        
        
        tap1.delegate=self;
        
        tap1.numberOfTapsRequired = 1;
        btn7.userInteractionEnabled = YES;
      //  [btn7 addGestureRecognizer:tap1];
      //  [scrollView addSubview:btn7];
        
        
        UIButton *welcomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[welcomeButton setImage:[UIImage imageNamed:@"stock-photo-golden-scepter-sceptre-in-perspective-view-101886793.jpg"] forState:UIControlStateNormal];
        welcomeButton.frame = CGRectMake(180, 198, 400, 28);
        [welcomeButton setTitle:@"Welcome" forState:UIControlStateNormal];
        welcomeButton.layer.cornerRadius=14;
        welcomeButton.clipsToBounds=YES;
        [welcomeButton addTarget:self action:@selector(palyWelcomeMusic:) forControlEvents:UIControlEventTouchUpInside];
        welcomeButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [scrollView addSubview:welcomeButton];
        
        welcomePlayImage=[[UIButton alloc]initWithFrame:CGRectMake(500, 197, 40, 30)];
        [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [welcomePlayImage addTarget:self action:@selector(palyWelcomeMusic:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:welcomePlayImage];
        
        
        if (![check_status isEqualToString:@"Purchased"])
        {
            UITapGestureRecognizer *singleTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
            
            
            
            firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 230, 700, 160)];
            firstView.backgroundColor = [UIColor blackColor];
            firstView.alpha = 0.5;
            [scrollView addSubview: firstView];
            
            [firstView addGestureRecognizer:singleTapGestureRecognizer1];
            
            
            UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
            secondView = [[UIView alloc]initWithFrame:CGRectMake(20, 470, 700,500)];
            secondView.backgroundColor = [UIColor blackColor];
            secondView.alpha = 0.5;
            [scrollView addSubview:secondView];
            
            
            [secondView addGestureRecognizer:singleTapGestureRecognizer];
        }else{
            [firstView removeFromSuperview];
            [secondView removeFromSuperview];
        }
        
        
        //~~~~~~~~~~~~~~ 1st Secret~~~~~~~~~~~~~~//
                
        UIButton *secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(275, 240, 380, 50);
        [secretlbl setTitle:@"1. Prostitute paid with stolen\n crown jewels" forState:UIControlStateNormal];
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(handleGesture:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        

        [scrollView addSubview:secretlbl];
        
        UIButton *secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-1-mace-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 230, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(handleGesture:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:secretimg];
        [scrollView bringSubviewToFront:firstView];
        //~~~~~~~~~~~~~~~~ 2nd Secret ~~~~~~~~~~~~~~~~~~~~~//
        secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(225, 325, 380, 50);
        [secretlbl setTitle:@"2. Victim's body inside dim sims" forState:UIControlStateNormal];
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(Secretbtn2:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

        [scrollView addSubview:secretlbl];
        
        secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-2-dimsim-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 310, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(Secretbtn2:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:secretimg];
        [scrollView bringSubviewToFront:firstView];

        //~~~~~~~~~~~~~~~~~~~~ 3rd Secret ~~~~~~~~~~~~~~~~~//
        secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(250, 410, 380, 50);
        [secretlbl setTitle:@"3. Police desert city center on cup day" forState:UIControlStateNormal];
        secretlbl.titleLabel.textAlignment = UITextAlignmentLeft;
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(Secret3:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

        [scrollView addSubview:secretlbl];
        
        secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-3-police-strike-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 395, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(Secret3:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:secretimg];
        
        //~~~~~~~~~~~~~~~~~~~~ 4th Secret ~~~~~~~~~~~~~~~~~//
        secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(275, 495, 380, 50);
        [secretlbl setTitle:@"4. Beatles assassination attempt from tower" forState:UIControlStateNormal];
        [secretlbl.titleLabel setTextAlignment:UITextAlignmentLeft];
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(Secret4:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

        [scrollView addSubview:secretlbl];
        
        secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-4-assassin-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 480, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(Secret4:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:secretimg];
        [scrollView bringSubviewToFront:secondView];

        //~~~~~~~~~~~~~~~~~~~~ 5th Secret ~~~~~~~~~~~~~~~~~//
        secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(275, 580, 380, 50);
        [secretlbl setTitle:@"5. Witness of secret bank deals break silence" forState:UIControlStateNormal];
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(Secret5:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl.titleLabel setTextAlignment:UITextAlignmentLeft];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

        [scrollView addSubview:secretlbl];
        
        secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-5-gargoyles-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 565, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(Secret5:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:secretimg];
        [scrollView bringSubviewToFront:secondView];

        //~~~~~~~~~~~~~~~~~~~~ 6th Secret ~~~~~~~~~~~~~~~~~//
        secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(290, 665, 380, 50);
        [secretlbl setTitle:@"6. Landlord brings down major telco at midnight" forState:UIControlStateNormal];
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(Secret6:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl.titleLabel setTextAlignment:UITextAlignmentLeft];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

        [scrollView addSubview:secretlbl];
        
        secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-6-one.tel-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 650, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(Secret6:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:secretimg];
        [scrollView bringSubviewToFront:secondView];

        //~~~~~~~~~~~~~~~~~~~~ 7th Secret ~~~~~~~~~~~~~~~~~//
        secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
        secretlbl.frame = CGRectMake(250, 750, 380, 50);
        [secretlbl setTitle:@"7. 400 people strip-searched by police" forState:UIControlStateNormal];
        [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:18.0f]];
        [secretlbl addTarget:self action:@selector(Secret7:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

        [secretlbl.titleLabel setTextAlignment:UITextAlignmentLeft];
        [scrollView addSubview:secretlbl];
        
        secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
        [secretimg setImage:[UIImage imageNamed:@"secret-7-police-raid-100.png"] forState:UIControlStateNormal];
        secretimg.frame = CGRectMake(80, 735, 100, 70);
        secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        secretimg.layer.cornerRadius=10;
        secretimg.clipsToBounds=YES;
        secretimg.layer.borderWidth =2;
        [secretimg addTarget:self action:@selector(Secret7:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:secretimg];
        [scrollView bringSubviewToFront:secondView];

        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(385, 820, 60, 25)];
        lbl.text = @"Enjoy:)";
        lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        lbl.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lbl.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lbl];
        
        //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
        
        UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // [homeViewButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
        homeViewButton.frame = CGRectMake(0, 969, 272, 35);
        [homeViewButton setTitle:@"home" forState:UIControlStateNormal];
        [homeViewButton.titleLabel setTextAlignment : UITextAlignmentCenter];
        homeViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
        //[homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
        homeViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        
        [homeViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.view addSubview:homeViewButton];
        
        
        
        // ------------------for secrets buttons in footer-------------//
        UIButton *secretViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        secretViewButton.frame = CGRectMake(256, 969, 270, 35);
        [secretViewButton setTitle:@"secret" forState:UIControlStateNormal];
        secretViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
        secretViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [secretViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [secretViewButton addTarget:self action:@selector(secretView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:secretViewButton];
        
        //---------------- For About Button in footer----------------//
        UIButton *aboutViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aboutViewButton.frame = CGRectMake(512, 969, 270, 35);
        [aboutViewButton setTitle:@"about" forState:UIControlStateNormal];
        aboutViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
        aboutViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [aboutViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString* check_status1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
        if (![check_status1 isEqualToString:@"Purchased"])
        {
            [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        [self.view addSubview:aboutViewButton];
        
        
        
        
        secretvc1 = [[Secret1ViewController alloc]initWithNibName:@"Secret1ViewController" bundle:nil];
        secretvc2 = [[Secret2ViewController alloc]initWithNibName:@"Secret2ViewController" bundle:nil];
        secretvc3 = [[Secret3ViewController alloc]initWithNibName:@"Secret3ViewController" bundle:nil];
        secretvc4 = [[Secret4ViewController alloc]initWithNibName:@"Secret4ViewController" bundle:nil];
        secretvc5 = [[Secret5ViewController alloc]initWithNibName:@"Secret5ViewController" bundle:nil];
        secretvc6 = [[Secret6ViewController alloc]initWithNibName:@"Secret6ViewController" bundle:nil];
        secretvc7 = [[Secret7ViewController alloc]initWithNibName:@"Secret7ViewController" bundle:nil];
        endvc = [[EndViewController alloc]initWithNibName:@"EndViewController" bundle:nil];
        
        UISwipeGestureRecognizer *swipeLeftRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [swipeLeftRight setDirection:(UISwipeGestureRecognizerDirectionLeft )];
        [scrollView addGestureRecognizer:swipeLeftRight];
        [super viewDidLoad];

    }
    else
    {
     
        self.navigationController.navigationBarHidden = YES;
    //[scrollView setPagingEnabled: YES];
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setBackgroundColor:[UIColor blackColor]];
        CGSize result = [[UIScreen mainScreen]bounds].size ;
        if (result.height == 480)
        {
        [scrollView setContentSize: CGSizeMake(320 , 900)];
        }
        if (result.height == 568)
        {
         [scrollView setContentSize: CGSizeMake(320 , 900)];   
        }
//        if (result.height == 640)
//        {
//         [scrollView setContentSize: CGSizeMake(320 , 1000)];
//        }
                       //scrollView.bounces = NO;
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide:)];
        
        
        tap.delegate=self;
        tap.cancelsTouchesInView = NO;
        tap.numberOfTapsRequired = 1;
        
        self.view.userInteractionEnabled = YES;
        [self.view addGestureRecognizer:tap];
        
    
	//[scrollView setContentOffset:scrollView.contentOffset animated:YES];
    
  
//    backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 900)];
//    backgroundImg.image = [UIImage imageNamed:@"bgfinal.png"];
//    [scrollView addSubview:backgroundImg];
  
        
    UIView *imageViewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    backgroundImgNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    backgroundImgNew.image = [UIImage imageNamed:@"navigation.png"];
    [imageViewTop addSubview:backgroundImgNew];
    imageViewTop.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:imageViewTop];
   
    logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 30, 250, 50)];
    logoImage.image = [UIImage imageNamed:@"logo1.png"];
    [scrollView addSubview:logoImage];
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(28, 90, 260, 25)];
    lable1.text = @"Welcome to the tour";
    lable1.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:21];
    lable1.textAlignment=UITextAlignmentCenter;
    lable1.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lable1.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lable1];
    
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(27, 120, 300, 25)];
    lable4.text = @"Just swipe to the left to start,or click below";
    lable4.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
    lable4.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lable4.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lable4];
    
    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(115, 146, 260, 25)];
    lable5.text = @"Before you start:";
    lable5.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
    lable5.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lable5.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lable5];
    
    UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(17, 161, 290, 25)];
    lable6.text = @"Best enjoyed with headphones and some friends.";
    lable6.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
    lable6.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lable6.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lable6];
    
    UILabel *lable7 = [[UILabel alloc] initWithFrame:CGRectMake(25, 174, 290, 25)];
    lable7.text = @"You can get a discount coupon";
    lable7.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
    lable7.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lable7.backgroundColor = [UIColor clearColor];
    //[scrollView addSubview:lable7];
    
    
    // UILabel *lable7 = [[UILabel alloc] initWithFrame:CGRectMake(25, 174, 290, 25)];
    // lable7.text = @"";
    // lable7.font = [UIFont fontWithName:@"NoticiaText-Regular" size:13];
    // lable7.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    // lable7.backgroundColor = [UIColor clearColor];
    // [scrollView addSubview:lable7];
    
    /////////////////////////////////////
    
    UILabel *btn7 = [[UILabel alloc] initWithFrame:CGRectMake(207, 174, 290, 25)];
    
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @2};
    btn7.attributedText = [[NSAttributedString alloc] initWithString:@"for a friend here"
                                                          attributes:underlineAttribute];
    
    //btn7.text = @"for a friend here";
    btn7.font = [UIFont fontWithName:@"NoticiaText-Regular" size:12.6f];
    btn7.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    btn7.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutView:)];
        
        
    tap1.delegate=self;
        
    tap1.numberOfTapsRequired = 1;
    btn7.userInteractionEnabled = YES;
   // [btn7 addGestureRecognizer:tap1];
   // [scrollView addSubview:btn7];


    UIButton *welcomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[welcomeButton setImage:[UIImage imageNamed:@"stock-photo-golden-scepter-sceptre-in-perspective-view-101886793.jpg"] forState:UIControlStateNormal];
    welcomeButton.frame = CGRectMake(90, 198, 150, 28);
    [welcomeButton setTitle:@"Welcome" forState:UIControlStateNormal];
    welcomeButton.layer.cornerRadius=14;
    welcomeButton.clipsToBounds=YES;
    [welcomeButton addTarget:self action:@selector(palyWelcomeMusic:) forControlEvents:UIControlEventTouchUpInside];
    welcomeButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [scrollView addSubview:welcomeButton];
    
     welcomePlayImage=[[UIButton alloc]initWithFrame:CGRectMake(202, 197, 40, 30)];
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [welcomePlayImage addTarget:self action:@selector(palyWelcomeMusic:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:welcomePlayImage];
    
         UITapGestureRecognizer *singleTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
        if (![check_status isEqualToString:@"Purchased"])
        {
           

            
            
            firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 230, 290, 160)];
            firstView.backgroundColor = [UIColor blackColor];
            firstView.alpha = 0.5;
            [scrollView addSubview: firstView];
            
            [firstView addGestureRecognizer:singleTapGestureRecognizer1];
            
          
            UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
            secondView = [[UIView alloc]initWithFrame:CGRectMake(20, 470, 290,500)];
            secondView.backgroundColor = [UIColor blackColor];
            secondView.alpha = 0.5;
            [scrollView addSubview:secondView];
            
            
            [secondView addGestureRecognizer:singleTapGestureRecognizer];
        }else{
            [firstView removeFromSuperview];
            [secondView removeFromSuperview];
        }
        
    //~~~~~~~~~~~~~~ 1st Secret~~~~~~~~~~~~~~//
    UIButton *secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 240, 180, 50);
    [secretlbl setTitle:@"1. Prostitute paid with stolen\n crown jewels" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14.0f]];
    [secretlbl addTarget:self action:@selector(handleGesture:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    [scrollView addSubview:secretlbl];
    
    UIButton *secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-1-mace-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 230, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(handleGesture:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:secretimg];
      
        
        [scrollView bringSubviewToFront:firstView];
    //~~~~~~~~~~~~~~~~ 2nd Secret ~~~~~~~~~~~~~~~~~~~~~//
    secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 325, 180, 50);
    [secretlbl setTitle:@"2. Victim's body inside dim sims" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14.0f]];
    [secretlbl addTarget:self action:@selector(Secretbtn2:) forControlEvents:UIControlEventTouchUpInside];
        [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    [scrollView addSubview:secretlbl];
    
    secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-2-dimsim-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 310, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(Secretbtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:secretimg];
        
     
    [scrollView bringSubviewToFront:firstView];

    //~~~~~~~~~~~~~~~~~~~~ 3rd Secret ~~~~~~~~~~~~~~~~~//
    secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 410, 180, 50);
    [secretlbl setTitle:@"3. Police desert city center on cup day" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    secretlbl.titleLabel.textAlignment = UITextAlignmentLeft;
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14]];
    [secretlbl addTarget:self action:@selector(Secret3:) forControlEvents:UIControlEventTouchUpInside];
    [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    [scrollView addSubview:secretlbl];
    
    secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-3-police-strike-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 395, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(Secret3:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:secretimg];
        
        
        

    //~~~~~~~~~~~~~~~~~~~~ 4th Secret ~~~~~~~~~~~~~~~~~//
    secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 495, 145, 50);
    [secretlbl setTitle:@"4. Beatles assassination attempt from tower" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    secretlbl.titleLabel.textAlignment = UITextAlignmentLeft;
        
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14]];
    [secretlbl addTarget:self action:@selector(Secret4:) forControlEvents:UIControlEventTouchUpInside];
   [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollView addSubview:secretlbl];
    
    secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-4-assassin-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 480, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(Secret4:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:secretimg];
        
        
        [scrollView bringSubviewToFront:secondView];

    //~~~~~~~~~~~~~~~~~~~~ 5th Secret ~~~~~~~~~~~~~~~~~//
    secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 580, 155, 50);
    [secretlbl setTitle:@"5. Witness of secret bank deals break silence" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14]];
    [secretlbl addTarget:self action:@selector(Secret5:) forControlEvents:UIControlEventTouchUpInside];
    [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollView addSubview:secretlbl];
    
    secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-5-gargoyles-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 565, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(Secret5:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:secretimg];
        
        [scrollView bringSubviewToFront:secondView];

    //~~~~~~~~~~~~~~~~~~~~ 6th Secret ~~~~~~~~~~~~~~~~~//
    secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 665, 180, 50);
    [secretlbl setTitle:@"6. Landlord brings down major telco at midnight" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14]];
    [secretlbl addTarget:self action:@selector(Secret6:) forControlEvents:UIControlEventTouchUpInside];
    [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollView addSubview:secretlbl];
    
    secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-6-one.tel-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 650, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(Secret6:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:secretimg];
        
        [scrollView bringSubviewToFront:secondView];
        //~~~~~~~~~~~~~~~~~~~~ 7th Secret ~~~~~~~~~~~~~~~~~//
    secretlbl =[UIButton buttonWithType:UIButtonTypeCustom];
    secretlbl.frame = CGRectMake(125, 750, 170, 50);
    [secretlbl setTitle:@"7. 400 people strip-searched by police" forState:UIControlStateNormal];
    secretlbl.titleLabel.numberOfLines=2;
    [[secretlbl titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:14]];
    [secretlbl addTarget:self action:@selector(Secret7:) forControlEvents:UIControlEventTouchUpInside];
    [secretlbl setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollView addSubview:secretlbl];
    
    secretimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [secretimg setImage:[UIImage imageNamed:@"secret-7-police-raid-100.png"] forState:UIControlStateNormal];
    secretimg.frame = CGRectMake(20, 735, 100, 70);
    secretimg.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    secretimg.layer.cornerRadius=10;
    secretimg.clipsToBounds=YES;
    secretimg.layer.borderWidth =2;
    [secretimg addTarget:self action:@selector(Secret7:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:secretimg];
        
 [scrollView bringSubviewToFront:secondView];
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(135, 820, 60, 25)];
    lbl.text = @"Enjoy:)";
    lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    lbl.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lbl.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lbl];
    
        if (result.height == 480)
        {

            
            //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
            
            UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            // [homeViewButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            homeViewButton.frame = CGRectMake(0, 445, 105, 35);
            [homeViewButton setTitle:@"home" forState:UIControlStateNormal];
            homeViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            //[homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
            homeViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            
            [homeViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.view addSubview:homeViewButton];
            
            // ------------------for secrets buttons in footer-------------//
            UIButton *secretViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secretViewButton.frame = CGRectMake(105, 445, 110, 35);
            [secretViewButton setTitle:@"secret" forState:UIControlStateNormal];
            secretViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            secretViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            [secretViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [secretViewButton addTarget:self action:@selector(secretView:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:secretViewButton];
            
            //---------------- For About Button in footer----------------//
            UIButton *aboutViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            aboutViewButton.frame = CGRectMake(215, 445, 105, 35);
            [aboutViewButton setTitle:@"about" forState:UIControlStateNormal];
            aboutViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            aboutViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            [aboutViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
            NSString* check_status1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
            if (![check_status1 isEqualToString:@"Purchased"])
            {
                [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
            [self.view addSubview:aboutViewButton];
        }
        else if(result.height == 568)
        {
            //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
            
            UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            // [homeViewButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            homeViewButton.frame = CGRectMake(0, 533, 105, 35);
            [homeViewButton setTitle:@"home" forState:UIControlStateNormal];
            homeViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            //[homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
            homeViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            
            [homeViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.view addSubview:homeViewButton];
            
            // ------------------for secrets buttons in footer-------------//
            UIButton *secretViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secretViewButton.frame = CGRectMake(105, 533, 110, 35);
            [secretViewButton setTitle:@"secret" forState:UIControlStateNormal];
            secretViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            secretViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            [secretViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [secretViewButton addTarget:self action:@selector(secretView:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:secretViewButton];
            
            //---------------- For About Button in footer----------------//
            UIButton *aboutViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            aboutViewButton.frame = CGRectMake(215, 533, 105, 35);
            [aboutViewButton setTitle:@"about" forState:UIControlStateNormal];
            aboutViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            aboutViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            [aboutViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
            NSString* check_status1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
            if (![check_status1 isEqualToString:@"Purchased"])
            {
                [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
            [self.view addSubview:aboutViewButton];
            
        }
        else if (result.height == 640)
        {
                     
            
            UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            // [homeViewButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            homeViewButton.frame = CGRectMake(100, 445  , 105, 35);
            [homeViewButton setTitle:@"home" forState:UIControlStateNormal];
            homeViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            //[homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
            homeViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            
            [homeViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.view addSubview:homeViewButton];
            
            // ------------------for secrets buttons in footer-------------//
            UIButton *secretViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secretViewButton.frame = CGRectMake(105, 445, 110, 15);
            [secretViewButton setTitle:@"secret" forState:UIControlStateNormal];
            secretViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            secretViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            [secretViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [secretViewButton addTarget:self action:@selector(secretView:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:secretViewButton];
            
            //---------------- For About Button in footer----------------//
            UIButton *aboutViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            aboutViewButton.frame = CGRectMake(215, 445, 105, 15);
            [aboutViewButton setTitle:@"about" forState:UIControlStateNormal];
            aboutViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
            aboutViewButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
            [aboutViewButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
            NSString* check_status1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
            if (![check_status1 isEqualToString:@"Purchased"])
            {
                [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [self.view addSubview:aboutViewButton];
            
        }
        

    
    
    secretvc1 = [[Secret1ViewController alloc]initWithNibName:@"Secret1ViewController" bundle:nil];
    secretvc2 = [[Secret2ViewController alloc]initWithNibName:@"Secret2ViewController" bundle:nil];
    secretvc3 = [[Secret3ViewController alloc]initWithNibName:@"Secret3ViewController" bundle:nil];
    secretvc4 = [[Secret4ViewController alloc]initWithNibName:@"Secret4ViewController" bundle:nil];
    secretvc5 = [[Secret5ViewController alloc]initWithNibName:@"Secret5ViewController" bundle:nil];
    secretvc6 = [[Secret6ViewController alloc]initWithNibName:@"Secret6ViewController" bundle:nil];
    secretvc7 = [[Secret7ViewController alloc]initWithNibName:@"Secret7ViewController" bundle:nil];
    endvc = [[EndViewController alloc]initWithNibName:@"EndViewController" bundle:nil];
        
        //---check for payment done or not to start swipe
        
    UISwipeGestureRecognizer *swipeLeftRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [swipeLeftRight setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [scrollView addGestureRecognizer:swipeLeftRight];
        
        
    [super viewDidLoad];
}
}

-(void)viewWillAppear:(BOOL)animated
{
    toggle = true;
    [self viewDidLoad];
    scrollView.userInteractionEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view setUserInteractionEnabled:YES];
}
   //~~~~~~~~~~~~~~~~~~~~~~ For Swiping and Moving to Secret1~~~~~~~~~~~~~~~~~~//
-(IBAction)handleGesture:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
   // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
   // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
   // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
   // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
   [welcomeAudioPlayer stop];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    
//    [self presentModalViewController:secretvc1 animated:NO];
    
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    
    if ([check_status isEqualToString:@"Purchased"])
    {
    [self.navigationController pushViewController:secretvc1 animated:NO];
    }else {
        Secret3ViewController *obj111 = [[Secret3ViewController alloc]initWithNibName:@"Secret3ViewController" bundle:nil];
        [self.navigationController pushViewController:obj111 animated:YES];
    }
  //  [self.navigationController pushViewController:secretvc1 animated:YES];
    
}

//~~~~~~~~~~~~~~~~~~~~~~ For Moving to End~~~~~~~~~~~~~~~~~~//
-(IBAction)aboutView:(id)sender
{
   NSString * check_status1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
    if ([check_status1 isEqualToString:@"Purchased"])
    {
    
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:endvc animated:NO];
   // [self.navigationController pushViewController:endvc animated:YES];
    }
}
//~~~~~~~~~~~~~~~~~~~~~~ For Moving to Secret2~~~~~~~~~~~~~~~~~~//
-(IBAction)Secretbtn2:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:secretvc2 animated:NO];
}
//~~~~~~~~~~~~~~~~~~~~~~ For Moving to Secret3~~~~~~~~~~~~~~~~~~//
-(IBAction)Secret3:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:secretvc3 animated:NO];
}
//~~~~~~~~~~~~~~~~~~~~~~ For Moving to Secret4~~~~~~~~~~~~~~~~~~//
-(IBAction)Secret4:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:secretvc4 animated:NO];
}
//~~~~~~~~~~~~~~~~~~~~~~ For Moving to Secret5~~~~~~~~~~~~~~~~~~//
-(IBAction)Secret5:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:secretvc5 animated:NO];
}
//~~~~~~~~~~~~~~~~~~~~~~ For Moving to Secret6~~~~~~~~~~~~~~~~~~//
-(IBAction)Secret6:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:secretvc6 animated:NO];
}
//~~~~~~~~~~~~~~~~~~~~~~ For Moving to Secret7~~~~~~~~~~~~~~~~~~//
-(IBAction)Secret7:(id)sender
{
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    // [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    // [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    // [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    
    IswelcomeInit=FALSE;
    
    [welcomeAudioPlayer stop];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:secretvc7 animated:NO];
}
//~~~~~~~~~~~~~~~~~~~~~~ Eng the Coding of Moving and swiping ~~~~~~~~~~~~~~~~~~//

- (void)showHide:(id)sender
{
    if(PopView.hidden==YES)
    {
      [self popupView];
    }
    
   

    MytableView.hidden = YES;
    MytableView = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [enterCouponTxt resignFirstResponder];
    
    return YES;
}
#pragma mark -
#pragma mark UIGestureRecognizerDelegate methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:MytableView]) {
        
        return NO;
    }
    
    return YES;
}


//~~~~~~~~~~~~~~~~~~~~~~ Welcome Audio ~~~~~~~~~~~~~~~~~~~~~~//

-(void)palyWelcomeMusic:(id)sender
{
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"NotPurchased"])
//    {
//        UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"True Secrets" message:@"You Need to Purchase Audio Files. Purchase now?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
//        [PurchaseAlert show];
//        return;
//    }else {
//    if(toggle)
//    { NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Opening_Monologue" ofType:@"mp3" ];
//        NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
//        NSError *error;
//        welcomeAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&error];
//        [welcomeAudioPlayer play];
//        toggle = false;
//        [welcomePlayImage setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
//    }else
//    {
//        [welcomeAudioPlayer stop];
//        [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
//        toggle = true;
//    }
//  //  }
    
    
  //  InAppPurchaseViewController *InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
  //  [self.navigationController pushViewController:InappPurchaseVC animated:YES];
    [welcomePlayImage setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    
    if (welcomePlayImage.tag==2)
    {
        [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [welcomeAudioPlayer pause];
        
        [welcomeAudioPlayer prepareToPlay];
        welcomePlayImage.tag=3;
    }
    else
    {
        
        if (welcomePlayImage.tag==3)
        {
            [welcomeAudioPlayer play];
            welcomePlayImage.tag=2;
        }
        else{
            
            NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"Opening_Monologue"] ofType:@"mp3"]];
            self.welcomeAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            self.welcomeAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            [welcomeAudioPlayer prepareToPlay];
            welcomeAudioPlayer.delegate=self;
            
            [welcomeAudioPlayer play];
            //playing=YES;
            welcomePlayImage.tag=2;
        }
    }
 }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            customViewObj = [[CustomCuponViewController alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
        }else{
            customViewObj = [[CustomCuponViewController alloc]initWithFrame:CGRectMake(0, 0, 320, 700)];
        }
        customViewObj.delegate=self;
        
        [customViewObj addCupon];
    }
    if (alertView.tag == 1) {
        [[NSUserDefaults standardUserDefaults]setObject:@"Purchased" forKey:@"Products"];
        PopView.hidden = YES;
        cancelbtn.hidden = YES;
        [self viewDidLoad];
    }
}
-(void)buttonCallBack:(id)obj
{
   // scrollView.userInteractionEnabled = YES;
    NSDictionary *dict=obj;
    NSLog(@"%@",[dict valueForKey:@"ProductCode"]);
    
    InAppPurchaseViewController *InappPurchaseVC;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
    }else{
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    }
    InappPurchaseVC.productCode = [dict valueForKey:@"ProductCode"];
    
    //InappPurchaseVC.productCode = [dict valueForKey:@"com.Krishnais.TrueSecretsM.TrueSecrets"];
    InappPurchaseVC.couponCode = [dict valueForKey:@"CouponCode"];
    [self.navigationController pushViewController:InappPurchaseVC animated:YES];
}

    //~~~~~~~~~~~~~~~~~~~~~~ Secret View Button Footer~~~~~~~~~~~~~~~~~~~~~~~~~//
    - (void)secretView:(id)sender
    {
        if(MytableView == nil || MytableView.hidden == YES)
        {
            if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
                MytableView = [[UITableView alloc] initWithFrame:CGRectMake(230, 809, 352, 160)];
            }
            else
            {
                CGSize result = [[UIScreen mainScreen]bounds].size ;
            if (result.height == 480)
            {
                MytableView = [[UITableView alloc] initWithFrame:CGRectMake(95, 288, 130, 160)];
            }
                else if(result.height == 568)
                {
                     MytableView = [[UITableView alloc] initWithFrame:CGRectMake(95, 373, 130, 160)];
                }
            }
            MytableView.contentSize = CGSizeMake(105, 200);
            MytableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            MytableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
            MytableView.separatorColor = [UIColor clearColor];
            MytableView.delegate = self;
            MytableView.dataSource = self;
            MytableView.allowsSelection = true;
            //  MytableView.canCancelContentTouches = true;
            MytableView.rowHeight=23;
            // [MytableView setAllowsSelection:YES];
            [self.view addSubview:MytableView];
            tableData = [NSArray arrayWithObjects:@"#1 prostitute",@"#2 dim sims",@"#3 police strike",@"#4 assassins",@"#5 witness",@"#6 telco",@"#7 strip search", nil];
            cancelbtn.hidden = YES;
        }
        else
        {
            NSLog(@"Else");
            [MytableView setHidden:YES];
            MytableView = nil;
        }
    }
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        [PopView removeFromSuperview];
        return [tableData count];
    }
    - (UITableViewCell *)tableView:(UITableView *)TableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            // Create the cell and add the labels
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        else
        {
            UIView *subview;
            while ((subview= [[[cell contentView]subviews]lastObject])!=nil)
                [subview removeFromSuperview];
        }
        
        // cell.backgroundView = [[UIView alloc] init];
        [cell.backgroundView setBackgroundColor:[UIColor clearColor]];
        // [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"DroidSans" size:13.5];
        if ([check_status isEqualToString:@"Purchased"])
        {
        cell.textLabel.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        }else{
            if (indexPath.row == 2) {
                cell.textLabel.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
            }else{
                cell.textLabel.textColor= [UIColor grayColor];
            }
         
        }
        TableView.scrollEnabled = NO;
        cell.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];

        
        return cell;
    }
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        
            
        [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
        ismasterInit=FALSE;isBonusInit=FALSE;isBackgroundInit=FALSE;
        
        bonusValue=FALSE;
        backgroundvalue=FALSE;
        mainPlayValue=FALSE;
        [masterAudioPlayer stop];
        [bgAudioPlayer stop];
        [bonusAudioPlayer stop];
       
        if ([check_status isEqualToString:@"Purchased"])
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [self.navigationController.view.layer addAnimation:transition
                                                        forKey:kCATransition];
            if(indexPath.row==0)
            {
                [self.navigationController pushViewController:secretvc1 animated:NO];
            }else if(indexPath.row==1)
            {
                [self.navigationController pushViewController:secretvc2 animated:NO];
            }else if(indexPath.row==2)
            {
                [self.navigationController pushViewController:secretvc3 animated:NO];
            }else if(indexPath.row==3)
            {
                [self.navigationController pushViewController:secretvc4 animated:NO];
                
            }else if(indexPath.row==4)
            {
                [self.navigationController pushViewController:secretvc5 animated:NO];
                
            }else if(indexPath.row==5)
            {
                [self.navigationController pushViewController:secretvc6 animated:NO];
                
            }else if(indexPath.row==6)
            {
                [self.navigationController pushViewController:secretvc7 animated:NO];
            }
        }else{
            if(indexPath.row==2)
            {
                CATransition *transition = [CATransition animation];
                transition.duration = 0.3;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromRight;
                [self.navigationController.view.layer addAnimation:transition
                                                            forKey:kCATransition];
                [self.navigationController pushViewController:secretvc3 animated:NO];
            }
            else{
               [self popupView];
            }
        }
        [MytableView setHidden:YES];
        MytableView = NULL;
            
            
            
        
    }
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    
   
    //self.welcomeAudioPlayer=nil;
    [welcomePlayImage setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    welcomePlayImage.tag=1;
    [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}
//-(void)showView
//{
//  
//        
//      //scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 580);
////        scrollView.userInteractionEnabled = NO;
//    
//        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
//            PopView = [[UIView alloc]initWithFrame:CGRectMake(90, 200, 580, 435)];
//            PopView.backgroundColor = [UIColor whiteColor];
//            
//            PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
//            PopView.layer.cornerRadius=10;
//            PopView.clipsToBounds=YES;
//            [self.view addSubview: PopView];
//            
//            UILabel *Poplbl =[[UILabel alloc]init];
//            Poplbl.frame = CGRectMake(20, 20, 530, 200);
//            Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
//            Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
//            Poplbl.numberOfLines = 4;
//            [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:32]];
//            [PopView addSubview:Poplbl];
//            
//            UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//            popbtn1.frame = CGRectMake(20, 270, 530, 40);
//            [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
//            popbtn1.titleLabel.numberOfLines=1;
//            [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
//            [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
//            popbtn1.layer.cornerRadius=10;
//            popbtn1.clipsToBounds=YES;
//            [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//            
//            [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//            [PopView addSubview:popbtn1];
//            
//            
//            UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//            popbtn2.frame = CGRectMake(20, 320, 530, 40);
//            [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
//            popbtn2.titleLabel.numberOfLines=1;
//            [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
//            [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
//            popbtn2.layer.cornerRadius=10;
//            popbtn2.clipsToBounds=YES;
//            [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//            
//            [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//            [PopView addSubview:popbtn2];
//            
//            [scrollView bringSubviewToFront:PopView];
//        }else{
//            
//            PopView = [[UIView alloc]initWithFrame:CGRectMake(15, 175, 290, 250)];
//            PopView.backgroundColor = [UIColor whiteColor];
//            
//            PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
//            PopView.layer.cornerRadius=10;
//            PopView.clipsToBounds=YES;
//            [self.view addSubview: PopView];
//            
//            UILabel *Poplbl =[[UILabel alloc]init];
//            Poplbl.frame = CGRectMake(15, 15, 275, 125);
//            Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
//            
//            Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
//            Poplbl.numberOfLines = 4;
//            [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:21]];
//            [PopView addSubview:Poplbl];
//            
//            UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//            popbtn1.frame = CGRectMake(15, 155, 260, 30);
//            [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
//            popbtn1.titleLabel.numberOfLines=1;
//            [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
//            [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
//            popbtn1.layer.cornerRadius=10;
//            popbtn1.clipsToBounds=YES;
//            [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//            
//            [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//            [PopView addSubview:popbtn1];
//            
//            
//            UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//            popbtn2.frame = CGRectMake(15, 200, 260, 30);
//            [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
//            popbtn2.titleLabel.numberOfLines=1;
//            [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
//            [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
//            popbtn2.layer.cornerRadius=10;
//            popbtn2.clipsToBounds=YES;
//            [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//            
//            [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//            [PopView addSubview:popbtn2];
//            
//            [scrollView bringSubviewToFront:PopView];
//        }
//        //    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"NotPurchased"])
//        //    {
//        //        UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"To experience the full True Secrets tour you need to purchase acess to the audio files" message:@"Purchase now?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
//        //        [PurchaseAlert show];
//        //        return;
//        //    }
//            
//        
//    }
//
//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)applyCoupon:(id)sender {
//    [enterCouponTxt resignFirstResponder];
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//
//    NSString *coupontxt = [NSString stringWithFormat:@"%@",enterCouponTxt.text];
//    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
//    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
//    
//    UIDevice *device = [UIDevice currentDevice];
//    NSString *uniqueIdentifier = (NSString *)[device identifierForVendor];
//    
//    NSString *username=@"ts_coupongetter";
//    NSString *password=@"6X&z7ub^bzqiPJuLcu";
//    NSString *mobile=@"1234567890";
//    NSString *action=@"checkcoupon";
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://rupinderkarala.com/webservice/webservice.php"]];
////   NSXMLParser *request = [[NSXMLParser alloc] initWithContentsOfURL:url];
////    [request setValue:username forKey:@"username"];
////    [request setValue:password  forKey:@"password"];
////    [request setValue:uniqueIdentifier forKey:@"IMEI"];
////    [request setValue:mobile forKey:@"Mobile"];
////    [request setValue:action forKey:@"action"];
////    [request setValue:name forKey:@"name"];
////    [request setValue:email forKey:@"email"];
////    [request setValue:coupontxt forKey:@"coupon_code"];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:username forKey:@"username"];
//    [request setPostValue:password forKey:@"password"];
//    [request setPostValue:uniqueIdentifier forKey:@"IMEI"];
//    [request setPostValue:mobile forKey:@"Mobile"];
//    [request setPostValue:action forKey:@"action"];
//    [request setPostValue:name forKey:@"name"];
//    [request setPostValue:email forKey:@"email"];
//    [request setPostValue:coupontxt forKey:@"coupon_code"];
//    [request setRequestMethod:@"POST"];
//    [request setDelegate:self];
//    [request startAsynchronous];
//}
//
//- (IBAction)contiueWithoutCoupon:(id)sender {
//    
//    [self.view setUserInteractionEnabled:NO];
//    
//    [enterCouponTxt resignFirstResponder];
//    couponView.hidden = YES;
//    [scrollView setUserInteractionEnabled:YES];
//    InAppPurchaseViewController *InappPurchaseVC;
//    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
//        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
//    }else{
//    InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
//    }
//    InappPurchaseVC.productCode = productCode;
//    [self.navigationController pushViewController:InappPurchaseVC animated:YES];
//}
//
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    // Use when fetching text data
//    NSString *responseString = [request responseString];
//   // NSXMLParser *parser=[[NSXMLParser alloc] init];
//   // [parser setDelegate:self];
//    NSLog(@"res of webservice 2:%@",responseString);
//    enterCouponTxt.text = @"";
//    // Use when fetching binary data
//    //NSData *responseData = [request responseData];
//    
//    NSData *responseData = [request responseData];
//    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: responseData];
//    [xmlParser setDelegate:self];
//    [xmlParser setShouldResolveExternalEntities:YES];
//    [xmlParser parse];
//
//}
//
//
//-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI
// qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict
//
//{
//    if ([elementName isEqualToString:@"coupon_code"])
//    {
//
//            tempString = [[NSMutableString alloc] init];
//        
//    }else if ([elementName isEqualToString:@"expired"])
//    {
//            tempString = [[NSMutableString alloc] init];
//    }else if ([elementName isEqualToString:@"used"])
//    {
//        tempString = [[NSMutableString alloc] init];
//    
//    }else if ([elementName isEqualToString:@"product_code"])
//    {
//                    tempString = [[NSMutableString alloc] init];
//        
//    }else if ([elementName isEqualToString:@"status"])
//    {
//            tempString = [[NSMutableString alloc] init];
//    }else if ([elementName isEqualToString:@"username"])
//    {
//            tempString = [[NSMutableString alloc] init];
//    }
//}
////---when the text in an element is found---
//-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
//{
//    [tempString appendString:string];
//}
////---when the end of element is found---
//-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
// namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//
//     if ([elementName isEqualToString:@"expired"]){
//        couponExpire =  [NSString stringWithFormat:@"%@", tempString];
//         couponExpire = [couponExpire stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if ([couponExpire isEqualToString: @"true"]) {
//            isCouponExpired = YES;
//        }else{
//            isCouponExpired = NO;
//        }
//    }else if ([elementName isEqualToString:@"used"]){
//        couponUsed = [NSString stringWithFormat:@"%@", tempString];
//        couponUsed = [couponUsed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];        if ([couponUsed isEqualToString:@"true"]) {
//            isCouponUsed = YES;
//        }else{
//            isCouponUsed = NO;
//        }
//    }else if ([elementName isEqualToString:@"product_code"]){
//        productCode = [NSString stringWithFormat:@"%@", tempString];
//        productCode = [productCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    }
//    else if ([elementName isEqualToString:@"status"]){
//        couponStatus = [NSString stringWithFormat:@"%@", tempString];
//        couponStatus = [couponStatus stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if ([couponStatus isEqualToString:@"success"]) {
//            if (!(isCouponExpired) && !(isCouponUsed)) {
//                InAppPurchaseViewController *InappPurchaseVC;
//                if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
//                    InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
//                }else{
//                    InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
//                }
//                InappPurchaseVC.productCode = productCode;
//                [self.navigationController pushViewController:InappPurchaseVC animated:YES];
//                couponView.hidden = YES;
//                [scrollView setUserInteractionEnabled:YES];
//            }
//        }else{
//            //couponView.hidden = YES;
//            UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"Invalid  Coupon" message:@"Please confirm the coupon or Continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [PurchaseAlert show];
//        }
//    }
//}
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self popupView];
    MytableView.hidden = YES;
    MytableView = nil;
}
-(void) popupView
{
    InAppPurchaseViewController *InappPurchaseVC;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
    }else{
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    }
    
  InappPurchaseVC.fromWelcome = @"yes";
    InappPurchaseVC.productCode = [NSString stringWithFormat:@"TS_1900"];
    [self.navigationController pushViewController:InappPurchaseVC animated:YES];

    
    
//    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
//        
//        PopView = [[UIView alloc]initWithFrame:CGRectMake(90, 200, 580, 435)];
//        PopView.backgroundColor = [UIColor whiteColor];
//        
//        PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
//        PopView.layer.cornerRadius=10;
//        PopView.clipsToBounds=YES;
//        [self.view addSubview: PopView];
//        
//        cancelbtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        cancelbtn.frame = CGRectMake(0, 0, 64, 64);
//        [cancelbtn addTarget:self action:@selector(cancelbtnaction:) forControlEvents:UIControlEventTouchUpInside];
//        [cancelbtn setBackgroundColor:[UIColor blackColor]];
//        [cancelbtn setImage:[UIImage imageNamed:@"cancel-button-icon.png"] forState:UIControlStateNormal];
//        [PopView addSubview:cancelbtn];
//        
//        UILabel *Poplbl =[[UILabel alloc]init];
//        Poplbl.frame = CGRectMake(20, 20, 530, 200);
//        Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
//        Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
//        Poplbl.numberOfLines = 4;
//        [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:32]];
//        [PopView addSubview:Poplbl];
//        
//        UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//        popbtn1.frame = CGRectMake(20, 270, 530, 40);
//        [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
//        popbtn1.titleLabel.numberOfLines=1;
//        [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
//        [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
//        popbtn1.layer.cornerRadius=10;
//        popbtn1.clipsToBounds=YES;
//        [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//        
//        [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//        [PopView addSubview:popbtn1];
//        
//        
//        UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//        popbtn2.frame = CGRectMake(20, 320, 530, 40);
//        [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
//        popbtn2.titleLabel.numberOfLines=1;
//        [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
//        [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
//        popbtn2.layer.cornerRadius=10;
//        popbtn2.clipsToBounds=YES;
//        [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//        
//        [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//        [PopView addSubview:popbtn2];
//        
//        
//        UIButton* popbtn3 =[UIButton buttonWithType:UIButtonTypeCustom];
//        popbtn3.frame = CGRectMake(15, 370, 260, 30);
//        [popbtn3 setTitle:@"I already own the app?" forState:UIControlStateNormal];
//        popbtn3.titleLabel.numberOfLines=1;
//        [[popbtn3 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:26]];
//        [popbtn3 addTarget:self action:@selector(popbtnaction3:) forControlEvents:UIControlEventTouchUpInside];
//        popbtn3.layer.cornerRadius=10;
//        popbtn3.clipsToBounds=YES;
//        [popbtn3 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//        [popbtn3 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//        
//        [PopView addSubview:popbtn3];
//        
//        
//        [scrollView bringSubviewToFront:PopView];
//    }else{
//        
//        PopView = [[UIView alloc]initWithFrame:CGRectMake(15, 170, 290, 260)];
//        PopView.backgroundColor = [UIColor whiteColor];
//        
//        PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
//        PopView.layer.cornerRadius=10;
//        PopView.clipsToBounds=YES;
//        [self.view addSubview:PopView];
//        
//        cancelbtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        cancelbtn.frame = CGRectMake(290, 152, 32, 32);
//        [cancelbtn addTarget:self action:@selector(cancelbtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cancelbtn setBackgroundColor:[UIColor clearColor]];
//        [cancelbtn setImage:[UIImage imageNamed:@"cancel-button-icon.png"] forState:UIControlStateNormal];
//        [self.view addSubview:cancelbtn];
//        
//        UILabel *Poplbl =[[UILabel alloc]init];
//        Poplbl.frame = CGRectMake(15, 15, 275, 125);
//        Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
//        
//        Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
//        Poplbl.numberOfLines = 4;
//        [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:21]];
//        [PopView addSubview:Poplbl];
//        
//        UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//        popbtn1.frame = CGRectMake(15, 150, 260, 30);
//        [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
//        popbtn1.titleLabel.numberOfLines=1;
//        [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
//        [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
//        popbtn1.layer.cornerRadius=10;
//        popbtn1.clipsToBounds=YES;
//        [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//        
//        [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//        [PopView addSubview:popbtn1];
//        
//        
//        UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//        popbtn2.frame = CGRectMake(15, 185, 260, 30);
//        [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
//        popbtn2.titleLabel.numberOfLines=1;
//        [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
//        [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
//        popbtn2.layer.cornerRadius=10;
//        popbtn2.clipsToBounds=YES;
//        [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//        
//        [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//        [PopView addSubview:popbtn2];
//        
//        UIButton* popbtn3 =[UIButton buttonWithType:UIButtonTypeCustom];
//        popbtn3.frame = CGRectMake(15, 220, 260, 30);
//        [popbtn3 setTitle:@"I already own the app?" forState:UIControlStateNormal];
//        popbtn3.titleLabel.numberOfLines=1;
//        [[popbtn3 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:19]];
//        [popbtn3 addTarget:self action:@selector(popbtnaction3:) forControlEvents:UIControlEventTouchUpInside];
//        popbtn3.layer.cornerRadius=10;
//        popbtn3.clipsToBounds=YES;
//        [popbtn3 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//        [popbtn3 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//        popbtn3.tag=1;
//        
//        [PopView addSubview:popbtn3];
//        
//        scrollView.userInteractionEnabled = YES;
//        
//        [scrollView bringSubviewToFront:PopView];
//        
//        
//        
//        
//    }
}

-(IBAction)cancelbtnAction:(id)sender
{
  scrollView.userInteractionEnabled = YES;
    [PopView removeFromSuperview];
    cancelbtn.hidden = YES;
}
-(IBAction)popbtnaction1:(id)sender
{
    cancelbtn.hidden = YES;
    scrollView.userInteractionEnabled = YES;
    
    [PopView removeFromSuperview];
        //scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollviewheight);
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        customViewObj = [[CustomCuponViewController alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    }else{
        customViewObj = [[CustomCuponViewController alloc]initWithFrame:CGRectMake(0, 0, 320, 700)];
    }
    customViewObj.delegate=self;
    
    [customViewObj addCupon];
    
    return;
}
-(IBAction)popbtnaction2:(id)sender
{
    //scrollView.userInteractionEnabled = YES;
    

    [PopView removeFromSuperview];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollviewheight);
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:@"TS1901" forKey:@"ProductCode"];
    //  NSDictionary *dict=[NSDictionary dictionaryWithObject:@"1" forKey:@"Key"];
//    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(buttonCallBack:)]) {
//        [self.delegate performSelector:@selector(buttonCallBack:) withObject:dict];
//    }
    [self buttonCallBack:dict];
    //scrollView.userInteractionEnabled = YES;
}
-(IBAction)popbtnaction3:(id)sender
{
    DisableView.hidden = NO;
    //[self.view addSubview:DisableView];
    [self.view bringSubviewToFront:DisableView];
    [indicator startAnimating];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    
    
    [DisableView bringSubviewToFront:self.view];
    [DisableView removeFromSuperview];
    DisableView.hidden = YES;
    [indicator stopAnimating];
    
    NSLog(@"received restored transactions: %i", queue.transactions.count);
    if (queue.transactions.count == 0) {
        NSString *str=@"You do not owned this app sorry.";
        UIButton *buttonThree = (UIButton *)[PopView viewWithTag:1];
        [buttonThree setTitle:str forState:UIControlStateNormal];
        [buttonThree setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [buttonThree setBackgroundColor:[UIColor clearColor]];
        
    }else{
        for(SKPaymentTransaction *transaction in queue.transactions){
            if(transaction.transactionState == SKPaymentTransactionStateRestored){
                //called when the user successfully restores a purchase
                NSLog(@"Restore Successful");
                [[NSUserDefaults standardUserDefaults] setValue:@"Purchased" forKey:@"Products"];
                [self viewDidLoad];
                [PopView removeFromSuperview];
                cancelbtn.hidden = YES;
            }
            
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code == SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    if ([error.domain isEqual:SKErrorDomain] && error.code == SKErrorPaymentCancelled)
    {
        return;
    }
    
    [DisableView removeFromSuperview];
    DisableView.hidden= YES;
    
    
    NSString *str=@"You do not owned this app sorry.";
    UIButton *buttonThree = (UIButton *)[PopView viewWithTag:1];
    [buttonThree setTitle:str forState:UIControlStateNormal];
    [buttonThree setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonThree setBackgroundColor:[UIColor clearColor]];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"There are no items available to restore at this time.", @"")
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                          otherButtonTitles:nil];
    [alert show];
}


//
//-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
//{
//    NSLog(@"%lu items restored", (unsigned long)queue.transactions.count);
//    
//    NSString*Str=[NSString stringWithFormat:@"%lu",(unsigned long)queue.transactions.count];
//    
//    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
//    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
//    if (receipt) {
//        
//        // [Delegate transactionDidRestorePurchaseSuccessfullyWithReciept:receipt];
//    }
//    else{
//        // [Delegate transactionDidFail];
//    } int count = 0;
//    for (SKPaymentTransaction *transaction in queue.transactions)
//    {
//        
//        NSString *productID = transaction.payment.productIdentifier;
//        if (transaction.transactionState == 3   ) {
//            count++;
//        }
//         NSLog(@"items restored %ld", (long)transaction.transactionState);
//    }
//    if (count > 0) {
//        NSLog(@"Restore Successful");
//    }else{
//        NSString *str=@"You do not owned this app sorry.";
//        UIButton *buttonThree = (UIButton *)[PopView viewWithTag:1];
//        [buttonThree setTitle:str forState:UIControlStateNormal];
//        [buttonThree setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [buttonThree setBackgroundColor:[UIColor clearColor]];
//
//    }
//}
//
//- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
//{
//    if ([error.domain isEqual:SKErrorDomain] && error.code == SKErrorPaymentCancelled)
//    {
//        return;
//    }
//    
//    NSString *str=@"You do not owned this app sorry.";
//    UIButton *buttonThree = (UIButton *)[PopView viewWithTag:1];
//    [buttonThree setTitle:str forState:UIControlStateNormal];
//    [buttonThree setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [buttonThree setBackgroundColor:[UIColor clearColor]];
//    
//
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"There are no items available to restore at this time.", @"")
//                                                    message:nil
//                                                   delegate:nil
//                                          cancelButtonTitle:NSLocalizedString(@"OK", @"")
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
//
//
////Then this delegate Function Will be fired
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
//    
//    for (SKPaymentTransaction *transaction in transactions) {
//        switch (transaction.transactionState) {
//            case SKPaymentTransactionStatePurchased: {
//                // user has purchased
//                //                [self saveTransactionReceipt:transaction];
//                //                [self unlockFullVersion];
//                // download content here if necessary
//                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
//                break;
//            }
//                
//            case SKPaymentTransactionStateFailed: {
//                // transaction didn't work
//                NSLog(@"failed restore");
//                // [self displayAlertViewWithMessage:@"There was a problem with your purchase. Please try again later."];
//                break;
//            }
//                
//            case SKPaymentTransactionStateRestored: {
//                // purchase has been restored
//                [self displayAlertViewWithMessage:@"Successfully restored your purchase"];
//                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
//                break;
//            }
//                
//                
//            case SKPaymentTransactionStatePurchasing: {
//                // currently purchasing
//                break;
//            }
//                
//            default:
//                break;
//        }
//    }
//}

- (void)displayAlertViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
}


//
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
//...
//
//[[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
//
//...
//}
//
//#pragma mark completed Transactions call back
//- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
//    ...
//    
//    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
//    
//    ...
//}
//- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
//    ...
//    
//    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
//    
//    ...
//}
//- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions{
//    ...
//    
//    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
//    
//    ...
//}

@end
