//
//  InvitationTableViewCell.m
//  DogWalk
//
//  Created by Development on 4/18/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "InvitationTableViewCell.h"

@implementation InvitationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFamily:(Family *)family
{
    _family = family;
    
    [self configureCell];
}

- (void)configureCell
{
    Photo *profilePicture = (Photo *)[[self.family.pics filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"isProfilePic = 1"]] anyObject];
    Dog *dog = [self.family.dogs anyObject];
    self.familyName.text = [NSString stringWithFormat:@"%@ & %@", self.family.owner.name, dog.name];
    if(profilePicture) {
        self.profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicture.imageURL]]];
    } else {
        self.profilePic.image = [UIImage imageNamed:@"Peter_Brian"];
    }
    
    self.profilePic.contentMode = UIViewContentModeScaleAspectFill;
    [self.profilePic setClipsToBounds:YES];
}

@end
