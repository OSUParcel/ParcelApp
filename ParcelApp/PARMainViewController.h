//
//  PARMainViewController.h
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface PARMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *parcelLocationButton;
@end
