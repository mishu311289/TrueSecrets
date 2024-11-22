

#import "WHTextActivity.h"

@interface WHTextActivity () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) WHTextActivityItem *textActivityItem;

@end

@implementation WHTextActivity

#pragma mark - UIActivity Overrides

- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    return NSLocalizedString(@"Message", @"title for iMessage activity");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"textActivity.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if (![MFMessageComposeViewController canSendText]) {
        return NO;
    }

    for (id item in activityItems) {
        if ([WHTextActivityItem class]) {
            return YES;
        }
    }

    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[WHTextActivityItem class]]) {
            self.textActivityItem = item;
        }
    }
}

- (UIViewController *)activityViewController {
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];

    if (self.textActivityItem.onTextActivitySelected) {
        self.textActivityItem.onTextActivitySelected(messageController);
    }

    messageController.messageComposeDelegate = self;
    return messageController;
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self activityDidFinish:result == MessageComposeResultSent];
}


@end
