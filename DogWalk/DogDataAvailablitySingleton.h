//
//  DogDataAvailablitySingleton.h
//  DogWalk
//
//  Created by Development on 3/21/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "Family.h"
#import "Owner.h"
#import "Dog.h"

@interface DogDataAvailablitySingleton : NSObject

@property (strong, nonatomic) NSManagedObjectContext *dogDataContent;

#define DogDataAvailabilityNotfication @"DogDataAvailabilityNotification"
#define DogDataAvailabilityContext @"Context"

@end
