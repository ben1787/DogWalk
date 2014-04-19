//
//  PageContentViewController.m
//  DogWalk
//
//  Created by Development on 4/2/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.image = [UIImage imageNamed:self.imageFile];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setClipsToBounds:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
