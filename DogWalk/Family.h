//
//  Family.h
//  DogWalk
//
//  Created by Development on 3/7/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dog, Family, Owner, Photo;

@interface Family : NSManagedObject

@property (nonatomic, retain) NSString * aboutUs;
@property (nonatomic, retain) NSNumber * isUserFamily;
@property (nonatomic, retain) Owner *owner;
@property (nonatomic, retain) NSSet *dogs;
@property (nonatomic, retain) NSSet *pics;
@property (nonatomic, retain) NSSet *playsWith;
@end

@interface Family (CoreDataGeneratedAccessors)

- (void)addDogsObject:(Dog *)value;
- (void)removeDogsObject:(Dog *)value;
- (void)addDogs:(NSSet *)values;
- (void)removeDogs:(NSSet *)values;

- (void)addPicsObject:(Photo *)value;
- (void)removePicsObject:(Photo *)value;
- (void)addPics:(NSSet *)values;
- (void)removePics:(NSSet *)values;

- (void)addPlaysWithObject:(Family *)value;
- (void)removePlaysWithObject:(Family *)value;
- (void)addPlaysWith:(NSSet *)values;
- (void)removePlaysWith:(NSSet *)values;

@end
