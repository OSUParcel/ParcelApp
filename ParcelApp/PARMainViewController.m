//
//  PARMainViewController.m
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "PARMainViewController.h"
#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PARMainViewController ()

@end

@implementation PARMainViewController

@synthesize mapView;

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
    
    // Do any additional setup after loading the view from its nib.
    [self setupGoogleMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGoogleMap
{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[delegate.parcelHandler getCurrentParcelLocation].latitude
                                                            longitude:[delegate.parcelHandler getCurrentParcelLocation].longitude
                                                                 zoom:6];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    
    [self updateParcelLocation];
}

- (void)updateParcelLocation
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.parcelHandler loadParcelLocationWithCompletion:^{
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = [delegate.parcelHandler getCurrentParcelLocation];
        marker.title = @"Parcel";
        marker.snippet = @"Some Note";
        marker.map = self.mapView;
    }];
}

- (IBAction)parcelButtonPressed:(UIButton *)sender
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:[delegate.parcelHandler getCurrentParcelLocation]];
    [self.mapView animateWithCameraUpdate:cameraUpdate];
}

- (IBAction)currentPositionButtonPressed:(UIButton *)sender
{
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:self.mapView.myLocation.coordinate];
    [self.mapView animateWithCameraUpdate:cameraUpdate];
}

@end
