//
//  RootViewController.h
//  DogWalk
//
//  Created by Development on 3/19/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogDataAvailablitySingleton.h"

@interface RootViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;

@end
