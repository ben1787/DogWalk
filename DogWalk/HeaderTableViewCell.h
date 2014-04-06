//
//  HeaderTableViewCell.h
//  DogWalk
//
//  Created by Development on 4/5/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *playpalTypeSelector;

@end
