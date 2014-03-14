//
//  Photo.h
//  DogWalk
//
//  Created by Development on 3/13/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Family;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * isProfilePic;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) Family *takenOf;

@end
