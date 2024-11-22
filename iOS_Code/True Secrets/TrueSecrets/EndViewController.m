//
//  EndViewController.m
//  TrueSecretsMelbourne
//
//  Created by Krishna_Mac on 9/11/13.
//  Copyright (c) 2013 whatwasthat. All rights reserved.
//

#import "EndViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCuponViewController.h"
#import "InAppPurchaseViewController.h"
//#import "Reachability.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"

@interface EndViewController ()

@end

@implementation EndViewController
@synthesize scrollView,aboutView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showHide:(id)sender
{
    
    MytableView.hidden = YES;
    
}

- (void)viewDidLoad
{
    
   
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        emailForm = [[UIView alloc] initWithFrame:CGRectMake(35, 606, 210, 188)];
    }else{
        emailForm = [[UIView alloc] initWithFrame:CGRectMake(25, 606, 210, 188)];
    }
    //CustomCuponViewController *customViewObj;
    MytableView = NULL;
    webserviceCode = 0;
    
    bool_showCoupon = TRUE;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setBackgroundColor:[UIColor blackColor]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide:)];
        
        
        tap.delegate=self;
        tap.cancelsTouchesInView = NO;
        tap.numberOfTapsRequired = 1;
        
        self.view.userInteractionEnabled = YES;
        [self.view addGestureRecognizer:tap];
        
        //scrollView.bounces = NO;
        
        
        [scrollView setContentSize: CGSizeMake(768 , 1024)];
        //[scrollView setContentOffset:scrollView.contentOffset animated:YES];
        
//        UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1200)];
//        backgroundImg.image = [UIImage imageNamed:@"bgfinal.png"];
//        [scrollView addSubview:backgroundImg];
        UIView *imageViewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 30)];
        UIImageView* backgroundImgNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 30)];
        backgroundImgNew.image = [UIImage imageNamed:@"navigation.png"];
        [imageViewTop addSubview:backgroundImgNew];
        imageViewTop.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:imageViewTop];
        
        UIImageView *logoImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(278, 30, 250, 50)];
        logoImage2.image = [UIImage imageNamed:@"logo1.png"];
        [scrollView addSubview:logoImage2];
        
        
        
        UILabel *aboutCastText = [[UILabel alloc] initWithFrame: CGRectMake(25, 75, 250, 40)];
        [aboutCastText setTextColor: [UIColor whiteColor]] ;
        [aboutCastText setBackgroundColor:[UIColor clearColor]];
        aboutCastText.font = [UIFont fontWithName:@"Helvetica" size:22];
        aboutCastText.numberOfLines = 1;
        aboutCastText.text = @"Cast & Credits";
        [scrollView addSubview:aboutCastText];
        
        UILabel *aboutCastDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(25, 92, 500, 220)];
        [aboutCastDetailsText setTextColor: [UIColor whiteColor]] ;
        [aboutCastDetailsText setBackgroundColor:[UIColor clearColor]];
        aboutCastDetailsText.font = [UIFont fontWithName:@"Helvetica" size:13];
        aboutCastDetailsText.numberOfLines = 25;
        aboutCastDetailsText.text = @"These plays were created by: John Paul Fischbach Scripts written and developed by Robert Reid.\nDirection by JohnPaul Fischbach Music composed by David James NielsenAudio mixed, mastered and foley by Greg O'Shea.\nThe Acting company included: Sean Barker Mick Cahill, Grant Cartwright, Joanna Fripp, Yi Jin, Rosemary Johns, Christopher Pang, Robert Reid.\nThe narrator was Brian Lighfoot.\nArticle Archive pictures used with permission of Herald and Weekly Times (HWT).\nPromotional stills source: shutterstock, istockphoto, John Paul Fischbach, Craig Lambie.\nApp developed by Craig Lambie of What Was That Pty Ltd.";
        [scrollView addSubview:aboutCastDetailsText];
        
        UILabel *disclaimerText = [[UILabel alloc] initWithFrame: CGRectMake(25, 300, 130, 40)];
        [disclaimerText setTextColor: [UIColor whiteColor]] ;
        [disclaimerText setBackgroundColor:[UIColor clearColor]];
        disclaimerText.font = [UIFont fontWithName:@"Helvetica" size:22];
        disclaimerText.numberOfLines = 1;
        disclaimerText.text = @"Disclaimer";
        [scrollView addSubview:disclaimerText];
        
        UILabel *disclaimerDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(25, 300, 500, 100)];
        [disclaimerDetailsText setTextColor: [UIColor whiteColor]] ;
        [disclaimerDetailsText setBackgroundColor:[UIColor clearColor]];
        disclaimerDetailsText.font = [UIFont fontWithName:@"Helvetica" size:11];
        disclaimerDetailsText.numberOfLines = 3;
        disclaimerDetailsText.text = @"There works of fiction are based on some historical facts of Melboume and some urban myths. This Melboume tour is intended for entertainment purposes.";
        [scrollView addSubview:disclaimerDetailsText];
        
        
        
        
        
        UILabel *infoText = [[UILabel alloc] initWithFrame: CGRectMake(25, 370, 530, 40)];
        [infoText setTextColor: [UIColor whiteColor]] ;
        [infoText setBackgroundColor:[UIColor clearColor]];
        infoText.font = [UIFont fontWithName:@"Helvetica" size:22];
        infoText.numberOfLines = 1;
        infoText.text = @"Info";
        [scrollView addSubview:infoText];
        
        UILabel *infoDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(25, 365, 500, 100)];
        [infoDetailsText setTextColor: [UIColor whiteColor]] ;
        [infoDetailsText setBackgroundColor:[UIColor clearColor]];
        infoDetailsText.font = [UIFont fontWithName:@"Helvetica" size:13];
        infoDetailsText.numberOfLines = 2;
        infoDetailsText.text = @"Tour takes approx. 2 hours (depending on your walking speed)";
        [scrollView addSubview:infoDetailsText];
        
        UILabel *anyProblemText = [[UILabel alloc] initWithFrame: CGRectMake(25, 430, 380, 50)];
        [anyProblemText setTextColor: [UIColor whiteColor]] ;
        [anyProblemText setBackgroundColor:[UIColor clearColor]];
        anyProblemText.font = [UIFont fontWithName:@"Helvetica" size:22];
        anyProblemText.numberOfLines = 1;
        anyProblemText.text = @"Any problems?";
        [scrollView addSubview:anyProblemText];
        
        UILabel *anyProblemDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(25, 430, 500, 150)];
        [anyProblemDetailsText setTextColor: [UIColor whiteColor]] ;
        [anyProblemDetailsText setBackgroundColor:[UIColor clearColor]];
        anyProblemDetailsText.font = [UIFont fontWithName:@"Helvetica" size:13];
        anyProblemDetailsText.numberOfLines = 10;
        anyProblemDetailsText.text = @"Please call our support team on (03) 8256 9621\nWe can be contacted on\ninfo@truesecrets.com.au\nWe can be found at 228 Bank St, South Melbourne VIC 3205 ABN: 81 071 070 474";
        [scrollView addSubview:anyProblemDetailsText];
        
        aboutView=[[UIView alloc]initWithFrame:CGRectMake(25, 600, 720, 200)];
        aboutView.layer.cornerRadius = 10;
        aboutView.layer.masksToBounds = YES;
        //aboutView.layer.borderWidth=2;
        aboutView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        [scrollView addSubview:aboutView];
        
        
        btn_cuppon=[[UIButton alloc]initWithFrame:CGRectMake(150, 560, 595, 25)];
        [btn_cuppon setTitle:@"                                                                                 get friend coupon" forState:UIControlStateNormal];
        btn_cuppon.layer.cornerRadius=10;
        btn_cuppon.clipsToBounds=YES;
        mapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn_cuppon addTarget:self action:@selector(getCoupon:) forControlEvents:UIControlEventTouchUpInside];
        //btn_cuppon.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [btn_cuppon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [btn_cuppon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btn_cuppon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
        
        //btn_cuppon.tintColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        
        btn_cuppon.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
       // [scrollView addSubview:btn_cuppon];
        
        btn_signUp_temp = [[UIButton alloc]initWithFrame:CGRectMake(150, 591, 595, 25)];
        [btn_signUp_temp setTitle:@"                                                                        sign up to email list" forState:UIControlStateNormal];
        btn_signUp_temp.layer.cornerRadius=10;
        btn_signUp_temp.clipsToBounds=YES;
        btn_signUp_temp.hidden = YES;
        [btn_signUp_temp addTarget:self action:@selector(showEmailLayout:) forControlEvents:UIControlEventTouchUpInside];
        btn_signUp_temp.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        //btn_signUp_temp.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        
        [btn_signUp_temp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [btn_signUp_temp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btn_signUp_temp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
        
        [scrollView addSubview:btn_signUp_temp];
        
        
        btn_clickCoupon=[[UIButton alloc]initWithFrame:CGRectMake(50, 620, 680, 25)];
        [btn_clickCoupon setTitle:@"click to get up to date coupon" forState:UIControlStateNormal];
        btn_clickCoupon.layer.cornerRadius=10;
        btn_clickCoupon.clipsToBounds=YES;
        [btn_clickCoupon addTarget:self action:@selector(getCoupon1:) forControlEvents:UIControlEventTouchUpInside];
        //btn_clickCoupon.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [btn_clickCoupon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [btn_clickCoupon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btn_clickCoupon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
        
        btn_clickCoupon.tag=1;
        btn_clickCoupon.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        //[scrollView addSubview:btn_clickCoupon];
        
        textView=[[UILabel alloc]initWithFrame:CGRectMake(50, 650, 550, 100)];
        
        [textView setText:@""];
        textView.textColor=[UIColor whiteColor];
        textView.font=[UIFont fontWithName:@"DroidSans" size:15];
        textView.hidden=YES;
        textView.numberOfLines = 6;
        textView.backgroundColor=[UIColor clearColor];
        [scrollView addSubview:textView];
        
        
        couponText=[[UILabel alloc]initWithFrame:CGRectMake(50, 650, 250, 100)];
        
        [couponText setText:@""];
        couponText.textColor=[UIColor whiteColor];
        couponText.font=[UIFont fontWithName:@"DroidSans" size:15];
        couponText.hidden=NO;
        couponText.numberOfLines = 6;
        couponText.backgroundColor=[UIColor clearColor];
        [scrollView addSubview:couponText];
        
        emailView=[[UIView alloc]initWithFrame:CGRectMake(25, 631, 720, 200)];
        emailView.layer.cornerRadius = 10;
        emailView.layer.masksToBounds = YES;
        emailView.hidden = YES;
        emailView.layer.borderWidth=2;
        emailView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        [scrollView addSubview:emailView];
        
        
        btn_signUp=[[UIButton alloc]initWithFrame:CGRectMake(150, 805, 595, 25)];
        [btn_signUp setTitle:@"                                                                             sign up to email list" forState:UIControlStateNormal];
        btn_signUp.layer.cornerRadius=10;
        btn_signUp.clipsToBounds=YES;
        [btn_signUp addTarget:self action:@selector(showEmailLayout:) forControlEvents:UIControlEventTouchUpInside];
        btn_signUp.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        //btn_signUp.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [btn_signUp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [btn_signUp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btn_signUp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
        
        [scrollView addSubview:btn_signUp];
        
        _lbl_Heading = [[UILabel alloc]initWithFrame:CGRectMake(50, 638, 550, 25)];
        _lbl_Heading.text=@"";
        _lbl_Heading.textColor=[UIColor whiteColor];
        _lbl_Heading.font=[UIFont fontWithName:@"DroidSans" size:15];
        _lbl_Heading.hidden=NO;
        _lbl_Heading.backgroundColor=[UIColor clearColor];
        [scrollView addSubview:_lbl_Heading];
        
        lbl_Name=[[UILabel alloc]initWithFrame:CGRectMake(50, 661, 550, 25)];
        lbl_Name.text=@"Name";
        lbl_Name.textColor=[UIColor whiteColor];
        lbl_Name.font=[UIFont fontWithName:@"DroidSans" size:14];
        lbl_Name.hidden=YES;
        lbl_Name.backgroundColor=[UIColor clearColor];
        [scrollView addSubview:lbl_Name];
        // [aboutView addSubview:lbl_Name];
        
        text_Name=[[UITextField alloc]initWithFrame:CGRectMake(50, 690, 550, 25)];
        text_Name.placeholder=@"  Enter Your Name";
        text_Name.delegate=self;
        text_Name.backgroundColor=[UIColor whiteColor];
        //self.text_Name.delegate=self;
        text_Name.borderStyle=UITextBorderStyleRoundedRect;
        text_Name.hidden=YES;
        text_Name.text=@"";
        [scrollView addSubview: text_Name];
        //[aboutView addSubview:text_Name];
        
        text_Password=[[UITextField alloc]initWithFrame:CGRectMake(50, 756, 550, 25)];
        text_Password.placeholder=@"  Enter Your Mail Id";
        text_Password.delegate=self;
        text_Password.backgroundColor=[UIColor whiteColor];
        text_Password.secureTextEntry=NO;
        text_Password.hidden=YES;
        text_Password.borderStyle=UITextBorderStyleRoundedRect;
        text_Password.text=@"";
        
        [scrollView addSubview: text_Password];
        //[aboutView addSubview:text_Password];
        
        
        
        
        lbl_password=[[UILabel alloc]initWithFrame:CGRectMake(50, 726, 550, 25)];
        lbl_password.text=@"Email Id";
        lbl_password.textColor=[UIColor whiteColor];
        lbl_password.backgroundColor=[UIColor clearColor];
        lbl_password.font=[UIFont fontWithName:@"DroidSans" size:14];
        lbl_password.hidden=YES;
        
        [scrollView addSubview:lbl_password];
        //[aboutView addSubview:lbl_password];
        
        
        
        btn_submit=[[UIButton alloc]initWithFrame:CGRectMake(570, 796, 100, 25)];
        [btn_submit setTitle:@"Submit" forState:UIControlStateNormal];
        btn_submit.layer.cornerRadius=10;
        btn_submit.clipsToBounds=YES;
        [btn_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        btn_submit.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        //btn_submit.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [btn_submit setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [btn_submit setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btn_submit setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
        
        btn_submit.hidden=YES;
        [scrollView addSubview:btn_submit];
        
        //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
        
        UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // [homeViewButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
        homeViewButton.frame = CGRectMake(0, 969, 270, 35);
        [homeViewButton setTitle:@"home" forState:UIControlStateNormal];
        homeViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
        [homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
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
        //[aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aboutViewButton];

        
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        
       
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRight:)];
        [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight )];
        [scrollView addGestureRecognizer:swipeRight];
        
        welcome = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
        secretvc1 = [[Secret1ViewController alloc]initWithNibName:@"Secret1ViewController" bundle:nil];
        secretvc2 = [[Secret2ViewController alloc]initWithNibName:@"Secret2ViewController" bundle:nil];
        secretvc3 = [[Secret3ViewController alloc]initWithNibName:@"Secret3ViewController" bundle:nil];
        secretvc4 = [[Secret4ViewController alloc]initWithNibName:@"Secret4ViewController" bundle:nil];
        secretvc5 = [[Secret5ViewController alloc]initWithNibName:@"Secret5ViewController" bundle:nil];
        secretvc6 = [[Secret6ViewController alloc]initWithNibName:@"Secret6ViewController" bundle:nil];
        secretvc7 = [[Secret7ViewController alloc]initWithNibName:@"Secret7ViewController" bundle:nil];
        endvc = [[EndViewController alloc]initWithNibName:@"EndViewController" bundle:nil];
        

    }
    else
    {
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
     [scrollView setBackgroundColor:[UIColor blackColor]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide:)];
    
    
    tap.delegate=self;
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];

    //scrollView.bounces = NO;
    
	
    [scrollView setContentSize: CGSizeMake(320 , 900)];
	//[scrollView setContentOffset:scrollView.contentOffset animated:YES];
    
//    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 900)];
//    backgroundImg.image = [UIImage imageNamed:@"bgfinal.png"];
//    [scrollView addSubview:backgroundImg];
        UIView *imageViewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        UIImageView* backgroundImgNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        backgroundImgNew.image = [UIImage imageNamed:@"navigation.png"];
        [imageViewTop addSubview:backgroundImgNew];
        imageViewTop.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:imageViewTop];
        
    UIImageView *logoImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(28, 30, 250, 50)];
    logoImage2.image = [UIImage imageNamed:@"logo1.png"];
    [scrollView addSubview:logoImage2];
    
    
    
    UILabel *aboutCastText = [[UILabel alloc] initWithFrame: CGRectMake(8, 75, 250, 40)];
    [aboutCastText setTextColor: [UIColor whiteColor]] ;
    [aboutCastText setBackgroundColor:[UIColor clearColor]];
    aboutCastText.font = [UIFont fontWithName:@"Helvetica" size:18];
    aboutCastText.numberOfLines = 1;
    aboutCastText.text = @"Cast & Credits";
    [scrollView addSubview:aboutCastText];
    
    UILabel *aboutCastDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(8, 92, 330, 220)];
    [aboutCastDetailsText setTextColor: [UIColor whiteColor]] ;
    [aboutCastDetailsText setBackgroundColor:[UIColor clearColor]];
    aboutCastDetailsText.font = [UIFont fontWithName:@"Helvetica" size:11];
    aboutCastDetailsText.numberOfLines = 20;
    aboutCastDetailsText.text = @"These plays were created by: John Paul Fischbach\nScripts written and developed by Robert Reid.\nDirection by JohnPaul Fischbach\nMusic composed by David James Nielsen\nAudio mixed, mastered and foley by Greg O'Shea.\nThe Acting company included: Sean Barker Mick Cahill, Grant Cartwright, Joanna Fripp, Yi Jin, Rosemary Johns, Christopher Pang, Robert Reid.\nThe narrator was Brian Lighfoot.\nArticle Archive pictures used with permission of Herald and Weekly Times (HWT).\nPromotional stills source: shutterstock, istockphoto, John Paul Fischbach, Craig Lambie.\nApp developed by Craig Lambie of What Was That Pty Ltd.";
    [scrollView addSubview:aboutCastDetailsText];
    
    UILabel *disclaimerText = [[UILabel alloc] initWithFrame: CGRectMake(8, 300, 130, 40)];
    [disclaimerText setTextColor: [UIColor whiteColor]] ;
    [disclaimerText setBackgroundColor:[UIColor clearColor]];
    disclaimerText.font = [UIFont fontWithName:@"Helvetica" size:18];
    disclaimerText.numberOfLines = 1;
    disclaimerText.text = @"Disclaimer";
    [scrollView addSubview:disclaimerText];
    
    UILabel *disclaimerDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(8, 300, 300, 100)];
    [disclaimerDetailsText setTextColor: [UIColor whiteColor]] ;
    [disclaimerDetailsText setBackgroundColor:[UIColor clearColor]];
    disclaimerDetailsText.font = [UIFont fontWithName:@"Helvetica" size:11];
    disclaimerDetailsText.numberOfLines = 3;
    disclaimerDetailsText.text = @"There works of fiction are based on some historical facts of Melboume and some urban myths. This Melboume tour is intended for entertainment purposes.";
    [scrollView addSubview:disclaimerDetailsText];
    
    
    
    
    
    UILabel *infoText = [[UILabel alloc] initWithFrame: CGRectMake(8, 370, 130, 40)];
    [infoText setTextColor: [UIColor whiteColor]] ;
    [infoText setBackgroundColor:[UIColor clearColor]];
    infoText.font = [UIFont fontWithName:@"Helvetica" size:18];
    infoText.numberOfLines = 1;
    infoText.text = @"Info";
    [scrollView addSubview:infoText];
    
    UILabel *infoDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(8, 365, 300, 100)];
    [infoDetailsText setTextColor: [UIColor whiteColor]] ;
    [infoDetailsText setBackgroundColor:[UIColor clearColor]];
    infoDetailsText.font = [UIFont fontWithName:@"Helvetica" size:11];
    infoDetailsText.numberOfLines = 2;
    infoDetailsText.text = @"Tour takes approx. 2 hours\n(depending on your walking speed)";
    [scrollView addSubview:infoDetailsText];
    
    UILabel *anyProblemText = [[UILabel alloc] initWithFrame: CGRectMake(8, 430, 180, 50)];
    [anyProblemText setTextColor: [UIColor whiteColor]] ;
    [anyProblemText setBackgroundColor:[UIColor clearColor]];
    anyProblemText.font = [UIFont fontWithName:@"Helvetica" size:18];
    anyProblemText.numberOfLines = 1;
    anyProblemText.text = @"Any problems?";
    [scrollView addSubview:anyProblemText];
    
    UILabel *anyProblemDetailsText = [[UILabel alloc] initWithFrame: CGRectMake(8, 430, 300, 150)];
    [anyProblemDetailsText setTextColor: [UIColor whiteColor]] ;
    [anyProblemDetailsText setBackgroundColor:[UIColor clearColor]];
    anyProblemDetailsText.font = [UIFont fontWithName:@"Helvetica" size:11];
    anyProblemDetailsText.numberOfLines = 10;
    anyProblemDetailsText.text = @"Please call our support team on \n(03) 8256 9621\nWe can be contacted on\ninfo@truesecrets.com.au\nWe can be found at 228 Bank St, South Melbourne VIC 3205 ABN: 81 071 070 474";
    [scrollView addSubview:anyProblemDetailsText];
    
    aboutView=[[UIView alloc]initWithFrame:CGRectMake(10, 600, 290, 200)];
    aboutView.layer.cornerRadius = 10;
    aboutView.layer.masksToBounds = YES;
    //aboutView.layer.borderWidth=2;
    aboutView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    [scrollView addSubview:aboutView];
    
    
    btn_cuppon=[[UIButton alloc]initWithFrame:CGRectMake(100, 560, 200, 25)];
    [btn_cuppon setTitle:@"        get friend coupon" forState:UIControlStateNormal];
    btn_cuppon.layer.cornerRadius=10;
    btn_cuppon.clipsToBounds=YES;
    [btn_cuppon addTarget:self action:@selector(getCoupon:) forControlEvents:UIControlEventTouchUpInside];
    //btn_cuppon.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [btn_cuppon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [btn_cuppon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btn_cuppon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
    
    //btn_cuppon.tintColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    btn_cuppon.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    //[scrollView addSubview:btn_cuppon];
    
    btn_signUp_temp = [[UIButton alloc]initWithFrame:CGRectMake(100, 591, 200, 25)];
    [btn_signUp_temp setTitle:@"      sign up to email list" forState:UIControlStateNormal];
    btn_signUp_temp.layer.cornerRadius=10;
    btn_signUp_temp.clipsToBounds=YES;
    btn_signUp_temp.hidden = YES;
    [btn_signUp_temp addTarget:self action:@selector(showEmailLayout:) forControlEvents:UIControlEventTouchUpInside];
    btn_signUp_temp.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    //btn_signUp_temp.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    [btn_signUp_temp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [btn_signUp_temp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btn_signUp_temp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
    
    [scrollView addSubview:btn_signUp_temp];
    
    
    btn_clickCoupon=[[UIButton alloc]initWithFrame:CGRectMake(35, 620, 250, 25)];
    [btn_clickCoupon setTitle:@"click to get up to date coupon" forState:UIControlStateNormal];
    btn_clickCoupon.layer.cornerRadius=10;
    btn_clickCoupon.clipsToBounds=YES;
    [btn_clickCoupon addTarget:self action:@selector(getCoupon1:) forControlEvents:UIControlEventTouchUpInside];
    //btn_clickCoupon.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [btn_clickCoupon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [btn_clickCoupon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btn_clickCoupon setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
    
    btn_clickCoupon.tag=1;
    btn_clickCoupon.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    //[scrollView addSubview:btn_clickCoupon];
    
    textView=[[UILabel alloc]initWithFrame:CGRectMake(30, 650, 250, 100)];
    
    [textView setText:@""];
    textView.textColor=[UIColor whiteColor];
    textView.font=[UIFont fontWithName:@"DroidSans" size:15];
    textView.hidden=YES;
    textView.numberOfLines = 6;
    textView.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:textView];
    
    
    couponText=[[UILabel alloc]initWithFrame:CGRectMake(30, 650, 250, 100)];
    
    [couponText setText:@""];
    couponText.textColor=[UIColor whiteColor];
    couponText.font=[UIFont fontWithName:@"DroidSans" size:15];
    couponText.hidden=NO;
    couponText.numberOfLines = 6;
    couponText.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:couponText];
    
    emailView=[[UIView alloc]initWithFrame:CGRectMake(10, 631, 290, 200)];
    emailView.layer.cornerRadius = 10;
    emailView.layer.masksToBounds = YES;
    emailView.hidden = YES;
    emailView.layer.borderWidth=2;
    emailView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    [scrollView addSubview:emailView];
    
    
    btn_signUp=[[UIButton alloc]initWithFrame:CGRectMake(100, 805, 200, 25)];
    [btn_signUp setTitle:@"      sign up to email list" forState:UIControlStateNormal];
    btn_signUp.layer.cornerRadius=10;
    btn_signUp.clipsToBounds=YES;
    [btn_signUp addTarget:self action:@selector(showEmailLayout:) forControlEvents:UIControlEventTouchUpInside];
    btn_signUp.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    //btn_signUp.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [btn_signUp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [btn_signUp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btn_signUp setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
    
    [scrollView addSubview:btn_signUp];
    
        _lbl_Heading = [[UILabel alloc]initWithFrame:CGRectMake(30, 636, 550, 25)];
        _lbl_Heading.text=@"";
        _lbl_Heading.textColor=[UIColor whiteColor];
        _lbl_Heading.font=[UIFont fontWithName:@"DroidSans" size:15];
        _lbl_Heading.hidden=NO;
        _lbl_Heading.backgroundColor=[UIColor clearColor];
        [scrollView addSubview:_lbl_Heading];
        
    lbl_Name=[[UILabel alloc]initWithFrame:CGRectMake(30, 661, 100, 25)];
    lbl_Name.text=@"Name";
    lbl_Name.textColor=[UIColor whiteColor];
    lbl_Name.font=[UIFont fontWithName:@"DroidSans" size:14];
    lbl_Name.hidden=YES;
    lbl_Name.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:lbl_Name];
    // [aboutView addSubview:lbl_Name];
    
    text_Name=[[UITextField alloc]initWithFrame:CGRectMake(30, 690, 200, 25)];
    text_Name.placeholder=@"  Enter Your Name";
    text_Name.delegate=self;
    text_Name.backgroundColor=[UIColor whiteColor];
    //self.text_Name.delegate=self;
    text_Name.borderStyle=UITextBorderStyleRoundedRect;
    text_Name.hidden=YES;
    text_Name.text=@"";
    [scrollView addSubview: text_Name];
    //[aboutView addSubview:text_Name];
    
    text_Password=[[UITextField alloc]initWithFrame:CGRectMake(30, 756, 200, 25)];
    text_Password.placeholder=@"  Enter Your Mail Id";
    text_Password.delegate=self;
    text_Password.backgroundColor=[UIColor whiteColor];
    text_Password.secureTextEntry=NO;
    text_Password.hidden=YES;
    text_Password.borderStyle=UITextBorderStyleRoundedRect;
    text_Password.text=@"";
    
    [scrollView addSubview: text_Password];
    //[aboutView addSubview:text_Password];
    
    
    
    
    lbl_password=[[UILabel alloc]initWithFrame:CGRectMake(30, 726, 100, 25)];
    lbl_password.text=@"Email Id";
    lbl_password.textColor=[UIColor whiteColor];
    lbl_password.backgroundColor=[UIColor clearColor];
    lbl_password.font=[UIFont fontWithName:@"DroidSans" size:14];
    lbl_password.hidden=YES;
    
    [scrollView addSubview:lbl_password];
    //[aboutView addSubview:lbl_password];
    
    
    
    btn_submit=[[UIButton alloc]initWithFrame:CGRectMake(160, 796, 100, 25)];
    [btn_submit setTitle:@"Submit" forState:UIControlStateNormal];
    btn_submit.layer.cornerRadius=10;
    btn_submit.clipsToBounds=YES;
    [btn_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    btn_submit.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    //btn_submit.titleLabel.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [btn_submit setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [btn_submit setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btn_submit setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
    
    btn_submit.hidden=YES;
    [scrollView addSubview:btn_submit];
    
        
        CGSize result = [[UIScreen mainScreen]bounds].size ;
        if (result.height == 480)
        {
            
            //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
            
            UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            // [homeViewButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
            homeViewButton.frame = CGRectMake(0, 445, 105, 35);
            [homeViewButton setTitle:@"home" forState:UIControlStateNormal];
            homeViewButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
           [homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
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
           // [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
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
            [homeViewButton addTarget:self action:@selector(homeView:) forControlEvents:UIControlEventTouchUpInside];
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
            //[aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:aboutViewButton];
            
        }
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        
       
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRight:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [scrollView addGestureRecognizer:swipeRight];
        
    welcome = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
    secretvc1 = [[Secret1ViewController alloc]initWithNibName:@"Secret1ViewController" bundle:nil];
    secretvc2 = [[Secret2ViewController alloc]initWithNibName:@"Secret2ViewController" bundle:nil];
    secretvc3 = [[Secret3ViewController alloc]initWithNibName:@"Secret3ViewController" bundle:nil];
    secretvc4 = [[Secret4ViewController alloc]initWithNibName:@"Secret4ViewController" bundle:nil];
    secretvc5 = [[Secret5ViewController alloc]initWithNibName:@"Secret5ViewController" bundle:nil];
    secretvc6 = [[Secret6ViewController alloc]initWithNibName:@"Secret6ViewController" bundle:nil];
    secretvc7 = [[Secret7ViewController alloc]initWithNibName:@"Secret7ViewController" bundle:nil];
    endvc = [[EndViewController alloc]initWithNibName:@"EndViewController" bundle:nil];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicatorView.frame = self.view.frame;
    activityIndicatorView.color = [UIColor whiteColor];
    activityIndicatorView.center = self.view.center;
    [activityIndicatorView hidesWhenStopped];
    [activityIndicatorView.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:0.50] CGColor]];
    
    
    [self.view addSubview:activityIndicatorView];
}
-(IBAction)handleGestureRight:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    NSString *check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
    if ([check_status isEqualToString:@"Purchased"])
    {
        [self.navigationController pushViewController:secretvc7 animated:NO];
    }else {
        Secret3ViewController *obj111 = [[Secret3ViewController alloc]initWithNibName:@"Secret3ViewController" bundle:nil];
        [self.navigationController pushViewController:obj111 animated:YES];
    }
}
-(IBAction)homeView:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:welcome animated:NO];
}


-(void)getCoupon:(id)sender
{
    //    btn_clickCoupon.hidden=YES;
    //    lbl_Name.hidden=NO;
    //    lbl_password.hidden=NO;
    //
    //[text_Password resignFirstResponder];
    //[text_Password resignFirstResponder];
   // emailForm.hidden =YES;
    
    
    [emailForm removeFromSuperview];
    
    [PopView removeFromSuperview];
    if(bool_showCoupon){
        bool_showCoupon = FALSE;
        
        aboutView.hidden = YES;
        btn_clickCoupon.hidden = YES;
        couponText.hidden = YES;
        btn_signUp_temp.hidden = NO;
        btn_signUp.hidden = YES;
        emailView.hidden = NO;
        
        if([btn_submit.titleLabel.text isEqualToString:@"Ok"])
        {
            textView.hidden = NO;
            text_Name.hidden = YES;
            lbl_Name.hidden = YES;
            text_Password.hidden = YES;
            lbl_password.hidden = YES;
        }else{
            textView.hidden = YES;
            lbl_Name.hidden = NO;
            text_Name.hidden = NO;
            text_Password.hidden = NO;
            lbl_password.hidden = NO;
        }
        
        btn_submit.hidden = NO;
        
    }else{
        bool_showCoupon = TRUE;
        
        emailView.hidden = YES;
        lbl_Name.hidden = YES;
        text_Name.hidden = YES;
        text_Password.hidden = YES;
        lbl_password.hidden = YES;
        btn_submit.hidden = YES;
        textView.hidden = YES;
        
        btn_signUp_temp.hidden = YES;
        btn_signUp.hidden = NO;
        aboutView.hidden = NO;
        btn_clickCoupon.hidden = NO;
        couponText.hidden = NO;
    }
}



-(void)showEmailLayout: (id)sender{
    [emailForm removeFromSuperview];
    //[emailForm bringSubviewToFront:scrollView];
    
    
    if(bool_showCoupon){
        [self webservice];
        bool_showCoupon = FALSE;
        
        aboutView.hidden = YES;
        btn_clickCoupon.hidden = YES;
        couponText.hidden = YES;
        btn_signUp_temp.hidden = NO;
        btn_signUp.hidden = YES;
        emailView.hidden = NO;
        
        if([btn_submit.titleLabel.text isEqualToString:@"Ok"])
        {
            textView.hidden = NO;
            text_Name.hidden = YES;
            lbl_Name.hidden = YES;
            text_Password.hidden = YES;
            lbl_password.hidden = YES;
        }else{
            textView.hidden = YES;
            lbl_Name.hidden = NO;
            text_Name.hidden = NO;
            text_Password.hidden = NO;
            lbl_password.hidden = NO;
        }
        
        btn_submit.hidden = NO;
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
 {
 NSError *error = [request error];
 NSLog(@"res error :%@",error.description);
 if (webserviceCode==2) {
 text_Name.text = @"";
 text_Password.text = @"";
 
 textView.hidden=NO;
 text_Password.hidden = YES;
 text_Name.hidden = YES;
 lbl_Name.hidden = YES;
 lbl_password.hidden = YES;
 // btn_submit.hidden = YES;
 [btn_submit setTitle:@"Ok" forState:UIControlStateNormal];
 
     _lbl_Heading.text = @"";
 textView.text=@" Sorry there has been error\n Could be \n- not internet connection \n- connection error";
 }else if(webserviceCode == 1){
     _lbl_Heading.text = @"";

 couponText.text=@" Sorry there has been error\n Could be \n- not internet connection \n- connection error";
 }
 }
- (void)requestFinished:(ASIHTTPRequest *)request
 {
 // Use when fetching text data
 NSString *responseString = [request responseString];
 
 if(webserviceCode == 1)
 NSLog(@"res of webservice 1:%@",responseString);
 else if(webserviceCode == 2){
 NSLog(@"res of webservice 2:%@",responseString);
 }
     
     if([responseString rangeOfString:@"was not found on this server" options:NSCaseInsensitiveSearch].location != NSNotFound)
     {
         [activityIndicatorView stopAnimating];
         
         
         NSString *recipients = @"mailto:detectives@truesecrets.com.au?cc=&subject=Need a friend coupon email asap please";
         
         NSString *body = [NSString stringWithFormat:@"&body=Hi Detectives,\n\n I want to send my friend %@ a discount for the app, but your server is mysteriously down.\n\n Could you please send %@ the friend coupon on %@\n\nThanks\n\n\nPS The time, date and place I couldn't access the server is %@",nameTxt.text,nameTxt.text,emailTxt.text,[NSDate date]];
         
         NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
         
         email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
         
         [nameTxt resignFirstResponder];
         [emailTxt resignFirstResponder];
         
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"True Secret" message:@"Failed to send email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];

     }
     
 NSData *responseData = [request responseData];
 
 xmlParser = [[NSXMLParser alloc] initWithData: responseData];
 [xmlParser setDelegate:self];
 [xmlParser setShouldResolveExternalEntities:YES]; [xmlParser parse];
 
 // Use when fetching binary data
 //NSData *responseData = [request responseData];
 }

-(IBAction)popbtnaction1:(id)sender
{
     [PopView removeFromSuperview];
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        customViewObj = [[CustomCuponViewController alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    }else{
        customViewObj = [[CustomCuponViewController alloc]initWithFrame:CGRectMake(0, 0, 320, 700)];
    }
    customViewObj.delegate=self;
    
    [customViewObj addCupon];
    [PopView bringSubviewToFront:scrollView];
    return;
}
-(IBAction)popbtnaction2:(id)sender
{
     [PopView removeFromSuperview];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:@"TS1901" forKey:@"ProductCode"];
    //  NSDictionary *dict=[NSDictionary dictionaryWithObject:@"1" forKey:@"Key"];
    //    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(buttonCallBack:)]) {
    //        [self.delegate performSelector:@selector(buttonCallBack:) withObject:dict];
    //    }
    [self buttonCallBack:dict];
    [PopView bringSubviewToFront:scrollView];
}
-(void)buttonCallBack:(id)obj
{
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

-(void)getCoupon1:(id)sender
 {
//     if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"Purchased"])
//     {
//         //-----------
//         //scrollView.userInteractionEnabled = NO;
//         if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
//             PopView = [[UIView alloc]initWithFrame:CGRectMake(90, 200, 580, 435)];
//             PopView.backgroundColor = [UIColor whiteColor];
//             
//             PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
//             PopView.layer.cornerRadius=10;
//             PopView.clipsToBounds=YES;
//             [self.view addSubview: PopView];
//             
//             UILabel *Poplbl =[[UILabel alloc]init];
//             Poplbl.frame = CGRectMake(20, 20, 530, 200);
//             Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
//             Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
//             Poplbl.numberOfLines = 4;
//             [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:32]];
//             [PopView addSubview:Poplbl];
//             
//             UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//             popbtn1.frame = CGRectMake(20, 270, 530, 40);
//             [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
//             popbtn1.titleLabel.numberOfLines=1;
//             [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
//             [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
//             popbtn1.layer.cornerRadius=10;
//             popbtn1.clipsToBounds=YES;
//             [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//             
//             [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//             [PopView addSubview:popbtn1];
//             
//             
//             UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//             popbtn2.frame = CGRectMake(20, 320, 530, 40);
//             [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
//             popbtn2.titleLabel.numberOfLines=1;
//             [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
//             [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
//             popbtn2.layer.cornerRadius=10;
//             popbtn2.clipsToBounds=YES;
//             [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//             
//             [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//             [PopView addSubview:popbtn2];
//             
//             [scrollView bringSubviewToFront:PopView];
//         }else{
//             
//             PopView = [[UIView alloc]initWithFrame:CGRectMake(15, 175, 290, 250)];
//             PopView.backgroundColor = [UIColor whiteColor];
//             
//             PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
//             PopView.layer.cornerRadius=10;
//             PopView.clipsToBounds=YES;
//             [self.view addSubview: PopView];
//             
//             UILabel *Poplbl =[[UILabel alloc]init];
//             Poplbl.frame = CGRectMake(15, 15, 275, 125);
//             Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
//             
//             Poplbl.text = @"To experience the full True Secrets tour you need to purchase acess to the audio files";
//             Poplbl.numberOfLines = 4;
//             [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:21]];
//             [PopView addSubview:Poplbl];
//             
//             UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//             popbtn1.frame = CGRectMake(15, 155, 260, 30);
//             [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
//             popbtn1.titleLabel.numberOfLines=1;
//             [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
//             [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
//             popbtn1.layer.cornerRadius=10;
//             popbtn1.clipsToBounds=YES;
//             [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//             
//             [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//             [PopView addSubview:popbtn1];
//             
//             
//             UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//             popbtn2.frame = CGRectMake(15, 200, 260, 30);
//             [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
//             popbtn2.titleLabel.numberOfLines=1;
//             [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
//             [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
//             popbtn2.layer.cornerRadius=10;
//             popbtn2.clipsToBounds=YES;
//             [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
//             
//             [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//             [PopView addSubview:popbtn2];
//             
//             [scrollView bringSubviewToFront:PopView];
//             
//         }
//         //-----------
//         
//         
//         return;
//     }else {

// NSInteger couponCounter = [[NSUserDefaults standardUserDefaults] integerForKey:@"couponCounter"];
// if(couponCounter<=3){
     
     
 webserviceCode = 1;
 UIDevice *device = [UIDevice currentDevice];
 NSString *uniqueIdentifier = (NSString *)[device identifierForVendor];
 
 NSString *username=@"ts_coupongetter";
 NSString *password=@"6X&z7ub^bzqiPJuLcu";
 NSString *mobile=@"1234567890";
 NSString *action=@"getcoupon";
 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://webservices.truesecrets.com.au/webservice.php"]];
 
 ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
 [request setPostValue:username forKey:@"username"];
 [request setPostValue:password forKey:@"password"];
 [request setPostValue:uniqueIdentifier forKey:@"IMEI"];
 [request setPostValue:mobile forKey:@"Mobile"];
 [request setPostValue:action forKey:@"action"];
 
 [request setRequestMethod:@"POST"];
 [request setDelegate:self];
 [request startAsynchronous];
 
 [self performSelector:@selector(fadeOutLabels) withObject:nil afterDelay:43200.0f];
 //     [self performSelector:@selector(fadeOutLabels) withObject:nil afterDelay:2.0f];
// }else{
// couponText.text=@"Sorry you have used all your coupons, if you think this is an error please contact support.";
// }
//     }
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
}
-(void)fadeOutLabels
{
    [UIView animateWithDuration:1.0
                          delay:0.0  /* do not add a delay because we will use performSelector. */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         couponText.alpha = 0.0;
                         //myLabel2.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         couponText.text=@"";
                         couponText.alpha = 1.0;
                         
                         //[couponText removeFromSuperview];
                         //[myLabel2 removeFromSuperview];
                     }];
}
-(void)submit:(id)sender
 {
 if([btn_submit.titleLabel.text isEqualToString:@"Ok"])
 {
     [self webservice];

 textView.hidden = YES;
 text_Name.hidden = NO;
 lbl_Name.hidden = NO;
 text_Password.hidden = NO;
 lbl_password.hidden = NO;
 [btn_submit setTitle:@"Submit" forState:UIControlStateNormal];
 
 }else{
 if([text_Name.text isEqualToString:@""] || [text_Password.text isEqualToString:@""]){
 [[[UIAlertView alloc]initWithTitle:@"True Secrets"
 message:@"Please fill in the required fields."
 delegate:self
 cancelButtonTitle:@"Ok"
 otherButtonTitles: nil] show];
 
 }else{
     [self webservice];
 NSLog(@"name:%@", text_Name.text);
 NSLog(@"password:%@", text_Password.text);
     NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
     [value setValue:text_Name.text forKey:@"name"];
     [value setObject:text_Password.text forKey:@"email"];
 webserviceCode = 2;
 UIDevice *device = [UIDevice currentDevice];
 NSString *uniqueIdentifier = (NSString *)[device identifierForVendor];
 
 NSString *username=@"ts_coupongetter";
 NSString *password=@"6X&z7ub^bzqiPJuLcu";
 NSString *mobile=@"1234567890";
 NSString *action=@"addemail";
 
 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://webservices.truesecrets.com.au/webservice.php"]];
 
 ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
 [request setPostValue:username forKey:@"username"];
 [request setPostValue:password forKey:@"password"];
 [request setPostValue:uniqueIdentifier forKey:@"IMEI"];
 [request setPostValue:mobile forKey:@"Mobile"];
 [request setPostValue:action forKey:@"action"];
 [request setPostValue:text_Name.text forKey:@"name"];
 [request setPostValue:text_Password.text forKey:@"email"];
 
     NSLog( @"%@",text_Name.text);
     NSLog(@"%@",text_Password.text);
     
 [request setRequestMethod:@"POST"];
 [request setDelegate:self];
 [request startAsynchronous];
 }
 }
 }

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI
 qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict

{   if([elementName isEqualToString:@"result"])
    {
        tempString = [[NSMutableString alloc] init];
        tested = @"yes";
    }
    if ([elementName isEqualToString:@"return_code"])
    {
        if (!returnCode)
        {
            returnCode = [[NSMutableString alloc] init];
        }
        returnCodeFound = YES;
        elementFound = NO;
        iosCouponFound = NO;
        iosExpiryFound = NO;
        androidCouponFound = NO;
        androidExpiryFound = NO;
        
    }else if ([elementName isEqualToString:@"message"])
    {
        if (!soapResult)
        {
            soapResult = [[NSMutableString alloc] init];
        }
        returnCodeFound = NO;
        elementFound = YES;
        iosCouponFound = NO;
        iosExpiryFound = NO;
        androidCouponFound = NO;
        androidExpiryFound = NO;
        
    }else if ([elementName isEqualToString:@"ios_coupon"])
    {
        if (!iosCoupon)
        {
            iosCoupon = [[NSMutableString alloc] init];
            
        }
        returnCodeFound = NO;
        elementFound = NO;
        iosCouponFound = YES;
        iosExpiryFound = NO;
        androidCouponFound = NO;
        androidExpiryFound = NO;
    }else if ([elementName isEqualToString:@"ios_expiry"])
    {
        if (!iosExpiry)
        {
            iosExpiry = [[NSMutableString alloc] init];
        }
        returnCodeFound = NO;
        elementFound = NO;
        iosCouponFound = NO;
        iosExpiryFound = YES;
        androidCouponFound = NO;
        androidExpiryFound = NO;
    }else if ([elementName isEqualToString:@"android_coupon"])
    {
        if (!androidCoupon)
        {
            androidCoupon = [[NSMutableString alloc] init];
        }
        returnCodeFound = NO;
        elementFound = NO;
        iosCouponFound = NO;
        iosExpiryFound = NO;
        androidCouponFound = YES;
        androidExpiryFound = NO;
    }else if ([elementName isEqualToString:@"android_expiry"])
    {
        if (!androidExpiry)
        {
            androidExpiry = [[NSMutableString alloc] init];
        }
        returnCodeFound = NO;
        elementFound = NO;
        iosCouponFound = NO;
        iosExpiryFound = NO;
        androidCouponFound = NO;
        androidExpiryFound = YES;
    }
}
//---when the text in an element is found---
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if(tested)
    {
        tested = @"no";
        [tempString appendString:string];
    }
    if (returnCodeFound)
    {
        [returnCode appendString: string];
    }else if (elementFound)
    {
        [soapResult appendString: string];
    }else if (iosCouponFound)
    {
        [iosCoupon appendString: string];
    }else if (iosExpiryFound)
    {
        [iosExpiry appendString: string];
    }else if (androidCouponFound)
    {
        [androidCoupon appendString: string];
    }else if (androidExpiryFound)
    {
        [androidExpiry appendString: string];
    }
}
//---when the end of element is found---
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(webserviceCode==2){
        text_Name.text = @"";
        text_Password.text = @"";
        
        textView.hidden=NO;
        text_Password.hidden = YES;
        text_Name.hidden = YES;
        lbl_Name.hidden = YES;
        lbl_password.hidden = YES;
        // btn_submit.hidden = YES;
        [btn_submit setTitle:@"Ok" forState:UIControlStateNormal];
        //[btn_submit addTarget:self action:@selector(gotTheMessage:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([elementName isEqualToString:@"return_code"] )
        {
            NSLog(@"%@", soapResult);
            
            if([soapResult rangeOfString:@"success" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                _lbl_Heading.text = @"";
                textView.text=@" Thanks. Your email has been\n submitted successfully to our email\n list. You will get confirmation email\n soon.";
            }
            
            else
            {
                _lbl_Heading.text=@"";
                textView.text=@" Sorry there has been error\n Could be \n- not internet connection \n- connection error";
            }
            
            [soapResult setString:@""];
            [returnCode setString:@""];
            
            returnCodeFound = FALSE;
            elementFound = FALSE;
        }
    }else if (webserviceCode==1){
        if ([elementName isEqualToString:@"message"] )
        {
            NSLog(@"message :%@", soapResult);
        }else if ([elementName isEqualToString:@"ios_coupon"] )
        {
            NSLog(@"ios_coupon :%@", iosCoupon);
        }else if ([elementName isEqualToString:@"ios_expiry"] )
        {
            NSLog(@"ios_expiry :%@", iosExpiry);
        }else if ([elementName isEqualToString:@"android_coupon"] )
        {
            NSLog(@"android coupon :%@", androidCoupon);
        }else if ([elementName isEqualToString:@"android_expiry"] )
        {
            NSLog(@"android expiry :%@", androidExpiry);
        }
        
        if ([elementName isEqualToString:@"data"] )
        {
            NSLog(@"%@", soapResult);
            
            if([soapResult rangeOfString:@"coupon codes retrieved successfully" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSString *msg = [NSString stringWithFormat:@"Android Coupon: %@\nValid until : %@",androidCoupon,iosExpiry];
                
                NSString *theString = msg;
                
                NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
                NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
                
                NSArray *parts = [theString componentsSeparatedByCharactersInSet:whitespaces];
                NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
                msg = [filteredArray componentsJoinedByString:@" "];
                btn_clickCoupon.hidden = YES;
                
                
                [emailForm setBackgroundColor:[UIColor blackColor]];
                [scrollView addSubview:emailForm];
                
                UILabel *androidcouponText=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 230, 40)];
                [androidcouponText setText:msg];
                androidcouponText.textColor=[UIColor whiteColor];
                androidcouponText.font=[UIFont fontWithName:@"DroidSans" size:13];
                androidcouponText.hidden=NO;
                androidcouponText.numberOfLines = 2;
                androidcouponText.backgroundColor=[UIColor clearColor];
//                [emailForm addSubview:androidcouponText];
                
                UILabel *iosCouponText=[[UILabel alloc]initWithFrame:CGRectMake(5, 20, 230, 50)];
                [iosCouponText setText:@"iOS \nYour friend need a special link to get the app for a discount"];
                iosCouponText.textColor=[UIColor whiteColor];
                iosCouponText.font=[UIFont fontWithName:@"DroidSans" size:13];
                iosCouponText.hidden=NO;
                iosCouponText.numberOfLines = 3;
                iosCouponText.backgroundColor=[UIColor clearColor];
                [emailForm addSubview:iosCouponText];

                UILabel *nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 90, 95, 20)];
                [nameLbl setText:@"Name:"];
                nameLbl.textColor=[UIColor whiteColor];
                nameLbl.font=[UIFont fontWithName:@"DroidSans" size:13];
                nameLbl.hidden=NO;
                nameLbl.backgroundColor=[UIColor clearColor];
                [emailForm addSubview:nameLbl];
                
                nameTxt=[[UITextField alloc]initWithFrame:CGRectMake(50, 90, 200,20)];
                nameTxt.placeholder=@"  Enter Your Name";
                nameTxt.delegate=self;
                nameTxt.backgroundColor=[UIColor whiteColor];
                nameTxt.borderStyle=UITextBorderStyleRoundedRect;
                nameTxt.font =[UIFont fontWithName:@"DroidSans" size:13];
                [emailForm addSubview: nameTxt];
                
                UILabel *emailLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 115, 95, 20)];
                [emailLbl setText:@"Email:"];
                emailLbl.textColor=[UIColor whiteColor];
                emailLbl.font=[UIFont fontWithName:@"DroidSans" size:13];
                emailLbl.hidden=NO;
                emailLbl.backgroundColor=[UIColor clearColor];
                [emailForm addSubview:emailLbl];
                
                emailTxt=[[UITextField alloc]initWithFrame:CGRectMake(50, 115, 200, 20)];
                emailTxt.placeholder=@"  Enter Your Email";
                emailTxt.delegate=self;
                emailTxt.backgroundColor=[UIColor whiteColor];
                emailTxt.borderStyle=UITextBorderStyleRoundedRect;
                emailTxt.font =[UIFont fontWithName:@"DroidSans" size:13];
                [emailForm addSubview: emailTxt];
                
                UIButton *emailFriendBtn=[[UIButton alloc]initWithFrame:CGRectMake(150, 150, 110, 20)];
                [emailFriendBtn setTitle:@"Email Friend" forState:UIControlStateNormal];
                emailFriendBtn.layer.cornerRadius=5;
                emailFriendBtn.clipsToBounds=YES;
                [emailFriendBtn addTarget:self action:@selector(emailFriend) forControlEvents:UIControlEventTouchUpInside];
                [emailFriendBtn setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
                [emailFriendBtn setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
                [emailFriendBtn setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
                emailFriendBtn.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
                emailFriendBtn.titleLabel.font = [UIFont fontWithName:@"DroidSans" size:14];
                [emailForm addSubview:emailFriendBtn];
                
                NSInteger couponCounter = [[NSUserDefaults standardUserDefaults] integerForKey:@"couponCounter"];
                couponCounter = couponCounter+1;
                
                [[NSUserDefaults standardUserDefaults] setInteger:couponCounter forKey:@"couponCounter"];
            }else
            {
                couponText.text=@" Sorry there has been error\n Could be \n- not internet connection \n- connection error";
            }
            
            [soapResult setString:@""];
            [iosCoupon setString:@""];
            [iosExpiry setString:@""];
            [androidCoupon setString:@""];
            [androidExpiry setString:@""];
            [returnCode setString:@""];
            
            returnCodeFound = FALSE;
            elementFound = FALSE;
            iosCouponFound = FALSE;
            iosExpiryFound = FALSE;
            androidCouponFound = FALSE;
            androidExpiryFound = FALSE;
        }
        
    }else if (webserviceCode == 3){
        if ([elementName isEqualToString:@"result"])
        {
            if([tempString rangeOfString:@"1" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"True Secret" message:@"Failed to send email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
              
                [activityIndicatorView stopAnimating];
            }
        }
        if ([elementName isEqualToString:@"result"] )
        {
            if([tempString rangeOfString:@"0" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {

             [activityIndicatorView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"True Secrets" message:@"Coupon sent successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            }
            
        }
        if ([elementName isEqualToString:@"result"] )
        {
            if([tempString rangeOfString:@"2" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                [activityIndicatorView stopAnimating];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"True Secrets" message:@"Entered email is not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }
    }
    
}

-(void)emailFriend
{
    
   // NSString* emailStr = [emailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   // NSString* nameStr = [nameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString* emailStr = @"test@gmail.com";
     NSString* nameStr = @"test";
    
     if(nameStr.length ==0)
    {
        NSString * message = @"Please enter name";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if(emailStr.length == 0)
    {
        NSString * message = @"Please enter email address.";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if (![self validateEmailWithString:emailStr]==YES) {
        NSString * message = @"Please enter valid email address";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
//    Reachability *networkConenction = [Reachability reachabilityForInternetConnection];
//    NetworkStatus networkStatus = [networkConenction currentReachabilityStatus];
//    if (networkStatus == NotReachable) {
//        NSLog(@"There IS NO internet connection");
//        
//        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        
//        // Configure for text only and offset down
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"There is no internet conenction...";
//        hud.margin = 10.f;
//        hud.yOffset = 220.f;
//        hud.removeFromSuperViewOnHide = YES;
//        
//        [hud hide:YES afterDelay:2];
//        return;
//    } else {
//        NSLog(@"There IS internet connection");
//    }
    
    [nameTxt resignFirstResponder];
    [emailTxt resignFirstResponder];
    
    [activityIndicatorView startAnimating];
    webserviceCode = 3;
   // NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://112.196.24.206/true_Secret/iosMail.php"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://webservices.truesecrets.com.au/iosMail.php"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:nameStr forKey:@"name"];
    [request setPostValue:emailStr forKey:@"email"];
    
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    //minakshibhardwaj.kis@gmail.com
}
-(void)webservice
{
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    webservice=1;
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://webservices.truesecrets.com.au/string-generator.php"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]]);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [text_Name resignFirstResponder];
    [text_Password resignFirstResponder];
    return YES;
    
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [text_Password resignFirstResponder];
    [text_Name resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.text_Name)
    {
        [theTextField resignFirstResponder];
        //[self.text_Password becomeFirstResponder];
    }
    [theTextField resignFirstResponder];
    return YES;
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSLog(@"%@",email);
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return[emailTest evaluateWithObject:email];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 90; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
        
    }
    else
    {
        [MytableView setHidden:YES];
        MytableView = NULL;
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
    cell.textLabel.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    TableView.scrollEnabled = NO;
    cell.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    
    NSString *check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
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
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    NSString *check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
    if ([check_status isEqualToString:@"Purchased"])
    {
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
    }else {
        InAppPurchaseViewController *InappPurchaseVC;
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
        }else{
            InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
        }
        tableView.hidden = YES;
        InappPurchaseVC.fromWelcome = @"yes";
        InappPurchaseVC.productCode = [NSString stringWithFormat:@"TS_1900"];
        [self.navigationController pushViewController:InappPurchaseVC animated:YES];
    }
    
    
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
#pragma mark - Connection Delegates

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    
    
    return  YES;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"The Internet connection appears to be offline." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"The network connection was lost" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Internet connection lost. Could not connect to the server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"The request timed out. Not able to connect to server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ARA" message:@"Intenet connection failed.. Try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    NSLog(@"ERROR with the Connection ");
    webData =nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [webData appendData:data1];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
    NSError *error;
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    if(webservice==1)
    {
        NSString *msg = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"message"]];
        _lbl_Heading.text = msg;
    }
}
@end
