//
//  Owner.h
//  DogWalk
//
//  Created by Development on 3/7/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dog, Family;

@interface Owner : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dogs;
@property (nonatomic, retain) Family *family;
@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addDogsObject:(Dog *)value;
- (void)removeDogsObject:(Dog *)value;
- (void)addDogs:(NSSet *)values;
- (void)removeDogs:(NSSet *)values;

@end
