//
//  PageContentViewController.h
//  DogWalk
//
//  Created by Development on 4/2/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSUInteger pageIndex;
@property (strong, nonatomic) NSString *imageFile;

@end
