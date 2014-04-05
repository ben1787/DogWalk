//
//  ViewController.m
//  DogWalk
//
//  Created by Development on 3/4/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "ProfileViewController.h"
#import "PageContentViewController.h"

@interface ProfileViewController () <UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *aboutUs;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *profilePhotos;
@end

@implementation ProfileViewController

-(void)updateUIData
{
    Dog *randomDog = [self.userFamily.dogs anyObject];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ & %@", self.userFamily.owner.name, randomDog.name];
    self.aboutUs.text = self.userFamily.aboutUs;
}

-(void)viewDidLoad
{
    
    //setup profile pictures for swiping
     _profilePhotos = @[@"Peter_Brian", @"Peter_Brian2", @"Peter_Brian3", @"Peter_Brian4"];
    [self updateUIData];
 
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, 320, 333);
    
    [self addChildViewController:_pageViewController];
    [self.scrollView addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    //page indicator
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 600)];
    
    CGRect frame = CGRectMake(25, self.scrollView.contentSize.height-75, 50, 50);
    [UIBezierPath bezierPathWithOvalInRect:frame];
    UIImageView *playpal = [[UIImageView alloc] initWithFrame:frame];
    playpal.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:playpal];
    [super viewDidLoad];
    
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.profilePhotos count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.profilePhotos count] == 0) || (index >= [self.profilePhotos count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.profilePhotos[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.profilePhotos count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
