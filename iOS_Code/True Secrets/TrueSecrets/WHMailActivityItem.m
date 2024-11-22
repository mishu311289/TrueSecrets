

#import "WHMailActivityItem.h"

@implementation WHMailActivityItem

+ (instancetype) mailActivityItemWithSelectionHandler:(OnMailActivitySelected)onMailActivitySelected {
    WHMailActivityItem *activityItem = [[WHMailActivityItem alloc] init];
    activityItem.onMailActivitySelected = onMailActivitySelected;

    return activityItem;
}

@end
