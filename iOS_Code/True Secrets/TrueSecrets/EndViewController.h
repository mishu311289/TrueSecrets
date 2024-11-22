//
//  EndViewController.h
//  TrueSecretsMelbourne
//
//  Created by Krishna_Mac on 9/11/13.
//  Copyright (c) 2013 whatwasthat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import"CustomCuponViewController.h"
#import "MBProgressHUD.h"

@interface EndViewController : UIViewController<UIScrollViewDelegate, AVAudioPlayerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, MKOverlay,MKAnnotation,UITextFieldDelegate,NSXMLParserDelegate, UIGestureRecognizerDelegate>

{
    
    NSMutableString *tempString;
    NSString *tested;
    UIView *backView;
    MBProgressHUD *hud;
    UIActivityIndicatorView *activityIndicatorView;
    CustomCuponViewController *customViewObj;
    UIView *emailForm;
    BOOL bool_showCoupon;
    UIView *aboutView;
    UIButton *btn_clickCoupon;
    UILabel *couponText;
    UIButton *btn_signUp;
    UIView *emailView,*PopView;
    UIButton *btn_signUp_temp;
    UIButton *btn_submit;
    UILabel *textView;
    UIButton *btn_cuppon;
    UITextField *text_Name;
    UILabel *lbl_Name;
    UITextField *text_Password;
    UILabel *lbl_password;
    UITextField *emailTxt;
    UITextField *nameTxt;
    int webservice;
    NSMutableData *webData;

}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *aboutView;
@property (strong, nonatomic) UIButton *btn_clickCoupon;
@property (strong, nonatomic) UILabel *couponText;
@property (strong, nonatomic) UIButton *btn_signUp;
@property (strong, nonatomic) UIView *emailView;
@property (strong, nonatomic) UIButton *btn_signUp_temp;
@property (strong, nonatomic) UIButton *btn_submit;
@property (strong, nonatomic) UILabel *textView;
@property (strong, nonatomic) UIButton *btn_cuppon;
@property (strong, nonatomic) UITextField *text_Name;
@property (strong, nonatomic) UILabel *lbl_Name;
@property (strong, nonatomic) UILabel *lbl_Heading;
@property (strong, nonatomic)  UITextField *text_Password;
@property (strong, nonatomic) UILabel *lbl_password;
@end
