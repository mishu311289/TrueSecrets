

#import "WHMailActivity.h"

@interface WHMailActivity() <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong)WHMailActivityItem *activityItem;

@end

@interface WHMailActivity ()
@property (strong) MFMailComposeViewController *mailController;
@end

@implementation WHMailActivity

#pragma mark - UIActivity Overrides

- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    return NSLocalizedString(@"Mail", @"title for Mail activity item");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"mailActivity.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if (![MFMailComposeViewController canSendMail]) {
        return NO;
    }

    for (id item in activityItems) {
        if ([item isKindOfClass:[WHMailActivityItem class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[WHMailActivityItem class]]){
            self.activityItem = item;
        }
    }
}

- (UIViewController *)activityViewController {
    MFMailComposeViewController *composeController = [[MFMailComposeViewController alloc] init];

    if (self.activityItem.onMailActivitySelected) {
        self.activityItem.onMailActivitySelected(composeController);
    }

    composeController.mailComposeDelegate = self;
	self.mailController = composeController;
    return composeController;
}

-(void)activityDidFinish:(BOOL)completed
{
	[self.mailController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self activityDidFinish:result == MFMailComposeResultSent];
}

@end
