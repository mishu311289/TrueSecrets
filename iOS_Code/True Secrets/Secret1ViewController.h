//
//  Secret1ViewController.h
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KMLParser.h"
#import "RegexKitLite.h"
#import "FTWebService.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "CustomCuponViewController.h"



@interface Secret1ViewController : UIViewController <UIScrollViewDelegate, AVAudioPlayerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, MKOverlay,MKAnnotation,UITextFieldDelegate,NSXMLParserDelegate, UIGestureRecognizerDelegate,UIAlertViewDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver,protocolname>

{
    
  /*  UIButton *getBackgroundSoundButton1;
    UIButton *getBackgroundSoundButton2;
    UIButton *playButton1;
    UIButton *getBonusBtn2;
    UIButton *thanksPlaybtn;
    UIButton *showMeWhere;
    NSString *value;
    NSMutableArray *backgroundSoundList,*soundList,*bonusMeterial;
    NSString *musicplayfile,*backgroundMusicFile;;
    UIImageView *showMeImage;
    IBOutlet UIView *view_mapview1,*view_mapview2,*view_mapview3,*view_mapview4,*view_mapview5,*view_mapview6,*view_mapview7;
    IBOutlet UIView  *secondView1,*secondView2,*secondView3,*secondView4,*secondView5,*secondView6,*secondView7;
    IBOutlet UIView  *view_secondView1,*view_secondView2,*view_secondView3,*view_secondView4,*view_secondView5,*view_secondView6,*view_secondView7;
    UIButton *showMeWhere1,*showMeWhere2,*showMeWhere3,*showMeWhere4,*showMeWhere5,*showMeWhere6,*showMeWhere7;
    UILabel *mapText1,*mapText2,*mapText3,*mapText4,*mapText5,*mapText6,*mapText7;
    UILabel *label_maplabelShow1,*label_maplabelShow2,*label_maplabelShow3,*label_maplabelShow4,*label_maplabelShow5,*label_maplabelShow6,*label_maplabelShow7;
    MKPolylineView* _routeLineView;
    MKPolyline *routeLine;
    BOOL bonusValue,backgroundvalue,mainPlayValue,thanksvalue;
    BOOL Bool_showMeMap, bool_showmap;
    NSArray *logi,*lati;
    IBOutlet MKMapView *mapView;
    double currentLat;
    double currentLong;
    double desiredLatitude;
    double desiredLongitude;
    NSMutableArray *annotation1;
    CLLocationCoordinate2D theCoordinate;
    MKMapRect _routeRect;

    //NSString *backgroundMusicFile;
    */
    NSMutableString *tempString;
    SKProductsRequest *productRequest;
    NSArray *validProducts;
    UIActivityIndicatorView *activityIndicatorView;
    NSString *couponStatus, *couponUsed, *couponExpire, *productCode;
    BOOL isCouponExpired, isCouponUsed;
    UIView *backGroundView,*PopView;
}
//@property (strong, nonatomic) Secret1ViewController *secret1;
//@property (strong, nonatomic) Secret2ViewController *secret2;
//@property (strong, nonatomic) WelcomeViewController *welcome;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) MKPolylineView *routeLineView;
@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, strong) AVAudioPlayer *masterAudioPlayer,*bonusAudioPlayer,*bgAudioPlayer,*thanksAudioPlayer,*welcomeAudioPlayer;
@property (nonatomic,strong)UIView *couponView;
@property (nonatomic , strong)UITextField *enterCoupontxt;
@property (nonatomic, strong) UIButton *applyCoupon;
@property (nonatomic, strong) UIButton *continueBtn;
@property (nonatomic , strong) NSMutableArray *soundlist, *bonusMeterial;
@property (strong, nonatomic) UIWindow *window;

-(MKOverlayView *)mapView2:viewForOverlay;

-(void) createCouponView;
- (void)getProductInfo:(UIViewController *)viewController;

@end
