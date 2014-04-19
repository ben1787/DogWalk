//
//  PlaypalsTableViewController.h
//  DogWalk
//
//  Created by Development on 3/13/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HeaderTableViewCell.h"

@interface PlaypalsTableViewController : UITableViewController
@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;
@property (strong, nonatomic) NSArray *playpalFamilies;
@property (strong, nonatomic) UITableViewCell *headerCell;
-(UITableViewCell *)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
