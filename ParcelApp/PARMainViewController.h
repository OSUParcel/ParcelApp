//
//  PARMainViewController.h
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "PARBannerViewController.h"

@interface PARMainViewController : UIViewController <GMSMapViewDelegate>

- (IBAction)parcelButtonPressed:(UIButton *)sender;
- (IBAction)currentPositionButtonPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) PARBannerViewController *bannerViewController;
@property (strong, nonatomic) GMSMutablePath *parcelPath;
@property (strong, nonatomic) GMSPolyline *parcelPathLine;
@property (strong, nonatomic) GMSMarker *parcelMarker;

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIButton *parcelLocationButton;

@end
