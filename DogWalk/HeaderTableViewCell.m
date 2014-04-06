//
//  HeaderTableViewCell.m
//  DogWalk
//
//  Created by Development on 4/5/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

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

-(void)layoutSubviews
{
    UIFont *font = [UIFont boldSystemFontOfSize:10];
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self.playpalTypeSelector setTitleTextAttributes:titleAttributes forState:UIControlStateNormal];
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
