//
//  WHFBActivity.m
//  TrueSecrets
//
//  Created by Madhur Kumaria on 03/06/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import "WHFBActivity.h"
#import <Social/Social.h>

@interface WHFBActivity ()
@property (strong) SLComposeViewController *tweetController;
@property (nonatomic, strong)WHFBActivityItem *activityItem;
@property (strong, nonatomic) NSString *imageString;
@property (strong, nonatomic) NSString *urlString;


@end
@implementation WHFBActivity



- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    return NSLocalizedString(@"Mail", @"title for Share activity item");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"foursquare.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {

    
    for (id item in activityItems) {
        if ([item isKindOfClass:[WHFBActivityItem class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[WHFBActivityItem class]]){
            self.activityItem = item;
        }
    }
}

- (UIViewController *)activityViewController {
    SLComposeViewController *shareController = [[SLComposeViewController alloc] init];
    
    if (self.activityItem.onFBActivitySelected) {
        self.activityItem.onFBActivitySelected(shareController);
    }
    
    self.tweetController = shareController;
    return shareController;
}

-(void)activityDidFinish:(BOOL)completed
{
	[self.tweetController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}




@end
