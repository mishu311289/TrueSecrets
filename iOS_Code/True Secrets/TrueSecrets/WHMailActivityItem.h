

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

typedef void(^OnMailActivitySelected)(MFMailComposeViewController *mailComposeController);

@interface WHMailActivityItem : NSObject

@property (nonatomic, copy) OnMailActivitySelected onMailActivitySelected;

+ (instancetype) mailActivityItemWithSelectionHandler:(OnMailActivitySelected)onMailActivitySelected;

@end
