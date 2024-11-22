//
//  CustomCuponViewController.h
//  TrueSecretsM
//
//  Created by Krishna_Mac_1 on 9/4/14.
//  Copyright (c) 2014 whatwasthat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurchaseViewController.h"
@protocol protocolname <NSObject>

-(void)buttonCallBack:(id)obj;
@end



@class InAppPurchaseViewController;


@interface CustomCuponViewController : UIView <UITextFieldDelegate,NSXMLParserDelegate,UIAlertViewDelegate>

{
    NSString *couponStatus, *couponUsed, *couponExpire, *productCode, *tempstr;
    BOOL isCouponExpired, isCouponUsed;
    NSMutableString *tempString;
    UITextField *couponAlertTextField;
    
}
@property (nonatomic,strong)UIView *couponView;
@property (nonatomic , strong)UITextField *enterCoupontxt;
@property (nonatomic, strong) UIButton *applyCoupon;
@property (nonatomic, strong) UIButton *continueBtn;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
@property(assign, atomic)id<protocolname>delegate;
-(void)applyCoupons;
-(void)addCupon;
@property (strong, nonatomic) NSString *openURL,*couponCode;

@end
