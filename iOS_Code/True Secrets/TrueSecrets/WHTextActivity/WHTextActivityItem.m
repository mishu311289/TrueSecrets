

#import "WHTextActivityItem.h"

@implementation WHTextActivityItem

+ (instancetype)textActivityItemWithSelectionHandler:(OnTextActivitySelected)onTextActivitySelected {
    WHTextActivityItem *item = [[WHTextActivityItem alloc] init];
    item.onTextActivitySelected = onTextActivitySelected;

    return item;
}

@end
