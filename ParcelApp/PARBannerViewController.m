//
//  PARBannerViewController.m
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "PARBannerViewController.h"
#import "AppDelegate.h"
#import "PARMainViewController.h"

@interface PARBannerViewController ()

@end

@implementation PARBannerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFunction
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    CLLocationCoordinate2D parcelCoordinates = [delegate.parcelHandler getCurrentParcelLocation];
    CLLocation *parcelLocation = [[CLLocation alloc] initWithLatitude:parcelCoordinates.latitude longitude:parcelCoordinates.longitude];
    
    CLLocationDistance distanceBetween = [parcelLocation distanceFromLocation:self.mapView.myLocation];
    UILabel *distanceLabel = (UILabel*)[self.view viewWithTag:100];
    distanceLabel.text = [NSString stringWithFormat:@"%f",distanceBetween * 0.00062137];//Print in miles
    
    
    
    
    
}
@end
