//
//  EditProfileViewController.h
//  DogWalk
//
//  Created by Development on 3/5/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogDataAvailablitySingleton.h"

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *aboutUs;
@property (weak, nonatomic) IBOutlet UITextField *ownerName;
@property (weak, nonatomic) IBOutlet UITextField *dogName;
@property (strong, nonatomic) Family *userFamily;
@end
