//
//  WelcomeViewController.h
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KMLParser.h"
#import "RegexKitLite.h"
#import "FTWebService.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "InAppPurchaseViewController.h"
#import "EBPurchase.h"
#import "CustomCuponViewController.h"
#import <StoreKit/StoreKit.h>


@interface WelcomeViewController : UIViewController<UIScrollViewDelegate, AVAudioPlayerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, MKOverlay,MKAnnotation,UITextFieldDelegate,NSXMLParserDelegate, UIGestureRecognizerDelegate,EBPurchaseDelegate,UITextFieldDelegate,protocolname,SKProductsRequestDelegate,SKPaymentTransactionObserver>

{
    CustomCuponViewController *customViewObj;
    UIScrollView *scrollView;
    UIImageView *backgroundImg,*backgroundImgNew;
    UIImageView *logoImage;
    UIButton *welcomePlayImage;
    AVAudioPlayer *welcomeAudioPlayer;
    NSString *check_status;
    BOOL toggle;
    EBPurchase* demoPurchase;    
    BOOL isPurchased;
    UIView *firstView,*secondView,*PopView;
     NSMutableString *tempString;
    NSString *couponStatus, *couponUsed, *couponExpire, *productCode, *user_Confirmed;
    BOOL isCouponExpired, isCouponUsed;
    int scrollviewheight;
}
//@property (weak, nonatomic) IBOutlet UIView *firstView;
//@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)  UIButton *welcomePlayImage , *cancelbtn;
@property (nonatomic,strong)  AVAudioPlayer *welcomeAudioPlayer;
@property (strong, nonatomic) IBOutlet UITextField *enterCouponTxt;
@property (strong, nonatomic) IBOutlet UIView *couponView;
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;
- (IBAction)applyCoupon:(id)sender;
-(IBAction)popbtnaction3:(id)sender;
-(IBAction)cancelbtnAction1:(id)sender;

- (IBAction)contiueWithoutCoupon:(id)sender;



@end
