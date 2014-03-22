//
//  Owner.h
//  DogWalk
//
//  Created by Development on 3/22/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Family;

@interface Owner : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Family *family;

@end
