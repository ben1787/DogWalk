//
//  InvitationsTableViewController.m
//  DogWalk
//
//  Created by Development on 4/14/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "InvitationsTableViewController.h"
#import "InvitationHeaderTableViewCell.h"
#import "TabBarViewController.h"
#import "DogDataAvailability.h"
#import "InvitationTableViewCell.h"

@interface InvitationsTableViewController ()
@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;
@property (strong, nonatomic) NSArray *playpalFamilies;
@end

@implementation InvitationsTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    TabBarViewController *tbvc = (TabBarViewController *)self.presentingViewController;
    self.dogDataContext = tbvc.dogDataContext;
    
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

-(NSArray *)invitedPlaypals
{
    if (!_invitedPlaypals) {
        _invitedPlaypals = [[NSArray alloc] init];
    }
    
    return _invitedPlaypals;
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
    cell.family = playpalFamily;
    
    return cell;
}

#pragma mark Handle Selecting and Deselecting

//at the moment this is not used as I disabled users ability to change the switch control so it defaults to selecting the cell. perhaps this should be changed in the future
- (IBAction)switchValueChanged:(UISwitch *)sender {
    CGPoint center= sender.center;
    CGPoint rootViewPoint = [sender.superview convertPoint:center toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:rootViewPoint];
    
    [sender setOn:!sender.isOn animated:NO];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvitationTableViewCell *playpalCell = (InvitationTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSMutableArray *mutableInvitedPlaypals = [NSMutableArray arrayWithArray:self.invitedPlaypals];
    if (playpalCell.invited.isOn) {
        [mutableInvitedPlaypals removeObject:playpalCell.family];
    } else {
        [mutableInvitedPlaypals addObject:playpalCell.family];
    }
    
    [playpalCell.invited setOn:!playpalCell.invited.isOn animated:YES];
    
    self.invitedPlaypals = [NSArray arrayWithArray:mutableInvitedPlaypals];
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
