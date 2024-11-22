//
//  InAppPurchaseViewController.m
//  TrueSecretsM
//
//  Created by Krishna_Mac_1 on 8/6/14.
//  Copyright (c) 2014 whatwasthat. All rights reserved.
//

#import "InAppPurchaseViewController.h"
#import "WelcomeViewController.h"
#define kTutorialPointProductID @"com.Krishnais.TrueSecretsM.PurchaseAllAudios"
#define kTutorialPointProductID2 @"com.Krishnais.TrueSecretsM.newsong"
#define kTutorialPointProductID3 @"com.Krishnais.TrueSecretsM.MoreSongs"
#define kTutorialPointProductID4 @"TS1900"
#import "MBProgressHUD.h"
#import "ACTReporter.h"


@interface InAppPurchaseViewController ()

@end

@implementation InAppPurchaseViewController
@synthesize purchase,SangNameLabel,SongDescriptionLabel,SongsPriceLabel,OriginalPriceLbl,couponDiscountTitle,priceAfterTitle,productCode;
MBProgressHUD *hud;

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
    
    _price = [[NSString alloc]init];
    
    i=0;
    self.lblerror.hidden = YES;
    
    if([_fromWelcome isEqualToString:@"yes"])
    {
        SangNameLabel.hidden = YES;
        OriginalPriceLbl.hidden = YES;
        couponDiscountTitle.text = @"Price :";
        SongDescriptionLabel.hidden = NO;
        
        priceAfterTitle.hidden = YES;
        SongsPriceLabel.hidden = YES;
    }

     if([_openURL isEqualToString:@"yes"])
     {
         SangNameLabel.text = @"Orignal Price :";
         OriginalPriceLbl.text = @"";
         couponDiscountTitle.text = @"Discounted Price :";
         SongDescriptionLabel.text = @"";
         
         priceAfterTitle.hidden = YES;
         SongsPriceLabel.hidden = YES;
     }
   
    check_for_produts_available = @"";
    [super viewDidLoad];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    OriginalPriceLbl.text = @" ";
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgfinal.png"]];
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        SangNameLabel.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:32];
    }else{
        SangNameLabel.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:18];
    }
    SangNameLabel.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        SongDescriptionLabel.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:32];
    }else{
        SongDescriptionLabel.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:18];
    }
    SongDescriptionLabel.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
        OriginalPriceLbl.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:32];
    }else{
        OriginalPriceLbl.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:18];
    }
    OriginalPriceLbl.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            couponDiscountTitle.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:32];
        }else{
            couponDiscountTitle.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:18];
        }
    
    couponDiscountTitle.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
            priceAfterTitle.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:32];
        }
        else{
            priceAfterTitle.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:18];
        }
    
    priceAfterTitle.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

            if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
                SongsPriceLabel.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:32];
            }else{
                SongsPriceLabel.font = [UIFont fontWithName:@"IM FELL DW Pica SC" size:18];
            }
    SongsPriceLabel.textColor= [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

    purchase.layer.cornerRadius=14;
    purchase.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    
    self.btnrestoreExistingPurchase.layer.cornerRadius=14;
    self.btnrestoreExistingPurchase.backgroundColor=[UIColor colorWithRed:55.0f/255.0f green:48.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    
    NSLog(@"ProductId :- %@", productCode);
    NSLog(@"CouponCode :- %@", self.couponCode);
    
    if([_openURL isEqualToString:@"yes"])
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        productCode= [NSString stringWithFormat: @"%@",[user valueForKey:@"Pcode"]];
        self.couponCode= [NSString stringWithFormat: @"%@",[user valueForKey:@"Ccode"]];
    }
    //productCode = @"com.Krishnais.TrueSecretsM.newsong";
    
    //---activity indicator
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    activityIndicatorView.color = [UIColor whiteColor];
    activityIndicatorView.center = self.view.center;
    [activityIndicatorView hidesWhenStopped];
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureLeft:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [self.view addGestureRecognizer:swipeLeft];
    [activityIndicatorView startAnimating];
    self.view.userInteractionEnabled = NO;
    //Hide purchase button initially
    
    if ([_failedURl isEqualToString:@"yes"]) {
        
        SangNameLabel.text = @"Orignal Price :";
        OriginalPriceLbl.text = @"";
        couponDiscountTitle.hidden = YES;
        SongDescriptionLabel.hidden = YES;
        
        priceAfterTitle.hidden = YES;
        SongsPriceLabel.hidden = YES;
        self.lblerror.hidden = NO;
        
        purchase.userInteractionEnabled = NO;
        self.btnrestoreExistingPurchase.userInteractionEnabled = NO;
        
        [activityIndicatorView stopAnimating];
        self.view.userInteractionEnabled = YES;
        
        [purchase setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [self.btnrestoreExistingPurchase setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    
    }
    
    //--------custom tost-------
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Getting Product Information...";
    hud.margin = 10.f;
    hud.yOffset = 220.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
    
    
    
  
    
    [self fetchAvailableProducts];
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)handleGestureLeft:(id)sender
{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request:(SKPaymentQueue *)request didFailWithError:(NSError *)error
{
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Itune connection failed...";
    hud.margin = 10.f;
    hud.yOffset = 220.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
    
    [activityIndicatorView stopAnimating];
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In-App Store unavailable" message:@"The In-App Store is currently unavailable, please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    NSLog(@"%@",error);
    [alert show];
    WelcomeViewController *obj = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
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
- (IBAction)purchaseItem:(id)sender {
    
    if([check_for_produts_available isEqualToString:@"no"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"True Secrets" message:@"No products available right now. Please try again later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }else if([SongsPriceLabel.text isEqualToString:@" "])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please wait while the data is fetching" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [activityIndicatorView startAnimating];
    
    
    //--------custom tost-------
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Connecting to Itunes...";
    hud.margin = 10.f;
    hud.yOffset = 220.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
    
    
    [self purchaseMyProduct:[validProducts objectAtIndex:0]];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Products"] isEqualToString:@"Purchased"]){
    [self updateCoupons];
    }
}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    
    self.view.userInteractionEnabled = NO;

    [activityIndicatorView startAnimating];

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
                    
                    
                    
                    [ACTConversionReporter reportWithConversionID:@"1012268842" label:@"iEi-CJ75qmEQqv7X4gM" value:_price isRepeatable:YES];
                    
                    
                    

                    
                    [value setValue:@"Purchased" forKey:@"Products"];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:status forKey:@"Products"];
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    
                    [activityIndicatorView stopAnimating];
                    self.view.userInteractionEnabled = YES;
                    
                    WelcomeViewController * obj = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
                    [self.navigationController pushViewController:obj animated:YES];
                    
                }   
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored ");
                NSLog(@"%ld",(long)SKPaymentTransactionStateRestored);
                [[NSUserDefaults standardUserDefaults] setValue:@"Purchased" forKey:@"Products"];
                [activityIndicatorView stopAnimating];
                self.view.userInteractionEnabled = YES;
                [self homeView];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                
                NSLog(@"Purchase failed ");
                if ([transaction.payment.productIdentifier
                     isEqualToString:productCode])
                {
                    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"Purchasing failed...";
                    hud.margin = 10.f;
                    hud.yOffset = 220.f;
                    hud.removeFromSuperViewOnHide = YES;
                    
                    [hud hide:YES afterDelay:1];
                }
                [activityIndicatorView stopAnimating];
                self.view.userInteractionEnabled = YES;

                NSLog(@"%ld",(long)SKPaymentTransactionStateFailed);
                break;
            default:
                break;
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2) {
        WelcomeViewController * obj = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
        return;
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
            
            //-----return object
            [productDict setValue:[NSString stringWithFormat:@"%@",validProduct.localizedTitle] forKey:@"Pname"];
            [productDict setValue:[NSString stringWithFormat:@"%@",validProduct.localizedDescription] forKey:@"Pdesc"]                    ;
            [productDict setValue:[NSString stringWithFormat:@"%@",validProduct.price] forKey:@"Pprice"];
            //-------
            
            
            NSString *productCode1;
            if ([productCode isEqualToString:@"TS_950"])
            {
                productCode1 = @"TS951";
            }if ([productCode isEqualToString:@"TS_000"])
            {
                productCode1 = @"TS1901";
            }else if([productCode isEqualToString:@"TS_1450"])
            {
                productCode1 = @"TS1451";
            }else if([productCode isEqualToString:@"TS1801"])
            {
                productCode1 = @"TS1801";
            }else if([productCode isEqualToString:@"TS_1900"])
            {
                productCode1 = @"TS1901";
            }
           
            
           
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [numberFormatter setLocale:validProduct.priceLocale];
           NSString *formattedPriceString = [numberFormatter stringFromNumber:validProduct.price];
            
            _price = [NSString stringWithFormat:@"%@",formattedPriceString];
            
            [OriginalPriceLbl setText:[NSString stringWithFormat:
                                        @"1990"]];
            
            //[SongDescriptionLabel setText:[NSString stringWithFormat:@"%@",validProduct.localizedDescription]];
            
            if([_fromWelcome isEqualToString:@"yes"])
            {
              
                [SongDescriptionLabel setText:[NSString stringWithFormat:
                                               @"%@",formattedPriceString]];
            }else
            {[SongDescriptionLabel setText:[NSString stringWithFormat:
                                           @"%@",productCode1]];
            }
            
            
            
            
            
            [SongsPriceLabel setText:[NSString stringWithFormat:
                                        @"%@",formattedPriceString]];
            
            if ([_openURL isEqualToString:@"yes"]) {
                NSString *abc =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"pricee"]];

                OriginalPriceLbl.text = abc;
                SongDescriptionLabel.text = [NSString stringWithFormat:@"%@",formattedPriceString];
            }
            
            if([_failedURl isEqualToString:@"yes"])
            {
                [OriginalPriceLbl setText:[NSString stringWithFormat:@"%@",
                                           formattedPriceString]];
            }
            NSLog(@"%@",validProduct.productIdentifier);
           
            NSString *abc =[productDict valueForKey:@"Pprice"];
            NSLog(@"%@",abc);
            [ProductsArray addObject:productDict];
            
//com.Krishnais.TrueSecretsM
            //com.krishna.${PRODUCT_NAME:rfc1034identifier }
            
      //  }
            
        }
    } else
    {   check_for_produts_available = @"no";
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
    }
    //1
    [activityIndicatorView stopAnimating];
    self.view.userInteractionEnabled = YES;

    purchase.hidden = NO;
}
-(void)updateCoupons
{
    
    NSLog(@"66666666666");

    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    NSString *coupontxt = [NSString stringWithFormat:@"%@",self.couponCode];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueIdentifier = (NSString *)[device identifierForVendor];
    
    NSString *username=@"ts_coupongetter";
    NSString *password=@"6X&z7ub^bzqiPJuLcu";
    NSString *mobile=@"1234567890";
    NSString *action=@"updatecoupon";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://webservices.truesecrets.com.au/webservice.php"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setPostValue:uniqueIdentifier forKey:@"IMEI"];
    [request setPostValue:mobile forKey:@"Mobile"];
    [request setPostValue:action forKey:@"action"];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:email forKey:@"email"];
    [request setPostValue:coupontxt forKey:@"coupon_code"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [enterCoupontxt resignFirstResponder];
//    
//    return YES;
//}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"7777777777");

    // Use when fetching text data
    NSString *responseString = [request responseString];
    // NSXMLParser *parser=[[NSXMLParser alloc] init];
    // [parser setDelegate:self];
    NSLog(@"res of webservice 2:%@",responseString);
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
    
    NSData *responseData = [request responseData];
    
//    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: responseData];
//    [xmlParser setDelegate:self];
//    [xmlParser setShouldResolveExternalEntities:YES];
//    [xmlParser parse];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

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
//---when the text in an element is found---
//-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
//{
//    [tempString appendString:string];
//}
//---when the end of element is found---
//-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
// namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//    
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
//                
//                NSDictionary *dict=[NSDictionary dictionaryWithObject:productCode forKey:@"ProductCode"];
//                if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(buttonCallBack:)]) {
//                    [self.delegate performSelector:@selector(buttonCallBack:) withObject:dict];
//                }
//                
//                //couponView.hidden = YES;
//            }
//        }else{
//            //[self.couponView removeFromSuperview];
//            enterCoupontxt.text = @"";
//            [enterCoupontxt becomeFirstResponder];
//            UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"Invalid  Coupon" message:@"Please confirm the coupon or Continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [PurchaseAlert show];
//        }
//    }
//}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction) btnrestoreExistingPurchase:(id)sender;
{
   
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

//- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
//{
//   
//    NSLog(@"received restored transactions: %i", queue.transactions.count);
//    if (queue.transactions.count == 0) {
//        NSString *str=@"You do not owned this app sorry.";
//        
//    }else{
//        for(SKPaymentTransaction *transaction in queue.transactions){
//            if(transaction.transactionState == SKPaymentTransactionStateRestored){
//                //called when the user successfully restores a purchase
//                NSLog(@"Restore Successful");
//                [[NSUserDefaults standardUserDefaults] setValue:@"Purchased" forKey:@"Products"];
//            }
//            
//            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            break;
//        }
//    }
//}
-(void)homeView
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(i==0)
    {
    //  [[NSUserDefaults standardUserDefaults]setObject:@"Purchased" forKey:@"Products"];
        WelcomeViewController *welcome1;
        if(result.height == 480)
        {
        
            welcome1=[[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
        
        }
        else if(result.height == 568)
        {
            welcome1=[[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController_iPhone" bundle:nil];
        
        
        }
        else if(result.height==1024)
        {
            welcome1=[[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController_ipad" bundle:nil];
        }
        else if(result.height == 640)
        {
            welcome1 = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController_retina" bundle:nil];
        }
        [self.navigationController pushViewController:welcome1 animated:YES];
        i++;
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Account restore successfull...";
        hud.margin = 10.f;
        hud.yOffset = 220.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }
}

@end
