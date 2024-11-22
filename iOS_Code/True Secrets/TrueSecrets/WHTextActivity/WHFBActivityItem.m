




#import "WHFBActivityItem.h"

@implementation WHFBActivityItem

+ (instancetype) fbActivityItemWithSelectionHandler:(OnFBActivitySelected)onShareActivitySelected {
    WHFBActivityItem *activityItem = [[WHFBActivityItem alloc] init];
    activityItem.onFBActivitySelected = onShareActivitySelected;
    
    return activityItem;
}
@end
