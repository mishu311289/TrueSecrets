//
//  DDAnnotation.h
//

#import <MapKit/MapKit.h>

@interface DDAnnotation : MKPlacemark 
{
	CLLocationCoordinate2D coordinate_;
	NSString *title_;
	NSString *subtitle_;
     UIImage *image;
    
}
- (id)initWithName:(NSString*)name  coordinate:(CLLocationCoordinate2D)coordinate;
// Re-declare MKAnnotation's readonly property 'coordinate' to readwrite. 
@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end
