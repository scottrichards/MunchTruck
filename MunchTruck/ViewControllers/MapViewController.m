//
//  MapViewController.m
//  MunchTruck
//
//  Created by Scott Richards on 8/28/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKPlacemark *placemark;
@end

#define CLCOORDINATES_EQUAL( coord1, coord2 ) (coord1.latitude == coord2.latitude && coord1.longitude == coord2.longitude)

#define CLCOORDINATE_EPSILON 0.005f
#define CLCOORDINATES_CLOSE( coord1, coord2 ) (fabs(coord1.latitude - coord2.latitude) < CLCOORDINATE_EPSILON && fabs(coord1.longitude - coord2.longitude) < CLCOORDINATE_EPSILON)

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Zoom and Center around the specified location
- (void)zoomToLocation:(CLLocationCoordinate2D)location
{
    MKCoordinateRegion theRegion = self.mapView.region;
    
    // Zoom in
    theRegion.span.latitudeDelta = 0.112872;
    theRegion.span.longitudeDelta = 0.109863;
    
    theRegion.center = location;
    [self.mapView setRegion:theRegion animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.userLocation = userLocation.coordinate;
    [self zoomToLocation:self.userLocation];    // zoom and center location
    
    // Lookup the information for the current location of the user.
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ((placemarks != nil) && (placemarks.count > 0)) {   // Don't Update location if user is currently editing search location
            // If the placemark is not nil then we have at least one placemark. Typically there will only be one.
            _placemark = [placemarks objectAtIndex:0];
            
            NSString *location;
            if (self.placemark.subThoroughfare != nil)
                location = [NSString stringWithString:self.placemark.subThoroughfare];
            else
                location = @"";
            location = [NSString stringWithFormat:@"%@ %@ %@",location,self.placemark.thoroughfare,self.placemark.locality];
//            self.locationSearch.text = location;
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
