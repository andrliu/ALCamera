//
//  ALCameraViewController.m
//  ALCamera
//
//  Created by Andrew Liu on 3/31/17.
//  Copyright © 2017 AndrewLiu. All rights reserved.
//

#import "ALCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ALCameraViewController ()

@end

@implementation ALCameraViewController

#pragma mark - UIViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkCameraPermission];
}

#pragma mark - Privacy Permission
- (void)checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
#if DEBUG
            NSLog(@"Access has not been determined.");
#endif
            [self requestCameraPermission];
            break;
        case AVAuthorizationStatusRestricted:
#if DEBUG
            NSLog(@"Restricted access - normally won't happen.");
#endif
            break;
        case AVAuthorizationStatusDenied:
#if DEBUG
            NSLog(@"Access has been denied.");
#endif
            [self showPlaceholder:true];
            break;
        case AVAuthorizationStatusAuthorized:
#if DEBUG
            NSLog(@"Access has been granted.");
#endif
            [self startCameraSession];
            [self showPlaceholder:false];
            break;
        default:
#if DEBUG
            NSLog(@"AVAuthorizationStatus is out of scope!!!");
#endif
            break;
    }
}

- (void)requestCameraPermission {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (granted) {
#if DEBUG
                NSLog(@"Access has been granted by user.");
#endif
                [strongSelf startCameraSession];
                [self showPlaceholder:false];
            } else {
#if DEBUG
                NSLog(@"Access has been denied by user.");
#endif
                [self showPlaceholder:true];
            }
        });
    }];

}

#pragma mark - AVCaptureSession
- (void)startCameraSession {

}

- (void)stopCameraSession {

}

#pragma mark - Helper Methods
- (void)showPlaceholder:(BOOL)isShow {
    if (isShow) {
    
    } else {
    
    }
}

@end
