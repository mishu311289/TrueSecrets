//
//  DDAnnotation.m
//
//

#import "DDAnnotation.h"

@implementation DDAnnotation

@synthesize coordinate = coordinate_;
@synthesize title = title_;
@synthesize subtitle = subtitle_;
@synthesize image=image_;

//- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate addressDictionary:(NSDictionary *)addressDictionary {
//	
//	if ((self = [super initWithCoordinate:coordinate addressDictionary:addressDictionary])) {
//		self.coordinate = coordinate;
//	}
//	return self;
//}
- (id)initWithName:(NSString*)name  coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self = [super init]))
    {
        //name = [name copy];
        
        title_  = title_;
        coordinate = coordinate;
    }
    return self;
}
- (NSString *)title {
    if ([title_ isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return title_;
}

- (NSString *)subtitle {
    return @"";
}


@end
