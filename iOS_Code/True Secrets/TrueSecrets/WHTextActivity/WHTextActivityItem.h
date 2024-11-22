

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

typedef void(^OnTextActivitySelected)(MFMessageComposeViewController *messageComposeController);

@interface WHTextActivityItem : NSObject

+ (instancetype)textActivityItemWithSelectionHandler:(OnTextActivitySelected)onTextActivitySelected;

@property (nonatomic, copy) OnTextActivitySelected onTextActivitySelected;

@end
