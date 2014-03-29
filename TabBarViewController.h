//
//  TabBarViewController.h
//  DogWalk
//
//  Created by Development on 3/24/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UITabBarController

@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;

@end
