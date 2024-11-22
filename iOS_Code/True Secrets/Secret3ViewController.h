//
//  Secret3ViewController.h
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KMLParser.h"
#import "RegexKitLite.h"
#import "FTWebService.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "CustomCuponViewController.h"

@interface Secret3ViewController : UIViewController<UIScrollViewDelegate, AVAudioPlayerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, MKOverlay,MKAnnotation,UITextFieldDelegate,NSXMLParserDelegate, UIGestureRecognizerDelegate,UIAlertViewDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver,protocolname>

{
    SKProductsRequest *productRequest;
    NSArray *validProducts;
    UIActivityIndicatorView *activityIndicatorView;
    NSString *couponStatus, *couponUsed, *couponExpire, *productCode;
    BOOL isCouponExpired, isCouponUsed;
    NSMutableString *tempString;
    UIButton *continueBtn;
    UIView *backGroundView,*PopView;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIView *couponView;
@property (nonatomic , strong)UITextField *enterCoupontxt;
@property (nonatomic, strong) UIButton *applyCoupon, *cancelbtn;
- (void)getProductInfo:(UIViewController *)viewController;


@end
