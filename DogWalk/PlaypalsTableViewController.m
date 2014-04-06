//
//  PlaypalsTableViewController.m
//  DogWalk
//
//  Created by Development on 3/13/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "PlaypalsTableViewController.h"
#import "ProfileViewController.h"
#import "DogDataAvailability.h"
#import "TabBarViewController.h"
#import "HeaderTableViewCell.h"

@interface PlaypalsTableViewController ()
@property (strong, nonatomic) NSArray *playpalFamilies;
@property (strong, nonatomic) HeaderTableViewCell *headerCell;
@end

@implementation PlaypalsTableViewController

-(void)viewDidLoad
{
    TabBarViewController *tbvc = (TabBarViewController *)self.tabBarController;
    self.dogDataContext = tbvc.dogDataContext;
    
    //set nav bar color
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
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

#pragma mark Header Setup
#define HEADER_CELL_HEIGHT 72

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_CELL_HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    self.headerCell = headerCell;
    return headerCell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rect = self.headerCell.frame;
    rect.origin.y = MIN(0, scrollView.contentOffset.y);
    self.headerCell.frame = rect;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self tableView:self.tableView viewForHeaderInSection:1];
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[ProfileViewController class]]) {
        ProfileViewController *pvc = (ProfileViewController *)segue.destinationViewController;
        pvc.userFamily = [self.playpalFamilies objectAtIndex:[[self tableView] indexPathForSelectedRow].row];
    }
}

@end
