//
//  AppDelegate.h
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    WelcomeViewController *welcome;
   
    UINavigationController *navigationController;
    BOOL iphone4 ;
    BOOL iphone5 ;
    BOOL ipad,iphoneretina;
    NSString *productCode;
    SKProductsRequest *productRequest;
     NSArray *validProducts;
    CLLocationManager   * locationManager;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WelcomeViewController *welcome;
@property (strong, nonatomic) UINavigationController *navigationController;
+ (void)initialize;

@end
