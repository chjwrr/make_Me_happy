//
//  LocationManager.m
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>


@interface LocationManager()<CLLocationManagerDelegate,UIAlertViewDelegate>{
    UIAlertView *alertView;
    BOOL isShow;
}

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation LocationManager


+ (id)shareInStance {
    static LocationManager *manager=nil;
    static dispatch_once_t dispathone;
    dispatch_once(&dispathone, ^{
        manager=[[LocationManager alloc]init];
    });
    return manager;
}

- (void)startUserLocation {
    
    if (isShow) {
        return;
    }
    
    self.locationManager.delegate=nil;
    [self.locationManager stopUpdatingLocation];
    
    if (!_locationManager) {
        
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            _locationManager =[[CLLocationManager alloc]init];
            
            //在ios 8.0下要授权
            
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                //NSLog(@"requestWhenInUseAuthorization");
                [self.locationManager requestWhenInUseAuthorization];
            }
            
            
            self.locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
            self.locationManager.distanceFilter=100.0f;
            self.locationManager.delegate=self;
            
        }else{
            [self initEnableAlertView];
        }
        
        
        
    }
    
    isShow = YES;
    
    [self.locationManager startUpdatingLocation];
    
}
- (void)stopUserLocation {
    self.locationManager.delegate=nil;
    [self.locationManager stopUpdatingLocation];
    
    isShow = NO;
    
}

/*
 //定位失败
 - (void)initFailureAlertView {
 UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:[UserLanguageManager loadTextforKey:@"ti_shi"] message:[UserLanguageManager loadTextforKey:@"ding_wei_shi_bai_chong_shi"] delegate:self cancelButtonTitle:nil otherButtonTitles:[UserLanguageManager loadTextforKey:@"qu_xiao"],[UserLanguageManager loadTextforKey:@"que_ding"], nil];
 [alertView show];
 }
 */

//用户没有开启定位
- (void)initEnableAlertView {
    if (alertView == nil) {
        alertView=[[UIAlertView alloc]initWithTitle:[UserLanguageManager loadTextforKey:@"ti_shi"] message:[UserLanguageManager loadTextforKey:@"ding_wei_mei_kai_qi_kai_qi"] delegate:nil cancelButtonTitle:nil otherButtonTitles:[UserLanguageManager loadTextforKey:@"que_ding"], nil];
        [alertView show];
        
        isShow=NO;
    }
}

#pragma CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *nowLocation=[locations lastObject];
    
    NSString *str_latitude=[NSString stringWithFormat:@"%f",nowLocation.coordinate.latitude];
    NSString *str_longitude=[NSString stringWithFormat:@"%f",nowLocation.coordinate.longitude];
    ksetDefaultValueForKey(str_latitude, kUserLocationLatitude);
    ksetDefaultValueForKey(str_longitude, kUserLocationLongitude);
    
    [self stopUserLocation];
    
    [manager stopUpdatingLocation];
    
    //反地理编码
    
    CLGeocoder *locationGeo=[[CLGeocoder alloc]init];
    
    [locationGeo reverseGeocodeLocation:nowLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error && [placemarks count] > 0) {
            
            NSDictionary *dic=[[placemarks objectAtIndex:0] addressDictionary];
            
            NSArray *formatted=[dic objectForKey:@"FormattedAddressLines"];
            ksetDefaultValueForKey([formatted objectAtIndex:0], kUserLocationAddressInfo);
            
            ksetDefaultValueForKey([dic objectForKey:@"City"], kUserLocationCity);
            ksetDefaultValueForKey([dic objectForKey:@"Country"], kUserLocationCity);
            
            
            
            NSString *addressName=[NSString stringWithFormat:@"%@%@%@",[dic objectForKey:@"Country"],[dic objectForKey:@"State"],[dic objectForKey:@"SubLocality"]];
            NSLog(@"当前位置  %@",addressName);
            
        }
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    ksetDefaultValueForKey(@"116.469481", kUserLocationLatitude);
    ksetDefaultValueForKey(@"40.011478", kUserLocationLongitude);
    
    isShow = NO;
    
}


#pragma UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self stopUserLocation];
        
        [self startUserLocation];
    }
}

@end
