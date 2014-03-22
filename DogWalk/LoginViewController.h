//
//  LoginViewController.h
//  DogWalk
//
//  Created by Development on 3/19/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICKeyChainStore.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;
+(BOOL)validatePassword:(NSString *)password ForUsername:(NSString *)username;

@end
