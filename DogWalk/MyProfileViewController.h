//
//  MyProfileViewController.h
//  DogWalk
//
//  Created by Development on 3/14/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "ProfileViewController.h"

@interface MyProfileViewController : ProfileViewController
@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
