//
//  InvitationTableViewCell.h
//  DogWalk
//
//  Created by Development on 4/18/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogDataAvailability.h"

@interface InvitationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *invited;
@property (weak, nonatomic) IBOutlet UILabel *familyName;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) Family *family;

@end
