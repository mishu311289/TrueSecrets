//
//  facebookProfileView.h
//  TrueSecrets
//
//  Created by Madhur Kumaria on 29/05/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface facebookProfileView : UIViewController


{
   
    int i;
  
}
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *page;
@end
