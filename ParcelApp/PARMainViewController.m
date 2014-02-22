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

@synthesize mapView, bannerViewController;

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
    self.mapView.myLocationEnabled = YES;
    
    [self setupBannerView];
    
    [self updateParcelLocationWithCompletion:^{
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[delegate.parcelHandler getCurrentParcelLocation].latitude
                                                                longitude:[delegate.parcelHandler getCurrentParcelLocation].longitude
                                                                     zoom:6];
        self.mapView.camera = camera;
    }];
}

- (void)setupBannerView
{
    self.bannerViewController = [[PARBannerViewController alloc] initWithNibName:@"PARBannerViewController" bundle:nil];
    self.bannerViewController.mapView = self.mapView;
    self.bannerView = self.bannerViewController.view;
}

- (void)updateParcelLocationWithCompletion:(void (^)(void))completion
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.parcelHandler loadParcelLocationWithCompletion:^{
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = [delegate.parcelHandler getCurrentParcelLocation];
        marker.title = @"Parcel";
        marker.snippet = [NSString stringWithFormat:@"%f, %f", marker.position.latitude, marker.position.longitude];
        marker.map = self.mapView;
        [completion invoke];
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
