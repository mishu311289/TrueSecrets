//
//  WHFBActivityItem.h
//  TrueSecrets
//
//  Created by Madhur Kumaria on 03/06/13.
//  Copyright (c) 2013 PrasGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Social/SLComposeViewController.h>

typedef void(^OnFBActivitySelected)(SLComposeViewController *tweetSheet);


@interface WHFBActivityItem : NSObject

@property (nonatomic, copy) OnFBActivitySelected onFBActivitySelected;

+ (instancetype) fbActivityItemWithSelectionHandler:(OnFBActivitySelected)onFBActivitySelected;


@end
