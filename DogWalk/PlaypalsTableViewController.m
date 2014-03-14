//
//  PlaypalsTableViewController.m
//  DogWalk
//
//  Created by Development on 3/13/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "PlaypalsTableViewController.h"
#import "SWRevealViewController.h"
#import "DogDataAvailability.h"

@interface PlaypalsTableViewController ()
@property (strong, nonatomic) NSArray *playpalFamilies;
@end

@implementation PlaypalsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button color
    //    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if(!_managedObjectContext) {
        _managedObjectContext = managedObjectContext;
    }
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    request.predicate = nil; //[NSPredicate predicateWithFormat:@"isUserFamily == 1"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"owner.name"
                                                              ascending:YES]];
    NSArray *playpalFamilies = [managedObjectContext executeFetchRequest:request
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
    static NSString *CellIdentifier = @"playpal cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
