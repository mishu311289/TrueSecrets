//
//  InAppPurchaseViewController.h
//  TrueSecretsM
//
//  Created by Krishna_Mac_1 on 8/6/14.
//  Copyright (c) 2014 whatwasthat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface InAppPurchaseViewController : UIViewController<SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    SKProductsRequest *productRequest;
    NSArray *validProducts;

    UIActivityIndicatorView *activityIndicatorView;
    NSString *check_for_produts_available;
    int i,m;
}
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) NSString *price;

@property (strong, nonatomic) IBOutlet UILabel *SangNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *SongDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *SongsPriceLabel;
@property (strong, nonatomic) NSString *productCode;
@property (strong, nonatomic) IBOutlet UIButton *purchase;
@property (strong, nonatomic) IBOutlet UILabel *OriginalPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *couponDiscountTitle;
@property (strong, nonatomic) IBOutlet UILabel *priceAfterTitle;
@property (strong, nonatomic) NSString *couponCode;
@property (strong,nonatomic) NSString *openURL,*fromWelcome,*failedURl;
- (void)getProductInfo:(UIViewController *)viewController;
- (IBAction)purchaseItem:(id)sender;
- (IBAction)backBtn:(id)sender;
- (IBAction) btnrestoreExistingPurchase:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnrestoreExistingPurchase;
@property (strong, nonatomic) IBOutlet UILabel *lblerror;
@property (strong, nonatomic) NSString *valid;
@end
