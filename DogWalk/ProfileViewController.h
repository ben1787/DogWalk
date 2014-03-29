//
//  ViewController.h
//  DogWalk
//
//  Created by Development on 3/4/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DogDataAvailability.h"

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) Family *userFamily;

-(void)updateUIData;
@end
