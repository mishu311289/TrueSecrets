//
//  AppDelegate.m
//  True Secrets
//
//  Created by Krishna_Mac on 9/9/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//
#import "ACTReporter.h"
#import "AppDelegate.h"
#import "iRate.h"
@implementation AppDelegate
@synthesize welcome,navigationController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Enable automated usage reporting.
    [ACTAutomatedUsageTracker enableAutomatedUsageReportingWithConversionID:@"1012268842"];
    
    [ACTConversionReporter reportWithConversionID:@"1012268842" label:@"4lVHCOqSr2EQqv7X4gM" value:@"0.00" isRepeatable:NO];
    
    // Enable automated usage reporting.
    [ACTAutomatedUsageTracker enableAutomatedUsageReportingWithConversionID:@"1012268842"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
  //  [[NSUserDefaults standardUserDefaults]setObject:@"Purchased" forKey:@"Products"];
    if(result.height == 480)
    {
        iphone4=YES;
        
        welcome=[[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
        
    }
    else if(result.height == 568)
    {
        iphone5=YES;
        welcome=[[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController_iPhone" bundle:nil];
       
        
    }
    else if(result.height==1024)
    {
        ipad=YES;
        welcome=[[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController_ipad" bundle:nil];
    }
    else if(result.height == 640)
    {
        iphoneretina = YES;
        welcome = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController_retina" bundle:nil];
    }
        
    navigationController=[[UINavigationController alloc]initWithRootViewController:self.welcome];
    self.window.rootViewController =navigationController;

    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    [AppDelegate initialize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification1:)
                                                 name:@"TestNotification1"
                                               object:nil];
    return YES;
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    InAppPurchaseViewController *InappPurchaseVC;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
    }else{
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    }
    
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults]valueForKey:@"dict"];
    InappPurchaseVC.productCode = [[NSUserDefaults standardUserDefaults]valueForKey:@"Pcode"];
    InappPurchaseVC.openURL = @"yes";
    //InappPurchaseVC.productCode = [dict valueForKey:@"com.Krishnais.TrueSecretsM.TrueSecrets"];
    InappPurchaseVC.couponCode = [[NSUserDefaults standardUserDefaults]valueForKey:@"Ccode"];
    
    [self.navigationController pushViewController:InappPurchaseVC animated:YES];
}
- (void) receiveTestNotification1:(NSNotification *) notification
{
    InAppPurchaseViewController *InappPurchaseVC;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
    }else{
        InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    }
    InappPurchaseVC.productCode = @"TS_1900";
    InappPurchaseVC.failedURl = @"yes";
     [self.navigationController pushViewController:InappPurchaseVC animated:YES];
}
+ (void)initialize
{
    //configure iRate
//    iRate *obj = [[iRate alloc]init];
    [iRate sharedInstance].previewMode = NO;
    [iRate sharedInstance].appStoreID = 734212006;
    [iRate sharedInstance].daysUntilPrompt = 3;
    [iRate sharedInstance].usesUntilPrompt = 3;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{   //?token=123abct&registered=1"
   
        NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
        NSLog(@"URL scheme:%@", [url scheme]);
        NSLog(@"URL query: %@", [url query]);
        
    NSArray *first = [[url query] componentsSeparatedByString:@"="];
    NSArray *second = [[first objectAtIndex:1] componentsSeparatedByString:@"&"];
    
    NSString *couponCode = [second objectAtIndex:0];
    
    CustomCuponViewController *customViewObj = [[CustomCuponViewController alloc]init];
    customViewObj.delegate=self;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:couponCode forKey:@"code"];
    
    NSLog( @"%@",[user valueForKey:@"code"]);
    productCode = @"TS_1900";
    [self fetchAvailableProducts];
    
    customViewObj.openURL = @"yes";
    customViewObj.couponCode = couponCode;
    [customViewObj applyCoupons];
    
    
    
    
    return YES;
}
-(void)fetchAvailableProducts
{
    NSLog(@"111111");
    if (productCode!=NULL)
    {
        NSSet *productIdentifiers = [NSSet
                                     setWithObjects:productCode,nil];
        productRequest = [[SKProductsRequest alloc]
                          initWithProductIdentifiers:productIdentifiers];
        productRequest.delegate = self;
        [productRequest start];
    }
    
}
- (BOOL)canMakePurchases
{
    NSLog(@"222222");
    
    
    return [SKPaymentQueue canMakePayments];
}
- (void)purchaseMyProduct:(SKProduct*)product
{
    NSLog(@"3333333");
    
    NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
    if([[value objectForKey:@"Products"] isEqualToString:@"Purchased"])
    {
        return;
    }
    
    
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
#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions
{
    NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
    if([[value objectForKey:@"Products"] isEqualToString:@"Purchased"])
    {
        return;
    }
    
    
    
    
    NSLog(@"444444444");
    NSString *status = @"Purchased";
    //   NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
    //    [value setValue:@"NotPurchased" forKey:@"Products"];
    for (SKPaymentTransaction *transaction in transactions)
    {
        // NSLog(@"%d",transaction.transactionState);
        // NSLog(@"%@",transaction.payment.productIdentifier);
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"%ld",(long)SKPaymentTransactionStatePurchasing);
                
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                //          NSLog(@"%ld",(long)SKPaymentTransactionStatePurchased);
                //           NSLog(transaction.payment.productIdentifier);
                //            NSLog(kTutorialPointProductID);
                //             if ([transaction.payment.productIdentifier
                //                   isEqualToString:kTutorialPointProductID]
                
                if ([transaction.payment.productIdentifier
                     isEqualToString:productCode])
                {
                    NSLog(@"Purchased ");
                    //                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                    //                                              @"Purchase is completed successfully" message:nil delegate:
                    //                                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    //
                    //                    alertView.tag=2;
                    //                    [alertView show];
                    WelcomeViewController * obj = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
                    [self.navigationController pushViewController:obj animated:YES];
                    
                    
                    [value setValue:@"Purchased" forKey:@"Products"];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:status forKey:@"Products"];
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    
                    
                    
                }
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored ");
                NSLog(@"%ld",(long)SKPaymentTransactionStateRestored);
                
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                
                NSLog(@"Purchase failed ");
                if ([transaction.payment.productIdentifier
                     isEqualToString:productCode])
                {
                                    }
               
                
                NSLog(@"%ld",(long)SKPaymentTransactionStateFailed);
                break;
            default:
                break;
        }
    }
}
-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"55555555555");
    
    NSMutableArray *ProductsArray=[[NSMutableArray alloc] init];
    
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if (count>0) {
        validProducts = response.products;
        for (int i=0; i<[validProducts count]; i++) {
            //  if ([validProduct.productIdentifier
            //  isEqualToString:kTutorialPointProductID]||[validProduct.productIdentifier
            // isEqualToString:kTutorialPointProductID2])
            // {
            NSMutableDictionary *productDict=[[NSMutableDictionary alloc] init];
            
            validProduct = [response.products objectAtIndex:i];
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [numberFormatter setLocale:validProduct.priceLocale];
            NSString *formattedPriceString = [numberFormatter stringFromNumber:validProduct.price];
            
            
            //-----return object
            [productDict setValue:[NSString stringWithFormat:@"%@",validProduct.localizedTitle] forKey:@"Pname"];
            [productDict setValue:[NSString stringWithFormat:@"%@",validProduct.localizedDescription] forKey:@"Pdesc"]                    ;
            [productDict setValue:[NSString stringWithFormat:@"%@",formattedPriceString] forKey:@"Pprice"];
            //-------
            NSString *abc = [NSString stringWithFormat:@"%@",formattedPriceString];
            [[NSUserDefaults standardUserDefaults]setObject:abc forKey:@"pricee"];
        }
    }     //1
    
}
@end
