    //
//  CustomCuponViewController.m
//  TrueSecretsM
//
//  Created by Krishna_Mac_1 on 9/4/14.
//  Copyright (c) 2014 whatwasthat. All rights reserved.
//

#import "CustomCuponViewController.h"
#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "InAppPurchaseViewController.h"
AppDelegate *delegateObj;


@implementation CustomCuponViewController
@synthesize couponView,enterCoupontxt,applyCoupon,continueBtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
       
    }
    return self;
}
-(void)addCupon
{   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
//    if (![[user valueForKey:@"Products"] isEqualToString:@"Purchased"])
//    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Enter your coupon voucher"
                                  message:@""
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Continue",nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        /* Display a numerical keypad for this text field */
        couponAlertTextField = [alertView textFieldAtIndex:0];
        couponAlertTextField.keyboardType = UIKeyboardTypeDefault;
        couponAlertTextField.placeholder = @"Enter your Coupon/ voucher";
        [alertView show];
//    }else{
//    UIAlertView *alertView = [[UIAlertView alloc]
//                              initWithTitle:@"Original price :- 990"
//                              message:@""
//                              delegate:self
//                              cancelButtonTitle:@"Cancel"
//                              otherButtonTitles:@"Apply Coupon", @"Continue without Coupon", nil];
//    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    /* Display a numerical keypad for this text field */
//    couponAlertTextField = [alertView textFieldAtIndex:0];
//    couponAlertTextField.keyboardType = UIKeyboardTypeDefault;
//    couponAlertTextField.placeholder = @"Please enter your Coupon Number";
//    [alertView show];
//    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index %ld",(long)buttonIndex);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (![[user valueForKey:@"Products"] isEqualToString:@"Purchased"])
    {
        if (buttonIndex == 1) {
            [self applyCoupons];
            // NSString *ABC =  couponAlertTextField.text;
        }
        
    }else{
        if (buttonIndex == 1) {
            [self applyCoupons];
            // NSString *ABC =  couponAlertTextField.text;
        }else if (buttonIndex == 2){
            [self continueWithoutCoupon];
        }
        }
    }

-(void)continueWithoutCoupon
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
         NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:@"ts1900" forKey:@"ProductCode"];
      //  NSDictionary *dict=[NSDictionary dictionaryWithObject:@"1" forKey:@"Key"];
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(buttonCallBack:)]) {
            [self.delegate performSelector:@selector(buttonCallBack:) withObject:dict];
        }

    }
-(void)applyCoupons
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

        NSString *coupontxt = [NSString stringWithFormat:@"%@",couponAlertTextField.text];
    if([_openURL isEqualToString:@"yes"])
    {
        _openURL = @"no";
        coupontxt = [NSString stringWithFormat:@"%@",_couponCode];
    }
    
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        
        UIDevice *device = [UIDevice currentDevice];
        NSString *uniqueIdentifier = (NSString *)[device identifierForVendor];
        
        NSString *username=@"ts_coupongetter";
        NSString *password=@"6X&z7ub^bzqiPJuLcu";
        NSString *mobile=@"1234567890";
        NSString *action=@"checkcoupon";
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
    if([_openURL isEqualToString:@"no"])
    {
        [request startSynchronous];
    }else
    {
        [request startAsynchronous];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [enterCoupontxt resignFirstResponder];
    
    return YES;
}
- (void)requestFinished:(ASIHTTPRequest *)request
    {
        // Use when fetching text data
        NSString *responseString = [request responseString];
        // NSXMLParser *parser=[[NSXMLParser alloc] init];
        // [parser setDelegate:self];
        NSLog(@"res of webservice 2:%@",responseString);
        
        // Use when fetching binary data
        //NSData *responseData = [request responseData];
        
        NSData *responseData = [request responseData];
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData: responseData];
        [xmlParser setDelegate:self];   
        [xmlParser setShouldResolveExternalEntities:YES];
        [xmlParser parse];
        
    }
    
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI
qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict
    
    {
        if ([elementName isEqualToString:@"coupon_code"])
        {
            
            tempString = [[NSMutableString alloc] init];
            
        }else if ([elementName isEqualToString:@"expired"])
        {
            tempString = [[NSMutableString alloc] init];
        }else if ([elementName isEqualToString:@"used"])
        {
            tempString = [[NSMutableString alloc] init];
            
        }else if ([elementName isEqualToString:@"product_code"])
        {
            tempString = [[NSMutableString alloc] init];
            
        }else if ([elementName isEqualToString:@"status"])
        {
            tempString = [[NSMutableString alloc] init];
        }else if ([elementName isEqualToString:@"username"])
        {
            tempString = [[NSMutableString alloc] init];
        }
    }
    //---when the text in an element is found---
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
    {
        [tempString appendString:string];
    }
    //---when the end of element is found---
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    {
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
        {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        //[[UIApplication sharedApplication] endIgnoringInteractionEvents];

        if([elementName isEqualToString:@"data"]){
            
        } else if ([elementName isEqualToString:@"expired"]){
            couponExpire =  [NSString stringWithFormat:@"%@", tempString];
            if([couponExpire rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound){
           // if ([couponExpire isEqualToString: @"true"]) {
                isCouponExpired = YES;
            }else{
                isCouponExpired = NO;
            }
        }else if ([elementName isEqualToString:@"used"]){
            couponUsed = [NSString stringWithFormat:@"%@", tempString];
            if([couponUsed rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound){
          //  if ([couponUsed isEqualToString:@"true"]) {
                isCouponUsed = YES;
            }else{
                isCouponUsed = NO;
            }
        }else if ([elementName isEqualToString:@"product_code"]){
            productCode = [NSString stringWithFormat:@"%@", tempString];
            productCode = [productCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([productCode isEqualToString:@"ts000"])
            {
                productCode = @"TS_000";
            }
            if([productCode isEqualToString:@"ts950"])
            {
                productCode = @"TS_950";
            }else if([productCode isEqualToString:@"ts1450"])
            {
                 productCode = @"TS_1450";
            }
            else if([productCode isEqualToString:@"ts1800"])
            {
                productCode = @"TS1801";
            }
            else if([productCode isEqualToString:@"TS1900"])
            {
                productCode = @"TS_1900";
            }
            
            
            
            
            if ([tempstr isEqualToString:@"valid coupon"]) {
                if (!(isCouponExpired) && !(isCouponUsed)) {
                    
                    //      NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:productCode forKey:@"ProductCode"];
                    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:productCode forKey:@"ProductCode"];
                    
                    if([_openURL isEqualToString:@"no"])
                    {
                    [dict setObject:[NSString stringWithFormat:@"%@",_couponCode] forKey:@"CouponCode"];
                    }else{
                    [dict setObject:couponAlertTextField.text forKey:@"CouponCode"];
                    }
                    NSLog(@"%@",self.delegate);
                    
                    
                    if([_openURL isEqualToString:@"no"])
                    {
                        
                        NSLog(@"%@",[dict valueForKey:@"ProductCode"]);
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[dict valueForKey:@"ProductCode"] forKey:@"Pcode"];
                        [[NSUserDefaults standardUserDefaults]setObject:[dict valueForKey:@"CouponCode"] forKey:@"Ccode"];
                        InAppPurchaseViewController *InappPurchaseVC;
                        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad){
                            InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
                        }else{
                            InappPurchaseVC = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
                        }
                        InappPurchaseVC.productCode = [dict valueForKey:@"ProductCode"];
                        
                        //InappPurchaseVC.productCode = [dict valueForKey:@"com.Krishnais.TrueSecretsM.TrueSecrets"];
                        InappPurchaseVC.couponCode = [dict valueForKey:@"CouponCode"];
                        
                        
                        UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
                        [navController presentModalViewController:InappPurchaseVC animated:YES];
                        
                        [[NSNotificationCenter defaultCenter]
                         postNotificationName:@"TestNotification"
                         object:self];
                        
                        
                        return;
                        
                    }
                    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(buttonCallBack:)]) {
                        [self.delegate performSelector:@selector(buttonCallBack:) withObject:dict];
                    }
                    
                    //couponView.hidden = YES;
                }else{
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"TestNotification1"
                     object:self];
//                    UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"Invalid  Coupon" message:@"Please confirm the coupon or Continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                    [PurchaseAlert show];
                    
                    

                }
            }
        } else if ([elementName isEqualToString:@"status"]){
            couponStatus = [NSString stringWithFormat:@"%@", tempString];
            couponStatus = [couponStatus stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            tempstr = couponStatus;
            if ([couponStatus isEqualToString:@"valid coupon"]) {
//                if (!(isCouponExpired) && !(isCouponUsed)) {
//                    
////                    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:productCode forKey:@"ProductCode"];
//                     NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:couponAlertTextField.text forKey:@"ProductCode"];
//                    
//                    [dict setObject:couponAlertTextField.text forKey:@"CouponCode"];
//                    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(buttonCallBack:)]) {
//                        [self.delegate performSelector:@selector(buttonCallBack:) withObject:dict];
//                        }
//                    
//                    //couponView.hidden = YES;
//                }
            }else{
                //[self.couponView removeFromSuperview];
               // enterCoupontxt.text = @"";
               // [enterCoupontxt becomeFirstResponder];
//                UIAlertView *PurchaseAlert=[[UIAlertView alloc] initWithTitle:@"Invalid  Coupon" message:@"Please confirm the coupon or Continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                [PurchaseAlert show];
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"TestNotification1"
                 object:self];
            }
        }
    }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
