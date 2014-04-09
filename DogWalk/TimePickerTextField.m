//
//  TimePickerTextField.m
//  DogWalk
//
//  Created by Development on 4/7/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "TimePickerTextField.h"

@implementation TimePickerTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
