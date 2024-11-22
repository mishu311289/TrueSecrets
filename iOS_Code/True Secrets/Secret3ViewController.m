//
//  Secret3ViewController.m
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import "Secret3ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DDAnnotation.h"
#import "WHMailActivity.h"
#import "WHTextActivity.h"
#import <MapKit/MapKit.h>
#import "WelcomeViewController.h"
#import "InAppPurchaseViewController.h"

CustomCuponViewController *customViewObj;
#define kTutorialPointProductID @"com.Krishnais.TrueSecretsM"



@interface Secret3ViewController ()

@end

@implementation Secret3ViewController
@synthesize scrollView,couponView,enterCoupontxt,applyCoupon,cancelbtn;
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
   // [self fetchAvailableProducts];

    Bool_showMeMap=TRUE;
    bool_showmap=TRUE;
    MytableView = NULL;
    
    myLocationManager = [[CLLocationManager alloc] init];
    myLocationManager.delegate = self;
    [myLocationManager startUpdatingLocation];
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
    {

        
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setContentSize: CGSizeMake(320 , 900)];
        [scrollView setBackgroundColor:[UIColor blackColor]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide:)];
        
        
        tap.delegate=self;
        tap.cancelsTouchesInView = NO;
        tap.numberOfTapsRequired = 1;
        
        self.view.userInteractionEnabled = YES;
        [self.view addGestureRecognizer:tap];
        [scrollView setContentSize: CGSizeMake(768 , 1024)];
        
        
//        UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1200)];
//        backgroundImg.image = [UIImage imageNamed:@"bgfinal.png"];
//        [scrollView addSubview:backgroundImg];
        
        UIView *imageViewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 30)];
        UIImageView* backgroundImgNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 30)];
        backgroundImgNew.image = [UIImage imageNamed:@"navigation.png"];
        [imageViewTop addSubview:backgroundImgNew];
        imageViewTop.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:imageViewTop];
        
        UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 30, 250, 50)];
        logoImage.image = [UIImage imageNamed:@"logo1.png"];
        [scrollView addSubview:logoImage];
        
        UILabel *lblSecretNo = [[UILabel alloc] initWithFrame: CGRectMake(340, 80, 170, 30)];
        lblSecretNo.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [lblSecretNo setBackgroundColor:[UIColor clearColor]];
        lblSecretNo.text = @"Secret #3";
        lblSecretNo.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:28];
        [scrollView addSubview:lblSecretNo];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(220, 103, 400, 25)];
        lable.text = @"Police desert city center on cup day";
        lable.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:22];
        lable.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        lable.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lable];
        
        
        lable = [[UILabel alloc] initWithFrame: CGRectMake(35, 115, 700, 45)];
        [lable setTextColor: [UIColor whiteColor]] ;
        [lable setBackgroundColor:[UIColor clearColor]];
        lable.numberOfLines = 1;
        lable.textAlignment=NSTextAlignmentCenter;
        lable.text =@"How did the State goverment control 6 days of violence and looting when the Police went on strike in 1923?";
        lable.font = [UIFont fontWithName:@"Helvetica" size:13];
        [scrollView addSubview:lable];
        
        UIButton *mapButton=[UIButton buttonWithType:UIButtonTypeCustom];
        mapButton.frame=CGRectMake(120, 150, 632, 25);
        [mapButton setTitle:@"MAP  " forState:UIControlStateNormal];
        //[mapButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        mapButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
        [mapButton addTarget:self action:@selector(showMe1:) forControlEvents:UIControlEventTouchUpInside];
        mapButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        mapButton.layer.cornerRadius=10;
        mapButton.clipsToBounds=YES;
        mapButton.layer.borderWidth =1;
        mapButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [mapButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        mapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [scrollView addSubview:mapButton];
        
        label_maplabelShow1= [[UILabel alloc]initWithFrame:CGRectMake(120, 175, 632, 25)];
        label_maplabelShow1.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        label_maplabelShow1.text=@"SHOW ME WHERE TO LOOK  ";
        label_maplabelShow1.textAlignment=NSTextAlignmentRight;
        label_maplabelShow1.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        label_maplabelShow1.layer.cornerRadius=10;
        label_maplabelShow1.layer.masksToBounds=YES;
        label_maplabelShow1.layer.borderWidth=2;
        label_maplabelShow1.font=[UIFont fontWithName:@"DroidSans" size:15];
        label_maplabelShow1.hidden=YES;
        [scrollView addSubview:label_maplabelShow1];
        
        view_mapview1=[[UIView alloc]init];
        view_mapview1.frame=CGRectMake(10, 180, 740, 220);
        view_mapview1.backgroundColor=[UIColor clearColor];
        view_mapview1.layer.cornerRadius = 10;
        view_mapview1.layer.masksToBounds = YES;
        view_mapview1.layer.borderWidth=2;
        view_mapview1.layer.borderColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        [scrollView addSubview:view_mapview1];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide1:)];
        tap.delegate=self;
        tap.numberOfTapsRequired = 1;
        [view_mapview1 addGestureRecognizer:tap1];
        
        
        showMeWhere = [UIButton buttonWithType:UIButtonTypeCustom];
        showMeWhere.frame = CGRectMake(120, 410, 632, 25);
        [showMeWhere setTitle:@"SHOW ME WHERE TO LOOK   " forState:UIControlStateNormal];
        showMeWhere.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
        //showMeWhere1.titleLabel.textAlignment=UITextAlignmentRight;
        showMeWhere.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        showMeWhere.layer.cornerRadius=10;
        showMeWhere.clipsToBounds=YES;
        showMeWhere.layer.borderWidth =1;
        [showMeWhere addTarget:self action:@selector(showMe1:) forControlEvents:UIControlEventTouchUpInside];
        showMeWhere.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [showMeWhere setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        showMeWhere.tintColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        //showMeWhere1.titleLabel.textAlignment=UITextAlignmentRight;
        showMeWhere.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [scrollView addSubview:showMeWhere];
        
        
        secondView1=[[UIView alloc]init];
        secondView1.frame=CGRectMake(10, 200, 740, 220);
        secondView1.backgroundColor=[UIColor clearColor];
        secondView1.layer.cornerRadius = 10;
        secondView1.layer.masksToBounds = YES;
        secondView1.layer.borderWidth=2;
        secondView1.hidden=YES;
        secondView1.layer.borderColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        [scrollView addSubview:secondView1];
        
        
        
        mapView =[[MKMapView alloc]init];
        mapView.frame=CGRectMake(25, 220, 710 , 165);
        mapView.zoomEnabled=YES;
        mapView.showsUserLocation=YES;
        
        mapView.delegate = self;
        
        [scrollView addSubview:mapView];
        [self cordinate];
        [self loadRoute];
        
        UILabel *mapDetails = [[UILabel alloc] initWithFrame: CGRectMake(25, 360, 740, 210)];
        [mapDetails setTextColor: [UIColor whiteColor]] ;
        [mapDetails setBackgroundColor:[UIColor clearColor]];
        mapDetails.font = [UIFont fontWithName:@"Helvetica" size:13];
        mapDetails.numberOfLines = 15;
        mapDetails.text = @"The Government tried to recruit able-bodied men. During Cup weekend, able-bodied wasn't so hard to find...but sober and able-bodied was not so easy.";
        [scrollView addSubview:mapDetails];
        
        mapText1 = [[UILabel alloc] initWithFrame: CGRectMake(45, 177, 740, 45)];
        [mapText1 setTextColor: [UIColor whiteColor]] ;
        [mapText1 setBackgroundColor:[UIColor clearColor]];
        mapText1.font = [UIFont fontWithName:@"Helvetica" size:10];
        mapText1.numberOfLines = 1;
        //mapText.tag=i;
        mapText1.text = @"Find your way to Bourke St Mall. Just outside of the old \nBuckley & Nunn store is where they tried to solve the problem.";
        [scrollView addSubview:mapText1];
        
        UILabel *musicPlayText1 = [[UILabel alloc] initWithFrame: CGRectMake(200, 445, 500, 140)];
        musicPlayText1.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [musicPlayText1 setBackgroundColor:[UIColor clearColor]];
        musicPlayText1.font = [UIFont fontWithName:@"Helvetica" size:18];
        musicPlayText1.numberOfLines = 1;
        musicPlayText1.text = @"  Listen to some curious background information.";
        [scrollView addSubview:musicPlayText1];
        
        UIButton *getBackgroundSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[getBackgroundSoundButton setImage:[UIImage imageNamed:@"Get-bg.png"] forState:UIControlStateNormal];
        [getBackgroundSoundButton setTitle:@"background   " forState:UIControlStateNormal];
        getBackgroundSoundButton.layer.cornerRadius=14;
        getBackgroundSoundButton.clipsToBounds=YES;
        getBackgroundSoundButton.frame = CGRectMake(120, 550, 540, 25);
        getBackgroundSoundButton.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [getBackgroundSoundButton addTarget:self action:@selector(getbackgroundSoundbtn:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:getBackgroundSoundButton];
        
        
        getBackgroundSoundButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        getBackgroundSoundButton1.frame = CGRectMake(600, 550, 40, 25);
        getBackgroundSoundButton1.backgroundColor = [UIColor clearColor];
        [getBackgroundSoundButton1 addTarget:self action:@selector(getbackgroundSoundbtn:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:getBackgroundSoundButton1];
        
        
        UIButton *getBonusSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [getBonusSoundButton setTitle:@"bonus material" forState:UIControlStateNormal];
        getBonusSoundButton.layer.cornerRadius=14;
        getBonusSoundButton.clipsToBounds=YES;
        getBonusSoundButton.frame = CGRectMake(120, 770, 540, 25);
        getBonusSoundButton.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        [getBonusSoundButton addTarget:self action:@selector(getBonusSoundBtn:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:getBonusSoundButton];
        
        
        UIButton *getBonusSoundButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [getBonusSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        getBonusSoundButton1.frame = CGRectMake(600, 770, 50, 25);
        getBonusSoundButton1.backgroundColor = [UIColor clearColor];
        [getBonusSoundButton1 addTarget:self action:@selector(getBonusSoundBtn:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:getBonusSoundButton1];
        
        
        UIButton *playSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playSoundButton setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
        playSoundButton.frame = CGRectMake(330, 650, 120, 75);
        [playSoundButton addTarget:self action:@selector(playbutton:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:playSoundButton];
        
        UILabel *musicPlayText3 = [[UILabel alloc] initWithFrame: CGRectMake(268, 585, 260, 70)];
        musicPlayText3.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [musicPlayText3 setBackgroundColor:[UIColor clearColor]];
        musicPlayText3.numberOfLines = 1;
        musicPlayText3.font = [UIFont fontWithName:@"Helvetica" size:20];
        musicPlayText3.text = @"Hear the secret revealed.";
        [scrollView addSubview:musicPlayText3];
        
        
        UILabel *musicPlayText4 = [[UILabel alloc] initWithFrame: CGRectMake(325, 625, 150, 36)];
        musicPlayText4.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [musicPlayText4 setBackgroundColor:[UIColor clearColor]];
        musicPlayText4.font = [UIFont fontWithName:@"Helvetica" size:21];
        musicPlayText4.text = @"PRESS PLAY";
        [scrollView addSubview:musicPlayText4];
        
        
        UILabel *musicPlayText5 = [[UILabel alloc] initWithFrame: CGRectMake(260, 715, 300, 70)];
        musicPlayText5.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [musicPlayText5 setBackgroundColor:[UIColor clearColor]];
        musicPlayText5.numberOfLines = 1;
        // musicPlayText5.textAlignment=UITextAlignmentLeft;
        musicPlayText5.font = [UIFont fontWithName:@"Helvetica" size:20];
        musicPlayText5.text = @"Hear what else we uncovered.";
        [scrollView addSubview:musicPlayText5];
        
        
        
        
        UILabel *checkInText = [[UILabel alloc] initWithFrame: CGRectMake(16, 915, 70, 25)];
        checkInText.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [checkInText setBackgroundColor:[UIColor clearColor]];
        checkInText.font = [UIFont boldSystemFontOfSize:12];
        checkInText.text = @"check in";
        [scrollView addSubview:checkInText];
        
        UILabel *shareText = [[UILabel alloc] initWithFrame: CGRectMake(723, 915, 70, 25)];
        shareText.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        [shareText setBackgroundColor:[UIColor clearColor]];
        shareText.font = [UIFont boldSystemFontOfSize:12];
        shareText.text = @"share";
        [scrollView addSubview:shareText];
        
        
        
        UIButton *checkInFacebookbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkInFacebookbtn setImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
        checkInFacebookbtn.frame = CGRectMake(15, 935, 20, 15);
        [checkInFacebookbtn addTarget:self action:@selector(checkInFacebookView:) forControlEvents:UIControlEventTouchUpInside];
        checkInFacebookbtn.tag = 3;
        [scrollView addSubview:checkInFacebookbtn];
        
    
        UIButton *checkInFoursquareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkInFoursquareBtn setImage:[UIImage imageNamed:@"foursquare.png"] forState:UIControlStateNormal];
        checkInFoursquareBtn.frame = CGRectMake(37, 935, 20, 15);
        [checkInFoursquareBtn addTarget:self action:@selector(checkInFoursquareView:) forControlEvents:UIControlEventTouchUpInside];
        checkInFoursquareBtn.tag = 3;
        
        [scrollView addSubview:checkInFoursquareBtn];
        
        
        UIButton *checkInMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkInMapBtn setImage:[UIImage imageNamed:@"googleplus.png"] forState:UIControlStateNormal];
        checkInMapBtn.frame = CGRectMake(59, 935, 20, 15);
        [checkInMapBtn addTarget:self action:@selector(checkInMapView:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:checkInMapBtn];
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        shareButton.frame = CGRectMake(735, 935, 20, 15);
        [shareButton addTarget:self action:@selector(shareButtonView:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:shareButton];
        
        UILabel *conditionText1 = [[UILabel alloc] initWithFrame: CGRectMake(680, 927, 70, 20)];
        [conditionText1 setTextColor: [UIColor lightGrayColor]] ;
        [conditionText1 setBackgroundColor:[UIColor clearColor]];
        conditionText1.font = [UIFont boldSystemFontOfSize:9];
        conditionText1.text = @"#truesecrets";
        [scrollView addSubview:conditionText1];
        
        UILabel *conditionText2 = [[UILabel alloc] initWithFrame: CGRectMake(659, 937, 80, 20)];
        [conditionText2 setTextColor: [UIColor lightGrayColor]] ;
        [conditionText2 setBackgroundColor:[UIColor clearColor]];
        conditionText2.font = [UIFont boldSystemFontOfSize:9];
        conditionText2.text = @"@truesecretstour";
        [scrollView addSubview:conditionText2];
        
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
        [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aboutViewButton];

       NSString* check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
        if (![check_status isEqualToString:@"Purchased"])
        {
        [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        [self.view addSubview:aboutViewButton];
        
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureLeft:)];
        [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft )];
        [scrollView addGestureRecognizer:swipeLeft];
        
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
        
        
        [scrollView addSubview:mapView];
    }
    else
    {
    Bool_showMeMap=TRUE;
    bool_showmap=TRUE;
    MytableView = NULL;
    
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setContentSize: CGSizeMake(320 , 900)];
     [scrollView setBackgroundColor:[UIColor blackColor]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHide:)];
    
    
    tap.delegate=self;
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    [scrollView setContentSize: CGSizeMake(320 , 900)];

    
//    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 900)];
//    backgroundImg.image = [UIImage imageNamed:@"bgfinal.png"];
//    [scrollView addSubview:backgroundImg];
        UIView *imageViewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        UIImageView* backgroundImgNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        backgroundImgNew.image = [UIImage imageNamed:@"navigation.png"];
        [imageViewTop addSubview:backgroundImgNew];
        imageViewTop.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:imageViewTop];
        
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 30, 250, 50)];
    logoImage.image = [UIImage imageNamed:@"logo1.png"];
    [scrollView addSubview:logoImage];
    
    UILabel *lblSecretNo = [[UILabel alloc] initWithFrame: CGRectMake(120, 80, 170, 30)];
    lblSecretNo.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [lblSecretNo setBackgroundColor:[UIColor clearColor]];
    lblSecretNo.text = @"Secret #3";
    lblSecretNo.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:22];
    [scrollView addSubview:lblSecretNo];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 300, 25)];
    lable.text = @"Police desert city center on cup day";
    lable.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:16.0f];
    lable.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    lable.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lable];
    
    
    lable = [[UILabel alloc] initWithFrame: CGRectMake(20, 115, 290, 45)];
    [lable setTextColor: [UIColor whiteColor]] ;
    [lable setBackgroundColor:[UIColor clearColor]];
    lable.numberOfLines = 3;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text =@"How did the State goverment control 6 days of violence \nand looting when the Police went on strike in 1923?";
    lable.font = [UIFont fontWithName:@"Helvetica" size:11];
    [scrollView addSubview:lable];
    
    UIButton *mapButton=[UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame=CGRectMake(10, 157, 300, 20);
    [mapButton setTitle:@"MAP" forState:UIControlStateNormal];
    //[mapButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    mapButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
    [mapButton addTarget:self action:@selector(showMe1:) forControlEvents:UIControlEventTouchUpInside];
    mapButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    mapButton.layer.cornerRadius=10;
    mapButton.clipsToBounds=YES;
    mapButton.layer.borderWidth =1;
    mapButton.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [mapButton setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    mapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [scrollView addSubview:mapButton];
    
    label_maplabelShow1= [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 300, 20)];
    label_maplabelShow1.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    label_maplabelShow1.text=@"SHOW ME WHERE TO LOOK  ";
    label_maplabelShow1.textAlignment=NSTextAlignmentRight;
    label_maplabelShow1.textColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    label_maplabelShow1.layer.cornerRadius=10;
    label_maplabelShow1.layer.masksToBounds=YES;
    label_maplabelShow1.layer.borderWidth=2;
    label_maplabelShow1.font=[UIFont fontWithName:@"DroidSans" size:12];
    label_maplabelShow1.hidden=YES;
    [scrollView addSubview:label_maplabelShow1];
    
    view_mapview1=[[UIView alloc]init];
    view_mapview1.frame=CGRectMake(5, 180, 310, 220);
    view_mapview1.backgroundColor=[UIColor clearColor];
    view_mapview1.layer.cornerRadius = 10;
    view_mapview1.layer.masksToBounds = YES;
    view_mapview1.layer.borderWidth=2;
    view_mapview1.layer.borderColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    [scrollView addSubview:view_mapview1];
        
        
        
    showMeWhere = [UIButton buttonWithType:UIButtonTypeCustom];
    showMeWhere.frame = CGRectMake(10, 410, 300, 20);
    [showMeWhere setTitle:@"SHOW ME WHERE TO LOOK   " forState:UIControlStateNormal];
    showMeWhere.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
    //showMeWhere1.titleLabel.textAlignment=UITextAlignmentRight;
    showMeWhere.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    showMeWhere.layer.cornerRadius=10;
    showMeWhere.clipsToBounds=YES;
    showMeWhere.layer.borderWidth =1;
    [showMeWhere addTarget:self action:@selector(showMe1:) forControlEvents:UIControlEventTouchUpInside];
    showMeWhere.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [showMeWhere setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        showMeWhere.tintColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    //showMeWhere1.titleLabel.textAlignment=UITextAlignmentRight;
    showMeWhere.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [scrollView addSubview:showMeWhere];
    
    
    secondView1=[[UIView alloc]init];
    secondView1.frame=CGRectMake(5, 200, 310, 220);
    secondView1.backgroundColor=[UIColor clearColor];
    secondView1.layer.cornerRadius = 10;
    secondView1.layer.masksToBounds = YES;
    secondView1.layer.borderWidth=2;
    secondView1.hidden=YES;
    secondView1.layer.borderColor=[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    [scrollView addSubview:secondView1];
        
    mapView =[[MKMapView alloc]init];
    mapView.frame=CGRectMake(30, 220, 260 , 165);
    mapView.zoomEnabled=YES;
    mapView.showsUserLocation=YES;
    
    mapView.delegate = self;
    
    [scrollView addSubview:mapView];
    [self cordinate];
    [self loadRoute];
    
    UILabel *mapDetails = [[UILabel alloc] initWithFrame: CGRectMake(28, 360, 300, 210)];
    [mapDetails setTextColor: [UIColor whiteColor]] ;
    [mapDetails setBackgroundColor:[UIColor clearColor]];
    mapDetails.font = [UIFont fontWithName:@"Helvetica" size:11];
    mapDetails.numberOfLines = 15;
    mapDetails.text = @"The Government tried to recruit able-bodied men.\nDuring Cup weekend, able-bodied wasn't so hard \nto find...but sober and able-bodied was not so easy.";
    [scrollView addSubview:mapDetails];
    
    mapText1 = [[UILabel alloc] initWithFrame: CGRectMake(23, 177, 290, 45)];
    [mapText1 setTextColor: [UIColor whiteColor]] ;
    [mapText1 setBackgroundColor:[UIColor clearColor]];
    mapText1.font = [UIFont fontWithName:@"Helvetica" size:10];
    mapText1.numberOfLines = 3;
    //mapText.tag=i;
    mapText1.text = @"Find your way to Bourke St Mall. Just outside of the old \nBuckley & Nunn store is where they tried to solve the problem.";
    [scrollView addSubview:mapText1];
    
    UILabel *musicPlayText1 = [[UILabel alloc] initWithFrame: CGRectMake(60, 445, 260, 140)];
    musicPlayText1.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [musicPlayText1 setBackgroundColor:[UIColor clearColor]];
    musicPlayText1.font = [UIFont fontWithName:@"Helvetica" size:18];
    musicPlayText1.numberOfLines = 2;
    musicPlayText1.text = @"  Listen to some curious\n background information.";
    [scrollView addSubview:musicPlayText1];
    
    UIButton *getBackgroundSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[getBackgroundSoundButton setImage:[UIImage imageNamed:@"Get-bg.png"] forState:UIControlStateNormal];
    [getBackgroundSoundButton setTitle:@"background   " forState:UIControlStateNormal];
    getBackgroundSoundButton.layer.cornerRadius=14;
    getBackgroundSoundButton.clipsToBounds=YES;
    getBackgroundSoundButton.frame = CGRectMake(70, 550, 170, 25);
    getBackgroundSoundButton.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [getBackgroundSoundButton addTarget:self action:@selector(getbackgroundSoundbtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getBackgroundSoundButton];
    
    
    getBackgroundSoundButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    getBackgroundSoundButton1.frame = CGRectMake(200, 550, 40, 25);
    getBackgroundSoundButton1.backgroundColor = [UIColor clearColor];
    [getBackgroundSoundButton1 addTarget:self action:@selector(getbackgroundSoundbtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getBackgroundSoundButton1];
    
    
    UIButton *getBonusSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getBonusSoundButton setTitle:@"bonus material" forState:UIControlStateNormal];
    getBonusSoundButton.layer.cornerRadius=14;
    getBonusSoundButton.clipsToBounds=YES;
    getBonusSoundButton.frame = CGRectMake(75, 770, 170, 25);
    getBonusSoundButton.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [getBonusSoundButton addTarget:self action:@selector(getBonusSoundBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getBonusSoundButton];
    
    
    UIButton *getBonusSoundButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [getBonusSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    getBonusSoundButton1.frame = CGRectMake(205, 770, 50, 25);
    getBonusSoundButton1.backgroundColor = [UIColor clearColor];
    [getBonusSoundButton1 addTarget:self action:@selector(getBonusSoundBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getBonusSoundButton1];
    
    
    UIButton *playSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playSoundButton setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    playSoundButton.frame = CGRectMake(100, 650, 120, 75);
    [playSoundButton addTarget:self action:@selector(playbutton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:playSoundButton];
    
    UILabel *musicPlayText3 = [[UILabel alloc] initWithFrame: CGRectMake(38, 585, 260, 70)];
    musicPlayText3.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [musicPlayText3 setBackgroundColor:[UIColor clearColor]];
    musicPlayText3.numberOfLines = 1;
    musicPlayText3.font = [UIFont fontWithName:@"Helvetica" size:20];
    musicPlayText3.text = @"Hear the secret revealed.";
    [scrollView addSubview:musicPlayText3];
    
    
    UILabel *musicPlayText4 = [[UILabel alloc] initWithFrame: CGRectMake(95, 625, 150, 36)];
    musicPlayText4.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [musicPlayText4 setBackgroundColor:[UIColor clearColor]];
    musicPlayText4.font = [UIFont fontWithName:@"Helvetica" size:21];
    musicPlayText4.text = @"PRESS PLAY";
    [scrollView addSubview:musicPlayText4];
    
    
    UILabel *musicPlayText5 = [[UILabel alloc] initWithFrame: CGRectMake(30, 715, 300, 70)];
    musicPlayText5.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [musicPlayText5 setBackgroundColor:[UIColor clearColor]];
    musicPlayText5.numberOfLines = 1;
    // musicPlayText5.textAlignment=UITextAlignmentLeft;
    musicPlayText5.font = [UIFont fontWithName:@"Helvetica" size:20];
    musicPlayText5.text = @"Hear what else we uncovered.";
    [scrollView addSubview:musicPlayText5];
    
    
    
    
    UILabel *checkInText = [[UILabel alloc] initWithFrame: CGRectMake(16, 827, 70, 25)];
    checkInText.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [checkInText setBackgroundColor:[UIColor clearColor]];
    checkInText.font = [UIFont boldSystemFontOfSize:12];
    checkInText.text = @"check in";
    [scrollView addSubview:checkInText];
    
    UILabel *shareText = [[UILabel alloc] initWithFrame: CGRectMake(273, 827, 70, 25)];
    shareText.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [shareText setBackgroundColor:[UIColor clearColor]];
    shareText.font = [UIFont boldSystemFontOfSize:12];
    shareText.text = @"share";
    [scrollView addSubview:shareText];
    
    
    
    UIButton *checkInFacebookbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInFacebookbtn setImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
    checkInFacebookbtn.frame = CGRectMake(16, 847, 20, 15);
    [checkInFacebookbtn addTarget:self action:@selector(checkInFacebookView:) forControlEvents:UIControlEventTouchUpInside];
    checkInFacebookbtn.tag = 3;
    [scrollView addSubview:checkInFacebookbtn];
    
    UIButton *checkInFoursquareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInFoursquareBtn setImage:[UIImage imageNamed:@"foursquare.png"] forState:UIControlStateNormal];
    checkInFoursquareBtn.frame = CGRectMake(38, 847, 20, 15);
    [checkInFoursquareBtn addTarget:self action:@selector(checkInFoursquareView:) forControlEvents:UIControlEventTouchUpInside];
    checkInFoursquareBtn.tag = 3;
    [scrollView addSubview:checkInFoursquareBtn];
    
    UIButton *checkInMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInMapBtn setImage:[UIImage imageNamed:@"googleplus.png"] forState:UIControlStateNormal];
    checkInMapBtn.frame = CGRectMake(60, 847, 20, 15);
    [checkInMapBtn addTarget:self action:@selector(checkInMapView:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:checkInMapBtn];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(284, 847, 20, 15);
    [shareButton addTarget:self action:@selector(shareButtonView:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:shareButton];
    
    UILabel *conditionText1 = [[UILabel alloc] initWithFrame: CGRectMake(224, 839, 70, 20)];
    [conditionText1 setTextColor: [UIColor lightGrayColor]] ;
    [conditionText1 setBackgroundColor:[UIColor clearColor]];
    conditionText1.font = [UIFont boldSystemFontOfSize:9];
    conditionText1.text = @"#truesecrets";
    [scrollView addSubview:conditionText1];
    
    UILabel *conditionText2 = [[UILabel alloc] initWithFrame: CGRectMake(204, 849, 80, 20)];
    [conditionText2 setTextColor: [UIColor lightGrayColor]] ;
    [conditionText2 setBackgroundColor:[UIColor clearColor]];
    conditionText2.font = [UIFont boldSystemFontOfSize:9];
    conditionText2.text = @"@truesecretstour";
    [scrollView addSubview:conditionText2];
    
        
        CGSize result = [[UIScreen mainScreen]bounds].size ;
        if (result.height == 480)
        {
            
            //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
            
            UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
            [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
            NSString* check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
            if (![check_status isEqualToString:@"Purchased"])
            {
            [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [self.view addSubview:aboutViewButton];
        }
        else if(result.height == 568)
        {
            //~~~~~~~~~~~~~~~~~~~ Footer Bar~~~~~~~~~~~~~~~~~~~~//
            
            UIButton *homeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
            [aboutViewButton addTarget:self action:@selector(aboutView:) forControlEvents:UIControlEventTouchUpInside];
            NSString* check_status1 = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
            if (![check_status1 isEqualToString:@"Purchased"])
            {
                [aboutViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [self.view addSubview:aboutViewButton];
            
        }
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        
        
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureLeft:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [scrollView addGestureRecognizer:swipeLeft];
    
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

        
    [scrollView addSubview:mapView];
    //[self cordinate];
    //[self loadRoute];
    }
    
        [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [backGroundView removeFromSuperview];

    [self.view setUserInteractionEnabled:YES];
}
-(IBAction)handleGestureLeft:(id)sender
{
   NSString* check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
    if ([check_status isEqualToString:@"Purchased"])
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
        [self.navigationController pushViewController:secretvc4 animated:NO];
    }else {
        EndViewController *obj111 = [[EndViewController alloc]initWithNibName:@"EndViewController" bundle:nil];
        [self.navigationController pushViewController:obj111 animated:YES];
    }
    }
}
-(IBAction)handleGestureRight:(id)sender
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
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    NSString *check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
    if ([check_status isEqualToString:@"Purchased"])
    {
        [self.navigationController pushViewController:secretvc2 animated:NO];
    }else {
        WelcomeViewController *obj111= [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
        [self.navigationController pushViewController:obj111 animated:YES];
    }
    
    
}
-(IBAction)homeView:(id)sender
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
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:welcome animated:NO];
}
-(IBAction)aboutView:(id)sender
{
    NSString* check_status = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"]];
    if ([check_status isEqualToString:@"Purchased"])
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
    
    [self.navigationController pushViewController:endvc animated:NO];
    }
}


#pragma mark MKMapViewDelegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKOverlayView* overlayView = nil;
    {
        routeLineView = [[MKPolylineView alloc] initWithPolyline:routeLine];
        routeLineView.fillColor = [UIColor colorWithRed:137.0f/255.0f green:137.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        routeLineView.strokeColor = [UIColor colorWithRed:137.0f/255.0f green:137.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        
        routeLineView.lineWidth = 3;
        overlayView = routeLineView;
    }
    return overlayView;
}
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    MKAnnotationView * customPinView = [[MKAnnotationView alloc] init];
    UIImage * img;
    
    
    if ([annotation.title isEqualToString:@"annotation1"])
        img = [UIImage imageNamed:@"secret_01.png"] ; // 1
    else if ([annotation.title isEqualToString:@"annotation2"])
        img = [UIImage imageNamed:@"secret_02.png"] ;
    else if ([annotation.title isEqualToString:@"annotation3"])
        img = [UIImage imageNamed:@"secret_03.png"] ;
    else if ([annotation.title isEqualToString:@"annotation4"])
        img = [UIImage imageNamed:@"secret_04.png"] ;
    else if ([annotation.title isEqualToString:@"annotation5"])
        img = [UIImage imageNamed:@"secret_05.png"] ;
    else if ([annotation.title isEqualToString:@"annotation6"])
        img = [UIImage imageNamed:@"secret_06.png"] ;
    else if ([annotation.title isEqualToString:@"annotation7"])
        img = [UIImage imageNamed:@"secret_07.png"] ;
    else
        return nil;
    
    CGRect resizeRect;
    resizeRect.size.height = 45;
    resizeRect.size.width = 45;
    resizeRect.origin = (CGPoint){0.0f, 0.0f};
    customPinView.centerOffset = CGPointMake(1, -9);
    UIGraphicsBeginImageContext(resizeRect.size);
    [img drawInRect:resizeRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customPinView.image = resizedImage;
    
    return customPinView;
}
- (void)getbackgroundSoundbtn:(id)sender
{
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"NotPurchased"])
//    {
//        UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"True Secrets" message:@"You Need to Purchase Audio Files. Purchase now?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
//        [PurchaseAlert show];
//        return;
//    }

    int playbutton1 =[sender tag];
    NSLog(@"value=%d",playbutton1);
    
    getBackgroundSoundButton2=[[UIButton alloc]init];
    
    if (mainPlayValue ==TRUE)
    {
        if ([masterAudioPlayer isPlaying])
        {
            [masterAudioPlayer pause];
        }
        [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
        [scrollView addSubview:playButton1];
        mainPlayValue=FALSE;
        
    }
    if (bonusValue==TRUE)
    {
        if ([bonusAudioPlayer isPlaying])
        {
            [bonusAudioPlayer pause];
        }
        [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        bonusValue=FALSE;
    }
    if (thanksvalue==TRUE)
    {
        if ([thanksAudioPlayer isPlaying])
        {
            [thanksAudioPlayer pause];
        }
        [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        thanksvalue=FALSE;
    }
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        getBackgroundSoundButton2.frame=CGRectMake(445, 550, 15, 25);
    }else
    {
    getBackgroundSoundButton2.frame=CGRectMake(195, 550, 15, 25);
    }
    getBackgroundSoundButton2.tag=1;
    
    getBackgroundSoundButton2.layer.cornerRadius=5;
    getBackgroundSoundButton2.clipsToBounds=YES;
    [getBackgroundSoundButton2 addTarget:self action:@selector(getbackgroundSoundbtn:) forControlEvents:UIControlEventTouchUpInside];
    getBackgroundSoundButton2.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [scrollView addSubview:getBackgroundSoundButton2];
    
    if (backgroundvalue==TRUE)
    {
        
        [bgAudioPlayer pause];
        [bgAudioPlayer prepareToPlay];
        
        [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        backgroundvalue=FALSE;
        //         playing=TRUE;
        NSLog(@"shael1");
        
    }
    else{
        value = @"101";
        
        [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        if (isBackgroundInit==TRUE)
        {
            [bgAudioPlayer play];
            //playing=FALSE;
            [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            backgroundvalue=TRUE;
            
        }
        else{
            
            backgroundMusicFile = @"Secret_3_Background";
            NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",backgroundMusicFile] ofType:@"mp3"]];
            
            
            //    [getBackgroundSoundButton2 addTarget:self action:@selector(pauseMe1:) forControlEvents:UIControlEventTouchUpInside];
            
            bgAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            
            NSLog(@"file=%@",backgroundMusicFile);
            bgAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            [bgAudioPlayer prepareToPlay];
            bgAudioPlayer.delegate=self;
            [bgAudioPlayer play];
            isBackgroundInit=TRUE;
            backgroundvalue=TRUE;
            
        }
    }
}
- (void)showHide1:(id)sender
{
    InAppPurchaseViewController *InappPurchaseVC;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
    }else{
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    }
    
    
    InappPurchaseVC.productCode = @"TS_1900";
    [self.navigationController pushViewController:InappPurchaseVC animated:YES];
}
- (void)showHide:(id)sender
{
    
    
    MytableView.hidden = YES;
    
}


- (void)playbutton:(id)sender
{
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"NotPurchased"])
//    {
//        UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"True Secrets" message:@"You Need to Purchase Audio Files. Purchase now?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
//        [PurchaseAlert show];
//        return;
//    }

    
    playButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    playButton1=[[UIButton alloc]init];
    if (backgroundvalue==TRUE)
    {
        if ([bgAudioPlayer isPlaying])
        {
            [bgAudioPlayer pause];
        }
        [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [scrollView addSubview:getBackgroundSoundButton1];
        backgroundvalue=FALSE;
        
    }
    if (bonusValue==TRUE)
    {
        if ([bonusAudioPlayer isPlaying])
        {
            [bonusAudioPlayer pause];
        }
        [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        bonusValue=FALSE;
    }
    if (thanksvalue==TRUE)
    {
        if ([thanksAudioPlayer isPlaying])
        {
            [thanksAudioPlayer pause];
        }
        [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        thanksvalue=FALSE;
    }
    //    if (tha==TRUE)
    //    {
    //        if ([thanksAudioPlayer isPlaying])
    //        {
    //            [thanksAudioPlayer pause];
    //        }
    //        [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    //        bonusValue=FALSE;
    //    }
    
    
    int playbutton2 =[sender tag];
    NSLog(@"value=%d",playbutton2);
    //playSoundButton.frame=CGRectMake(420, 650, 120, 75);
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        playButton1.frame=CGRectMake(330, 650, 120, 75);
    }else
    {
        playButton1.frame=CGRectMake(100, 650, 120, 75);
    }
    playButton1.tag=1;
    // playButton1.hidden=YES;
    //[playButton1 setImage:[UIImage imageNamed:@"pause_main.png"] forState:UIControlStateNormal];
    //[playButton1 addTarget:self action:@selector(pauseMe:) forControlEvents:UIControlEventTouchUpInside];
    [playButton1 addTarget:self action:@selector(playbutton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:playButton1];
    musicplayfile = @"police_strike_master";
    
    if (mainPlayValue==TRUE)
    {
        [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
        [masterAudioPlayer pause];
        [masterAudioPlayer prepareToPlay];
        mainPlayValue=FALSE;
        
    }
    else{
        
        if (ismasterInit==TRUE)
        {
            [masterAudioPlayer play];
            mainPlayValue=YES;
            [playButton1 setImage:[UIImage imageNamed:@"pause_main.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            [playButton1 setImage:[UIImage imageNamed:@"pause_main.png"] forState:UIControlStateNormal];
            NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",musicplayfile] ofType:@"mp3"]];
            masterAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            
            NSLog(@"file=%@",musicplayfile);
            masterAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            [masterAudioPlayer prepareToPlay];
            masterAudioPlayer.delegate=self;
            [masterAudioPlayer play];
            ismasterInit=YES;
            mainPlayValue=YES;
            
            
        }
        
    }
}
//-(void)pauseMe:(id)sender
//{
//
//    int pauseMebutton2 =[sender tag];
//    NSLog(@"value=%d",pauseMebutton2);
//    switch (pauseMebutton2)
//    {
//        case 1:
//            //playSoundButton.frame=CGRectMake(420, 650, 120, 75);
//            playButton1.frame=CGRectMake(420, 650, 120, 75);
//            playButton1.tag=1;
//
//            break;
//        case 2:
//
//            playButton1.frame=CGRectMake(740, 650, 120, 75);
//            playButton1.tag=2;
//            //playSoundButton.tag=1;
//
//            break;
//        case 3:
//
//            playButton1.frame=CGRectMake(1060, 650, 120, 75);
//            playButton1.tag=3;
//            break;
//        case 4:
//
//            playButton1.frame=CGRectMake(1380, 650, 120, 75);
//            playButton1.tag=4;
//
//        case 5:
//            playButton1.frame=CGRectMake(1700, 650, 120, 75);
//            playButton1.tag=5;
//
//            break;
//        case 6:
//
//            playButton1.frame=CGRectMake(2020, 650, 120, 75);
//            playButton1.tag=6;
//
//            break;
//        case 7:
//            // playSoundButton.frame=CGRectMake(2340, 650, 120, 75);
//            playButton1.frame=CGRectMake(2340, 650, 120, 75);
//            playButton1.tag=7;
//            // [playSoundButton setImage:[UIImage imageNamed:@"pause_main.png"] forState:UIControlStateNormal];
//            // playSoundButton.tag=1;
//            break;
//
//        default:
//            break;
//    }
//
//
//
//    [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
//    [playButton1 addTarget:self action:@selector(playbutton:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:playButton1];
//
//    //playButton1.hidden=YES;
//    if (masterAudioPlayer)
//    {
//        [masterAudioPlayer stop];
//
//    }
//}
//-(void)pauseMe1:(id)sender
//{
//
//
//    int pauseMebutton1 =[sender tag];
//    NSLog(@"value=%d",pauseMebutton1);
//    switch (pauseMebutton1)
//    {
//        case 1:
//            getBackgroundSoundButton2.frame=CGRectMake(530, 550, 20, 25);
//            getBackgroundSoundButton2.tag=1;
//
//            //getBackgroundSoundButton1.frame=CGRectMake(520, 550, 50, 25);
//            break;
//        case 2:
//            getBackgroundSoundButton2.frame=CGRectMake(850, 550, 20, 25);
//            getBackgroundSoundButton2.tag=2;
//
//
//            break;
//        case 3:
//            getBackgroundSoundButton2.frame=CGRectMake(1170, 550, 20, 25);
//
//            getBackgroundSoundButton2.tag=3;
//            break;
//        case 4:
//            getBackgroundSoundButton2.frame=CGRectMake(1490, 550, 20, 25);
//            getBackgroundSoundButton2.tag=4;
//
//            break;
//        case 5:
//            getBackgroundSoundButton2.frame=CGRectMake(1810, 550, 20, 25);
//            getBackgroundSoundButton2.tag=5;
//
//            break;
//        case 6:
//            getBackgroundSoundButton2.frame=CGRectMake(2130, 550, 20, 25);
//
//            getBackgroundSoundButton2.tag=6;
//            break;
//        case 7:
//            getBackgroundSoundButton2.frame=CGRectMake(2450, 550, 20, 25);
//
//            getBackgroundSoundButton2.tag=7;
//            break;
//
//        default:
//            break;
//
//    }
//
//
//
//    [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
//    [getBackgroundSoundButton2 addTarget:self action:@selector(getbackgroundSoundbtn:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:getBackgroundSoundButton2];
//
//
//    if (audioPlayer)
//    {
//        [audioPlayer pause];
//    }
//
//
//
//}

-(void)getBonusSoundBtn:(id)sender
{
    
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"NotPurchased"])
//    {
//        UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"True Secrets" message:@"You Need to Purchase Audio Files. Purchase now?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
//        [PurchaseAlert show];
//        return;
//    }

    NSLog(@"bonus play is on");
    
    int playbutton3 =[sender tag];
    NSLog(@"value=%d",playbutton3);
    getBonusBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    if (mainPlayValue ==TRUE)
    {
        if ([masterAudioPlayer isPlaying])
        {
            [masterAudioPlayer pause];
        }
        [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
        [scrollView addSubview:playButton1];
        mainPlayValue=FALSE;
        
    }
    if (backgroundvalue==TRUE)
    {
        if ([bgAudioPlayer isPlaying])
        {
            [bgAudioPlayer pause];
        }
        [getBackgroundSoundButton2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        backgroundvalue=FALSE;
    }
    
    if (thanksvalue==TRUE)
    {
        if ([thanksAudioPlayer isPlaying])
        {
            [thanksAudioPlayer pause];
        }
        [thanksPlaybtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        thanksvalue=FALSE;
    }
    
    
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
        getBonusBtn2.frame=CGRectMake(615, 770, 20, 25);
    }else
    {
        getBonusBtn2.frame=CGRectMake(220, 770, 20, 25);
    }

    
    getBonusBtn2.tag=1;
    
    getBonusBtn2.layer.cornerRadius=5;
    getBonusBtn2.clipsToBounds=YES;
    
    [getBonusBtn2  addTarget:self action:@selector(getBonusSoundBtn:) forControlEvents:UIControlEventTouchUpInside];
    getBonusBtn2.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    
    NSLog(@"getBackground.tag:%d",getBonusBtn2.tag);
    [scrollView addSubview:getBonusBtn2];
    
    
    if (bonusValue==TRUE)
    {
        [bonusAudioPlayer pause];
        [bonusAudioPlayer prepareToPlay];
        [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
        //playing=TRUE;
        bonusValue=FALSE;
        
        
    }
    else
    {
        if (isBonusInit==TRUE)
        {
            [bonusAudioPlayer play];
            [getBonusBtn2 setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            //playing=FALSE;
            bonusValue=TRUE;
            
        }
        else
        {
            
            [getBonusBtn2 setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            backgroundMusicFile = @"Secret_3_Bonus";
            NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",backgroundMusicFile] ofType:@"mp3"]];
            bonusAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            
            NSLog(@"file=%@",backgroundMusicFile);
            bonusAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
            [bonusAudioPlayer prepareToPlay];
            bonusAudioPlayer.delegate=self;
            [bonusAudioPlayer play];
            isBonusInit=TRUE;
            bonusValue=TRUE;
            
        }
    }
    
    
}

#pragma mark - Alert View Delegate
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
    NSDictionary *dict=obj;
    NSLog(@"%@",[dict valueForKey:@"ProductCode"]);
    
    InAppPurchaseViewController *InappPurchaseVC;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
    }else{
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    }
    InappPurchaseVC.productCode = [dict valueForKey:@"ProductCode"];
    InappPurchaseVC.couponCode = [dict valueForKey:@"CouponCode"];
    [self.navigationController pushViewController:InappPurchaseVC animated:YES];
}

//-(void) createCouponView
//{
//    couponView = [[UIView alloc] initWithFrame:CGRectMake(30, 214, 260, 140)];
//    couponView.hidden = NO;
//    couponView.layer.cornerRadius = 10;
//    couponView.layer.masksToBounds = YES;
//    [couponView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:couponView];
//    
//    UILabel *couponTitle = [[UILabel alloc] initWithFrame:CGRectMake(42, 14, 277, 21)];
//    couponTitle.text = @"Original Price :-   $ 100";
//    [couponView addSubview:couponTitle];
//    
//    enterCoupontxt = [[UITextField alloc] initWithFrame:CGRectMake(20, 55, 220, 30)];
//    enterCoupontxt.placeholder = @"Please enter your coupon";
//    enterCoupontxt.borderStyle=UITextBorderStyleRoundedRect;
//    enterCoupontxt.text=@"";
//    [couponView addSubview:enterCoupontxt];
//    
//    applyCoupon=[[UIButton alloc]initWithFrame:CGRectMake(5, 107, 125, 30)];
//    [applyCoupon setTitle:@"Apply Coupon" forState:UIControlStateNormal];
//    [applyCoupon setBackgroundColor:[UIColor whiteColor]];
//    applyCoupon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [applyCoupon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [applyCoupon addTarget:self action:@selector(applyCoupon) forControlEvents:UIControlEventTouchUpInside];
//    [couponView addSubview:applyCoupon];
//
//    continueBtn=[[UIButton alloc]initWithFrame:CGRectMake(133, 107, 120, 30)];
//    [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
//    [continueBtn setBackgroundColor:[UIColor whiteColor]];
//    [continueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [continueBtn addTarget:self action:@selector(continueWithoutCoupon) forControlEvents:UIControlEventTouchUpInside];
//    [couponView addSubview:continueBtn];
//}
//-(void) continueWithoutCoupon
//{
//    [self.view setUserInteractionEnabled:NO];
//    [enterCoupontxt resignFirstResponder];
//    couponView.hidden = YES;
//    InAppPurchaseViewController *InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
//    InappPurchaseVC.productCode = productCode;
//    [self.navigationController pushViewController:InappPurchaseVC animated:YES];
//}
//
//-(void)applyCoupon
//{
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//    [enterCoupontxt resignFirstResponder];
//    NSString *coupontxt = [NSString stringWithFormat:@"%@",enterCoupontxt.text];
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
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    // Use when fetching text data
//    NSString *responseString = [request responseString];
//    // NSXMLParser *parser=[[NSXMLParser alloc] init];
//    // [parser setDelegate:self];
//    NSLog(@"res of webservice 2:%@",responseString);
//   
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
//-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI
// qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict
//
//{
//    if ([elementName isEqualToString:@"coupon_code"])
//    {
//        
//        tempString = [[NSMutableString alloc] init];
//        
//    }else if ([elementName isEqualToString:@"expired"])
//    {
//        tempString = [[NSMutableString alloc] init];
//    }else if ([elementName isEqualToString:@"used"])
//    {
//        tempString = [[NSMutableString alloc] init];
//        
//    }else if ([elementName isEqualToString:@"product_code"])
//    {
//        tempString = [[NSMutableString alloc] init];
//        
//    }else if ([elementName isEqualToString:@"status"])
//    {
//        tempString = [[NSMutableString alloc] init];
//    }else if ([elementName isEqualToString:@"username"])
//    {
//        tempString = [[NSMutableString alloc] init];
//    }
//}
////---when the text in an element is found---
//-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
//{
//  [tempString appendString:string];  
//}
////---when the end of element is found---
//-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
// namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//    if([elementName isEqualToString:@"data"]){
//        
//    } else if ([elementName isEqualToString:@"expired"]){
//        couponExpire =  [NSString stringWithFormat:@"%@", tempString];
//        if ([couponExpire isEqualToString: @"true"]) {
//            isCouponExpired = YES;
//        }else{
//            isCouponExpired = NO;
//        }
//    }else if ([elementName isEqualToString:@"used"]){
//        couponUsed = [NSString stringWithFormat:@"%@", tempString];
//        if ([couponUsed isEqualToString:@"true"]) {
//            isCouponUsed = YES;
//        }else{
//            isCouponUsed = NO;
//        }
//    }else if ([elementName isEqualToString:@"product_code"]){
//        productCode = [NSString stringWithFormat:@"%@", tempString];
//        productCode = [productCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        
//    } else if ([elementName isEqualToString:@"status"]){
//        couponStatus = [NSString stringWithFormat:@"%@", tempString];
//        couponStatus = [couponStatus stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if ([couponStatus isEqualToString:@"success"]) {
//            if (!(isCouponExpired) && !(isCouponUsed)) {
//                InAppPurchaseViewController *InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
//                InappPurchaseVC.productCode = productCode;
//                [self.navigationController pushViewController:InappPurchaseVC animated:YES];
//                couponView.hidden = YES;
//            }
//        }else{
//            UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"Invalid  Coupon" message:@"Please confirm the coupon or Continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [PurchaseAlert show];
//        }
//    }
//}

-(void)fetchAvailableProducts
{
    NSSet *productIdentifiers = [NSSet
                                 setWithObject:@"com.Krishnais.TrueSecretsM"];
    productRequest = [[SKProductsRequest alloc]
                      initWithProductIdentifiers:productIdentifiers];
    productRequest.delegate = self;
    [productRequest start];
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}
- (void)purchaseMyProduct:(SKProduct*)product
{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}
- (IBAction)purchaseItem:(id)sender {
    [self purchaseMyProduct:[validProducts objectAtIndex:0]];
    // purchase.enabled = NO;
    
}

//~~~~~~~~~~~~~~~~~~~ Map Views~~~~~~~~~~~~~~~~~~~~~~~~~//

-(void)showMe1:(id)sender
{
    
    Bool_showMeMap =FALSE;
    
    if (!bool_showmap==TRUE)
    {
        showMeImage.hidden=YES;
        //mapView = [[MKMapView alloc]initWithFrame:CGRectMake(30, 220, 270 , 165)];
        //mapView.zoomEnabled=YES;
        //mapView.showsUserLocation=YES;
        
        //mapView.delegate = self;
        // [scrollView addSubview:mapView];
        [self cordinate];
        [self loadRoute];
        
        bool_showmap=TRUE;
        
        view_mapview1.hidden=NO;
        //        view_mapview2.hidden=NO;
        //        view_mapview3.hidden=NO;
        //        view_mapview4.hidden=NO;
        //        view_mapview5.hidden=NO;
        //        view_mapview6.hidden=NO;
        //        view_mapview7.hidden=NO;
        
        secondView1.hidden=YES;
        //        secondView2.hidden=YES;
        //        secondView3.hidden=YES;
        //        secondView4.hidden=YES;
        //        secondView5.hidden=YES;
        //        secondView6.hidden=YES;
        //        secondView7.hidden=YES;
        
        showMeWhere.hidden=NO;
        //        showMeWhere2.hidden=NO;
        //        showMeWhere3.hidden=NO;
        //        showMeWhere4.hidden=NO;
        //        showMeWhere5.hidden=NO;
        //        showMeWhere6.hidden=NO;
        //        showMeWhere7.hidden=NO;
        
        mapText1.hidden=NO;
        //        mapText2.hidden=NO;
        //        mapText3.hidden=NO;
        //        mapText4.hidden=NO;
        //        mapText5.hidden=NO;
        //        mapText6.hidden=NO;
        //        mapText7.hidden=NO;
        
        label_maplabelShow1.hidden=YES;
        //        label_maplabelShow2.hidden=YES;
        //        label_maplabelShow3.hidden=YES;
        //        label_maplabelShow4.hidden=YES;
        //        label_maplabelShow5.hidden=YES;
        //        label_maplabelShow6.hidden=YES;
        //        label_maplabelShow7.hidden=YES;
        
    }
    
    else{
        
        showMeImage=[[UIImageView alloc]init];
        // int mapTagValue=[ sender tag];
        label_maplabelShow1.hidden=NO;
        showMeWhere.hidden=YES;
        view_mapview1.hidden=YES;
        mapText1.hidden=YES;
        secondView1.hidden=NO;
        
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
            showMeImage.frame=CGRectMake(25, 220, 710, 165);
        }else
        {
            showMeImage.frame=CGRectMake(25, 220, 280, 165);
        }
        
        showMeImage.image=[UIImage imageNamed:@"show3.png"];
        /*
         break;
         case 2:
         label_maplabelShow2.hidden=NO;
         showMeWhere2.hidden=YES;
         view_mapview2.hidden=YES;
         mapText2.hidden=YES;
         secondView2.hidden=NO;
         showMeImage.frame=CGRectMake(660, 220, 280, 165);
         showMeImage.image=[UIImage imageNamed:@"show2.png"];
         break;
         case 3:
         label_maplabelShow3.hidden=NO;
         showMeWhere3.hidden=YES;
         view_mapview3.hidden=YES;
         mapText3.hidden=YES;
         secondView3.hidden=NO;
         showMeImage.frame=CGRectMake(980, 220, 280, 165);
         showMeImage.image=[UIImage imageNamed:@"show3.png"];
         break;
         case 4:
         label_maplabelShow4.hidden=NO;
         showMeWhere4.hidden=YES;
         view_mapview4.hidden=YES;
         mapText4.hidden=YES;
         secondView4.hidden=NO;
         showMeImage.frame=CGRectMake(1300, 220, 280, 165);
         showMeImage.image=[UIImage imageNamed:@"show4.png"];
         break;
         case 5:
         label_maplabelShow5.hidden=NO;
         showMeWhere5.hidden=YES;
         view_mapview5.hidden=YES;
         mapText5.hidden=YES;
         secondView5.hidden=NO;
         showMeImage.frame=CGRectMake(1620, 220, 280, 165);
         showMeImage.image=[UIImage imageNamed:@"show5.png"];
         
         break;
         case 6:
         label_maplabelShow6.hidden=NO;
         showMeWhere6.hidden=YES;
         view_mapview6.hidden=YES;
         mapText6.hidden=YES;
         secondView6.hidden=NO;
         showMeImage.frame=CGRectMake(1940, 220, 280, 165);
         showMeImage.image=[UIImage imageNamed:@"show6.png"];
         
         break;
         
         case 7:
         label_maplabelShow7.hidden=NO;
         showMeWhere7.hidden=YES;
         view_mapview7.hidden=YES;
         mapText7.hidden=YES;
         secondView7.hidden=NO;
         showMeImage.frame=CGRectMake(2260, 220, 280, 165);
         showMeImage.image=[UIImage imageNamed:@"show7.png"];
         
         break;
         
         default:
         break;
         
         }*/
        
        bool_showmap=false;
        
        [scrollView addSubview:showMeImage];
        
    }
    
    
    
}

/*-(void)showMe:(id)sender
 {
 showMeImage=[[UIImageView alloc]init];
 // int mapTagValue=[ sender tag];
 label_maplabelShow1.hidden=NO;
 showMeWhere.hidden=YES;
 view_mapview1.hidden=YES;
 mapText1.hidden=YES;
 secondView1.hidden=NO;
 showMeImage.frame=CGRectMake(25, 220, 280, 165);
 showMeImage.image=[UIImage imageNamed:@"show1.png"];
 bool_showmap=false;
 
 [scrollView addSubview:showMeImage];
 //
 //    bool_showmap=FALSE;
 //   // int playbutton4 =[sender tag];
 //    //NSLog(@"value=%d",playbutton4);
 //
 //    showMeImage=[[UIImageView alloc]init];
 //            label_maplabelShow1.hidden=NO;
 //            secondView1.hidden=NO;
 //            showMeWhere1.hidden=YES;
 //            view_mapview1.hidden=YES;
 //            mapText1.hidden=YES;
 //            showMeImage.frame=CGRectMake(35, 220, 280, 175);
 //            showMeImage.image=[UIImage imageNamed:@"show1.png"];
 /*
 break;
 case 2:
 
 label_maplabelShow2.hidden=NO;
 secondView2.hidden=NO;
 showMeWhere2.hidden=YES;
 view_mapview2.hidden=YES;
 mapText2.hidden=YES;
 showMeImage.frame=CGRectMake(660, 220, 280, 175);
 showMeImage.image=[UIImage imageNamed:@"show2.png"];
 break;
 
 
 case 3:
 
 label_maplabelShow3.hidden=NO;
 secondView3.hidden=NO;
 showMeWhere3.hidden=YES;
 view_mapview3.hidden=YES;
 mapText3.hidden=YES;
 showMeImage.frame=CGRectMake(980, 220, 280, 175);
 showMeImage.image=[UIImage imageNamed:@"show3.png"];
 
 break;
 case 4:
 
 label_maplabelShow4.hidden=NO;
 secondView4.hidden=NO;
 showMeWhere4.hidden=YES;
 view_mapview4.hidden=YES;
 mapText4.hidden=YES;
 showMeImage.frame=CGRectMake(1300, 220, 280, 175);
 showMeImage.image=[UIImage imageNamed:@"show4.png"];
 break;
 case 5:
 
 label_maplabelShow5.hidden=NO;
 secondView5.hidden=NO;
 showMeWhere5.hidden=YES;
 view_mapview5.hidden=YES;
 mapText5.hidden=YES;
 showMeImage.frame=CGRectMake(1620, 220, 280, 175);
 showMeImage.image=[UIImage imageNamed:@"show5.png"];
 
 break;
 case 6:
 //
 label_maplabelShow6.hidden=NO;
 secondView6.hidden=NO;
 showMeWhere6.hidden=YES;
 view_mapview6.hidden=YES;
 mapText6.hidden=YES;
 showMeImage.frame=CGRectMake(1940, 220, 280, 175);
 showMeImage.image=[UIImage imageNamed:@"show6.png"];
 break;
 case 7:
 label_maplabelShow7.hidden=NO;
 secondView7.hidden=NO;
 showMeWhere7.hidden=YES;
 view_mapview7.hidden=YES;
 mapText7.hidden=YES;
 showMeImage.frame=CGRectMake(2260, 220, 280, 175);
 showMeImage.image=[UIImage imageNamed:@"show7.png"];
 break;
 
 default:
 break;
 }
 
 
 
 [scrollView addSubview:showMeImage];
 
 
 
 
 
 }*/
- (void) cordinate
{
    logi=[[NSArray alloc]initWithObjects:@"-37.811546",@"-37.812302",@"-37.811386",@"-37.813545",@"-37.814861",@"-37.818253",@"-37.817566", nil];
    lati=[[NSArray alloc]initWithObjects:@"144.972137",@"144.969025",@"144.965103",@"144.964905",@"144.966461",@"144.957321",@"144.963211", nil];
    
    CLLocationCoordinate2D coordinateArray[15];
    
    coordinateArray[0] = CLLocationCoordinate2DMake(-37.811539, 144.972137);
    coordinateArray[1] = CLLocationCoordinate2DMake(-37.811661, 144.972183);
    coordinateArray[2] = CLLocationCoordinate2DMake(-37.811539, 144.972122);
    coordinateArray[3] = CLLocationCoordinate2DMake(-37.812302, 144.969513);
    coordinateArray[4] = CLLocationCoordinate2DMake(-37.811378, 144.969025);
    coordinateArray[5] = CLLocationCoordinate2DMake(-37.812180, 144.966415);
    coordinateArray[6] = CLLocationCoordinate2DMake(-37.812531, 144.965103);
    coordinateArray[7] = CLLocationCoordinate2DMake(-37.813541, 144.965546);
    coordinateArray[8] = CLLocationCoordinate2DMake(-37.813702, 144.965027);
    coordinateArray[9] = CLLocationCoordinate2DMake(-37.813530, 144.965607);
    coordinateArray[10] = CLLocationCoordinate2DMake(-37.814949, 144.966415);
    coordinateArray[11] = CLLocationCoordinate2DMake(-37.815380, 144.966461);
    coordinateArray[12] = CLLocationCoordinate2DMake(-37.817959, 144.957642);
    coordinateArray[13] = CLLocationCoordinate2DMake(-37.819069, 144.957977);
    coordinateArray[14] = CLLocationCoordinate2DMake(-37.817558, 144.963226);
    
    //    coordinateArray[0] = CLLocationCoordinate2DMake(-37.811546, 144.972137);
    //    coordinateArray[1] = CLLocationCoordinate2DMake(-37.812302, 144.969528);
    //    coordinateArray[2] = CLLocationCoordinate2DMake(-37.811386, 144.969025);
    //    coordinateArray[3] = CLLocationCoordinate2DMake(-37.812183, 144.966415);
    //    coordinateArray[4] = CLLocationCoordinate2DMake(-37.812531, 144.965103);
    //    coordinateArray[5] = CLLocationCoordinate2DMake(-37.813545, 144.965546);
    //    coordinateArray[6] = CLLocationCoordinate2DMake(-37.813885, 144.964447);
    //    coordinateArray[7] = CLLocationCoordinate2DMake(-37.814861, 144.964905);
    //    coordinateArray[8] = CLLocationCoordinate2DMake(-37.814529, 144.966049);
    //    coordinateArray[9] = CLLocationCoordinate2DMake(-37.815388, 144.966461);
    //    coordinateArray[10] = CLLocationCoordinate2DMake(-37.818089, 144.957321);
    //    coordinateArray[11] = CLLocationCoordinate2DMake(-37.818253, 144.956680);
    //    coordinateArray[12] = CLLocationCoordinate2DMake(-37.819302, 144.957199);
    //    coordinateArray[13] = CLLocationCoordinate2DMake(-37.817547, 144.963211);
    //    coordinateArray[14] = CLLocationCoordinate2DMake(-37.817566, 144.963242);
    
    routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:15];
    
    [mapView setVisibleMapRect:[routeLine boundingMapRect]];
    
    [mapView addOverlay:routeLine];
    
    currentLat = -37.811680; //You can set current latitude here.
    currentLong = 144.972183; //You can set current longitude here.
    
    desiredLatitude = -37.812157; //You can set destination latitude here.
    desiredLongitude = 144.966400; //You can set destination longitude here.
    
    //for annotation pin view on exact coordinate.
    CLLocationCoordinate2D c3;
    c3.latitude = -37.813702;
    c3.longitude = 144.965027;
    
    CLLocationCoordinate2D c6;
    c6.latitude = -37.814953;
    c6.longitude = 144.966431;
    
    CLLocationCoordinate2D c9;
    c9.latitude = -37.816734;
    c9.longitude = 144.961899;
    
    CLLocationCoordinate2D c10;
    c10.latitude = -37.817966;
    c10.longitude = 144.957626;
    
    CLLocationCoordinate2D c11;
    c11.latitude = -37.817554;
    c11.longitude = 144.963226;
    
    MKCoordinateRegion region;
    region.center.latitude = -37.813702;
    region.center.longitude = 144.965027;
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    mapView.region = region;
    
    DDAnnotation* myAnnotation12=[[DDAnnotation alloc] init];
    myAnnotation12.coordinate = c11;
    myAnnotation12.title=@"annotation7";
    annotation1=[[NSMutableArray alloc] init];
    
    theCoordinate.latitude = currentLat;
    theCoordinate.longitude = currentLong;
    
    DDAnnotation* myAnnotation=[[DDAnnotation alloc] init];
    myAnnotation.coordinate=theCoordinate;
    myAnnotation.title=@"annotation1";
    //   myAnnotation.subtitle=@"Current location";
    
    
    [mapView addAnnotation:myAnnotation];
    // [annotation1 addObject:myAnnotation];
    
    CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = desiredLatitude;
    theCoordinate1.longitude = desiredLongitude;
    
    DDAnnotation* myAnnotation1=[[DDAnnotation alloc] init];
    myAnnotation1.coordinate=theCoordinate1;
    myAnnotation1.title=@"annotation2";
    //   myAnnotation1.subtitle= @"Desired Location's Sub-title";
    
    DDAnnotation* myAnnotation4=[[DDAnnotation alloc] init];
    myAnnotation4.coordinate = c3;
    myAnnotation4.title=@"annotation3";
    
    DDAnnotation* myAnnotation7=[[DDAnnotation alloc] init];
    myAnnotation7.coordinate = c6;
    myAnnotation7.title=@"annotation4";
    
    DDAnnotation* myAnnotation10=[[DDAnnotation alloc] init];
    myAnnotation10.coordinate = c9;
    myAnnotation10.title=@"annotation5";
    
    DDAnnotation* myAnnotation11=[[DDAnnotation alloc] init];
    myAnnotation11.coordinate = c10;
    myAnnotation11.title=@"annotation6";
    
    mapView.scrollEnabled = NO;
    
    [mapView addAnnotation:myAnnotation1];
    //  [annotation1 addObject:myAnnotation1];
    
    
    [mapView addAnnotation:myAnnotation4];
    [mapView addAnnotation:myAnnotation7];
    [mapView addAnnotation:myAnnotation10];
    [mapView addAnnotation:myAnnotation11];
    [mapView addAnnotation:myAnnotation12];
    //    for (int m=0; m <7; m++)
    //    {
    //       // NSString *name=[lati objectAtIndex:m];
    //        NSNumber * latitude = [lati objectAtIndex:m];
    //
    //        NSNumber * longitude = [logi objectAtIndex:m];
    //        CLLocationCoordinate2D coordinate;
    //        coordinate.latitude = latitude.doubleValue;
    //        coordinate.longitude = longitude.doubleValue;
    //        DDAnnotation *annotation = [[DDAnnotation alloc] initWithName:@"ABC"  coordinate:coordinate] ;
    //        annotation.image = [UIImage imageNamed:[imagearray objectAtIndex:i]];
    //        [_mapView addAnnotation:annotation];
    //
    //    }
    
    
    
}
-(void) loadRoute
{
    
	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"http://truesecrets.com.au.s3.amazonaws.com/MapIcons/" ofType:@"kml"];
	NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	MKMapPoint northEastPoint;
	MKMapPoint southWestPoint;
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
	
	for(int idx = 1; idx < pointStrings.count; idx++)
	{
        NSString* currentPointString = [pointStrings objectAtIndex:idx];
        NSLog(@"point_string:%@", currentPointString);
        
		NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
		CLLocationDegrees latitude  = [[latLonArr objectAtIndex:0] doubleValue];
		CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        //        [mapView setCenterCoordinate:coordinate zoomLevel:13 animated:YES];
        
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else
		{
			if (point.x > northEastPoint.x)
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x)
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y)
				southWestPoint.y = point.y;
		}
        
		pointArr[idx] = point;
    }
	routeLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
	_routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
	free(pointArr);
}
-(void) zoomInOnRoute
{
	[mapView setVisibleMapRect:_routeRect];
}

- (void)checkInFacebookView:(id)sender
{
    
    int FBview = [sender tag];
    facebookView = [[facebookProfileView alloc]init];
    facebookView.page = [NSString stringWithFormat:@"%d",FBview];
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromRight;
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self presentModalViewController:facebookView animated:NO];
    
     [self.navigationController pushViewController:facebookView animated:YES];
}
- (void)checkInFoursquareView:(id)sender
{
    int FSview = [sender tag];
    foursquareShareView = [[fourSquareView alloc] init];
    foursquareShareView.page2 = [NSString stringWithFormat:@"%d",FSview];
    
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 0.3;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    transition.type = kCATransitionPush;
    //    transition.subtype = kCATransitionFromRight;
    //    [self.view.window.layer addAnimation:transition forKey:nil];
    //    [self presentModalViewController:foursquareShareView animated:NO];
    [self.navigationController pushViewController:foursquareShareView animated:YES];
}
- (void)checkInMapView:(id)sender
{
    googleplusView = [[googleplusShareView alloc] init];
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromRight;
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self presentModalViewController:googleplusView animated:NO];
    
    [self.navigationController pushViewController:googleplusView animated:YES];
}

- (void)shareButtonView:(id)sender
{
    NSMutableArray *activityItems = [NSMutableArray array];
    
    NSString *htmlBody = @"http://truesecrets.com.au";
    
    //  For Mail
    [activityItems addObject:[WHMailActivityItem mailActivityItemWithSelectionHandler:^(MFMailComposeViewController *mailController) {
        [mailController setSubject:@"An invite from TrueSecrets!"];
        [mailController setMessageBody:htmlBody isHTML:NO];
        mailController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }]];
    
    //  For texting
    [activityItems addObject:[WHTextActivityItem textActivityItemWithSelectionHandler:^(MFMessageComposeViewController *messageController) {
        [   messageController setBody:@"My super awesome message for texting only!"];
        messageController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }]];
    
    [activityItems addObject:@"http://truesecrets.com.au"];
    
    NSArray *activities = (@[
                           [[WHMailActivity alloc] init],
                           [[WHTextActivity alloc] init]
                           ]);
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                     applicationActivities:activities];
    activityController.excludedActivityTypes = (@[
                                                UIActivityTypeAssignToContact,
                                                UIActivityTypeMail,
                                                UIActivityTypeMessage,
                                                UIActivityTypePrint,
                                                UIActivityTypeSaveToCameraRoll,
                                                UIActivityTypePostToWeibo
                                                ]);
    
    [self presentViewController:activityController animated:YES completion:NULL];
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
                MytableView = [[UITableView alloc] initWithFrame:CGRectMake(95, 373 , 130, 160)];
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
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"Purchased"])
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
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"Purchased"])
    {
    if(indexPath.row<3)
    {
        CATransition *leftTransition = [CATransition animation];
        leftTransition.duration = 0.3;
        leftTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        leftTransition.type = kCATransitionPush;
        leftTransition.subtype = kCATransitionFromLeft;
        
        
        if(indexPath.row==0)
        {
            [self.navigationController.view.layer addAnimation:leftTransition
                                                        forKey:kCATransition];
            
            [self.navigationController pushViewController:secretvc1 animated:NO];
        }else if(indexPath.row==1)
        {
            [self.navigationController.view.layer addAnimation:leftTransition
                                                        forKey:kCATransition];
            
            [self.navigationController pushViewController:secretvc2 animated:NO];
        }
        
    }else {
        CATransition *rightTransition = [CATransition animation];
        rightTransition.duration = 0.3;
        rightTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rightTransition.type = kCATransitionPush;
        rightTransition.subtype = kCATransitionFromRight;
        
        
        if(indexPath.row==3)
        {
            [self.navigationController.view.layer addAnimation:rightTransition
                                                        forKey:kCATransition];
            
            [self.navigationController pushViewController:secretvc4 animated:NO];
            
        }else if(indexPath.row==4)
        {
            [self.navigationController.view.layer addAnimation:rightTransition
                                                        forKey:kCATransition];
            
            [self.navigationController pushViewController:secretvc5 animated:NO];
            
        }else if(indexPath.row==5)
        {
            [self.navigationController.view.layer addAnimation:rightTransition
                                                        forKey:kCATransition];
            
            [self.navigationController pushViewController:secretvc6 animated:NO];
            
        }else if(indexPath.row==6)
        {
            [self.navigationController.view.layer addAnimation:rightTransition
                                                        forKey:kCATransition];
            
            [self.navigationController pushViewController:secretvc7 animated:NO];
        }
    }
    }else{
        if (indexPath.row != 2) {
        //[self popupView];
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
    [MytableView setHidden:YES];
    MytableView = NULL;
        
        
    
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%g",
                                 newLocation.coordinate.latitude];
    //latitude.text = currentLatitude;
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    //longitude.text = currentLongitude;
    
    NSString *currentHorizontalAccuracy =
    [[NSString alloc]
     initWithFormat:@"%g",
     newLocation.horizontalAccuracy];
    //horizontalAccuracy.text = currentHorizontalAccuracy;
    
    NSString *currentAltitude = [[NSString alloc]
                                 initWithFormat:@"%g",
                                 newLocation.altitude];
    //altitude.text = currentAltitude;
    //[currentAltitude release];
    
    NSString *currentVerticalAccuracy =
    [[NSString alloc]
     initWithFormat:@"%g",
     newLocation.verticalAccuracy];
    //verticalAccuracy.text = currentVerticalAccuracy;
    
    if (myLocation == nil)
        myLocation = newLocation;
    
    CLLocationDistance distanceBetween = [newLocation
                                          distanceFromLocation:myLocation];
    
    NSString *tripString = [[NSString alloc]
                            initWithFormat:@"%f",
                            distanceBetween];
    //distance.text = tripString;
    
    //    [currentLatitude release];
    //    [currentLongitude release];
    //    [currentHorizontalAccuracy release];
    //    [currentVerticalAccuracy release];
    //    [tripString release];
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
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    
    //    self.masterAudioPlayer=nil;
    //    self.bgAudioPlayer=nil;
    //    self.bonusAudioPlayer=nil;
    //    self.welcomeAudioPlayer=nil;.
    //    self.thanksAudioPlayer=nil;
    [getBackgroundSoundButton1 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [getBonusBtn2 setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [playButton1 setImage:[UIImage imageNamed:@"play_main-1.png"] forState:UIControlStateNormal];
    
    
}
-(void) popupView
{
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        
        PopView = [[UIView alloc]initWithFrame:CGRectMake(90, 200, 580, 435)];
        PopView.backgroundColor = [UIColor whiteColor];
        
        PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        PopView.layer.cornerRadius=10;
        PopView.clipsToBounds=YES;
        [self.view addSubview: PopView];
        
        cancelbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        cancelbtn.frame = CGRectMake(0, 0, 64, 64);
        [cancelbtn addTarget:self action:@selector(cancelbtnaction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelbtn setBackgroundColor:[UIColor blackColor]];
        [cancelbtn setImage:[UIImage imageNamed:@"cancel-button-icon.png"] forState:UIControlStateNormal];
        [PopView addSubview:cancelbtn];
        
        UILabel *Poplbl =[[UILabel alloc]init];
        Poplbl.frame = CGRectMake(20, 20, 530, 200);
        Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
        Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
        Poplbl.numberOfLines = 4;
        [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:32]];
        [PopView addSubview:Poplbl];
        
        UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
        popbtn1.frame = CGRectMake(20, 270, 530, 40);
        [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
        popbtn1.titleLabel.numberOfLines=1;
        [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
        [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
        popbtn1.layer.cornerRadius=10;
        popbtn1.clipsToBounds=YES;
        [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
        
        [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [PopView addSubview:popbtn1];
        
        
        UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
        popbtn2.frame = CGRectMake(20, 320, 530, 40);
        [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
        popbtn2.titleLabel.numberOfLines=1;
        [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:22]];
        [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
        popbtn2.layer.cornerRadius=10;
        popbtn2.clipsToBounds=YES;
        [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
        
        [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [PopView addSubview:popbtn2];
        
        
        UIButton* popbtn3 =[UIButton buttonWithType:UIButtonTypeCustom];
        popbtn3.frame = CGRectMake(15, 370, 260, 30);
        [popbtn3 setTitle:@"I already own the app?" forState:UIControlStateNormal];
        popbtn3.titleLabel.numberOfLines=1;
        [[popbtn3 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:26]];
        [popbtn3 addTarget:self action:@selector(popbtnaction3:) forControlEvents:UIControlEventTouchUpInside];
        popbtn3.layer.cornerRadius=10;
        popbtn3.clipsToBounds=YES;
        [popbtn3 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
        [popbtn3 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [PopView addSubview:popbtn3];
        
        
        [scrollView bringSubviewToFront:PopView];
    }else{
        
        PopView = [[UIView alloc]initWithFrame:CGRectMake(15, 170, 290, 260)];
        PopView.backgroundColor = [UIColor whiteColor];
        
        PopView.layer.borderColor = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
        PopView.layer.cornerRadius=10;
        PopView.clipsToBounds=YES;
        [self.view addSubview:PopView];
        
        cancelbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        cancelbtn.frame = CGRectMake(290, 152, 32, 32);
        [cancelbtn addTarget:self action:@selector(cancelbtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelbtn setBackgroundColor:[UIColor clearColor]];
        [cancelbtn setImage:[UIImage imageNamed:@"cancel-button-icon.png"] forState:UIControlStateNormal];
        [self.view addSubview:cancelbtn];
        
        UILabel *Poplbl =[[UILabel alloc]init];
        Poplbl.frame = CGRectMake(15, 15, 275, 125);
        Poplbl.textColor = [UIColor colorWithRed:5.0f/255.0f green:154.0f/255.0f blue:224.0f/255.0f alpha:1.0f];
        
        Poplbl.text = @"To experience the full True Secrets tour you need to purchase access to the audio files";
        Poplbl.numberOfLines = 4;
        [Poplbl setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:21]];
        [PopView addSubview:Poplbl];
        
        UIButton* popbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
        popbtn1.frame = CGRectMake(15, 150, 260, 30);
        [popbtn1 setTitle:@"I have a coupon/ voucher" forState:UIControlStateNormal];
        popbtn1.titleLabel.numberOfLines=1;
        [[popbtn1 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
        [popbtn1 addTarget:self action:@selector(popbtnaction1:) forControlEvents:UIControlEventTouchUpInside];
        popbtn1.layer.cornerRadius=10;
        popbtn1.clipsToBounds=YES;
        [popbtn1 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
        
        [popbtn1 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [PopView addSubview:popbtn1];
        
        
        UIButton* popbtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
        popbtn2.frame = CGRectMake(15, 185, 260, 30);
        [popbtn2 setTitle:@"I do not have a coupon/ voucher" forState:UIControlStateNormal];
        popbtn2.titleLabel.numberOfLines=1;
        [[popbtn2 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:17]];
        [popbtn2 addTarget:self action:@selector(popbtnaction2:) forControlEvents:UIControlEventTouchUpInside];
        popbtn2.layer.cornerRadius=10;
        popbtn2.clipsToBounds=YES;
        [popbtn2 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
        
        [popbtn2 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [PopView addSubview:popbtn2];
        
        UIButton* popbtn3 =[UIButton buttonWithType:UIButtonTypeCustom];
        popbtn3.frame = CGRectMake(15, 220, 260, 30);
        [popbtn3 setTitle:@"I already own the app?" forState:UIControlStateNormal];
        popbtn3.titleLabel.numberOfLines=1;
        [[popbtn3 titleLabel] setFont:[UIFont fontWithName:@"IM FELL DW Pica SC" size:19]];
        [popbtn3 addTarget:self action:@selector(popbtnaction3:) forControlEvents:UIControlEventTouchUpInside];
        popbtn3.layer.cornerRadius=10;
        popbtn3.clipsToBounds=YES;
        [popbtn3 setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f]];
        [popbtn3 setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        popbtn3.tag=1;
        
        [PopView addSubview:popbtn3];
        
        scrollView.userInteractionEnabled = NO;
        
        [scrollView bringSubviewToFront:PopView];
        
        
        
        
    }
}

-(IBAction)cancelbtnAction:(id)sender
{
    scrollView.userInteractionEnabled = YES;
    [PopView removeFromSuperview];
    cancelbtn.hidden = YES;
}
-(IBAction)popbtnaction1:(id)sender
{
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
//    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollviewheight);
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

    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    if (!receipt) {
        SKReceiptRefreshRequest * request = [[SKReceiptRefreshRequest alloc] init];
        request.delegate = self;
        [request start];
    }
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}



-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"%lu items restored", (unsigned long)queue.transactions.count);
    
    NSString*Str=[NSString stringWithFormat:@"%lu",(unsigned long)queue.transactions.count];
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    if (receipt) {
        
        // [Delegate transactionDidRestorePurchaseSuccessfullyWithReciept:receipt];
    }
    else{
        // [Delegate transactionDidFail];
    } int count = 0;
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        
        NSString *productID = transaction.payment.productIdentifier;
        if (transaction.transactionState == 3   ) {
            count++;
        }
        NSLog(@"items restored %ld", (long)transaction.transactionState);
    }
    if (count > 0) {
        NSLog(@"Restore Successful");
    }else{
        NSString *str=@"You do not owned this app sorry.";
        UIButton *buttonThree = (UIButton *)[PopView viewWithTag:1];
        [buttonThree setTitle:str forState:UIControlStateNormal];
        [buttonThree setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [buttonThree setBackgroundColor:[UIColor clearColor]];
        
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    if ([error.domain isEqual:SKErrorDomain] && error.code == SKErrorPaymentCancelled)
    {
        return;
    }
    
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



//Then this delegate Function Will be fired
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                // user has purchased
                //                [self saveTransactionReceipt:transaction];
                //                [self unlockFullVersion];
                // download content here if necessary
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
            }
                
            case SKPaymentTransactionStateFailed: {
                // transaction didn't work
                NSLog(@"failed restore");
                // [self displayAlertViewWithMessage:@"There was a problem with your purchase. Please try again later."];
                break;
            }
                
            case SKPaymentTransactionStateRestored: {
                // purchase has been restored
                [self displayAlertViewWithMessage:@"Successfully restored your purchase"];
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
            }
                
                
            case SKPaymentTransactionStatePurchasing: {
                // currently purchasing
                break;
            }
                
            default:
                break;
        }
    }
}

- (void)displayAlertViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertView.tag = 1;
    [alertView show];
}

@end
