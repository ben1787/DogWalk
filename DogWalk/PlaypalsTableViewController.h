//
//  PlaypalsTableViewController.h
//  DogWalk
//
//  Created by Development on 3/13/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PlaypalsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
