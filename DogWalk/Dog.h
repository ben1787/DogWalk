//
//  Dog.h
//  DogWalk
//
//  Created by Development on 3/7/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Family, Owner;

@interface Dog : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Owner *whoOwns;
@property (nonatomic, retain) Family *family;

@end
