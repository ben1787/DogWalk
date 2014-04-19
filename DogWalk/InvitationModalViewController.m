//
//  InvitationModalViewController.m
//  DogWalk
//
//  Created by Development on 4/18/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "InvitationModalViewController.h"
#import "TabBarViewController.h"
#import "DogDataAvailability.h"
#import "InvitationTableViewCell.h"

@interface InvitationModalViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;
@property (strong, nonatomic) NSArray *playpalFamilies;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation InvitationModalViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    TabBarViewController *tbvc = (TabBarViewController *)self.presentingViewController;
    self.dogDataContext = tbvc.dogDataContext;
    
   [self.navBar setBackgroundColor:[UIColor blueColor]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)setDogDataContext:(NSManagedObjectContext *)dogDataContext
{
    if(!_dogDataContext) {
        _dogDataContext = dogDataContext;
    }
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    request.predicate = [NSPredicate predicateWithFormat:@"isUserFamily == 0"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"owner.name"
                                                              ascending:YES]];
    NSArray *playpalFamilies = [dogDataContext executeFetchRequest:request
                                                             error:nil];
    self.playpalFamilies = playpalFamilies;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.playpalFamilies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InvitationCell";
    InvitationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    InvitationTableViewCell *configuredCell = [self configureCell:cell atIndexPath:indexPath];
    return configuredCell;
}

-(InvitationTableViewCell *)configureCell:(InvitationTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    Family *playpalFamily = [self.playpalFamilies objectAtIndex:indexPath.row];
    Dog *dog = [playpalFamily.dogs anyObject];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ & %@", playpalFamily.owner.name, dog.name];
    Photo *profilePicture = (Photo *)[[playpalFamily.pics filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"isProfilePic = 1"]] anyObject];
    if(profilePicture) {
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicture.imageURL]]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *playpalCell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableArray *pals = [[NSMutableArray alloc] initWithArray:self.invitedPlaypals];
    // [pals addObject:playpalCell.family];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark Cancel Invitation Update
- (IBAction)cancel {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
