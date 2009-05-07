//
//  FBTTContactViewCell.m
//  PhoneBugz
//
//  Created by Justin Boyd on 2/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TTContactViewCell.h"


@implementation TTContactViewCell
@synthesize Name;
@synthesize Email;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		
		UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		NameLabel.textColor = [UIColor blackColor];
		NameLabel.highlightedTextColor = [UIColor blackColor];
		NameLabel.font = [UIFont boldSystemFontOfSize:17];
		NameLabel.backgroundColor = [UIColor clearColor];
		NameLabel.textAlignment =  UITextAlignmentLeft;
		
		self.Name = NameLabel;
		[self addSubview:NameLabel];
		[NameLabel release];
		
		UILabel *FieldLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		FieldLabel.textColor = [UIColor blackColor];
		FieldLabel.highlightedTextColor = [[UIColor alloc] initWithRed:0.75 green:0.75 blue:0.75 alpha:0];
		FieldLabel.font = [UIFont systemFontOfSize:14];
		FieldLabel.backgroundColor = [UIColor clearColor];
		FieldLabel.textAlignment =  UITextAlignmentLeft;
		
		self.Email = FieldLabel;
		[self addSubview:FieldLabel];
		[FieldLabel release];
		
    }
    return self;
}

- (void)layoutSubviews
{
	CGRect contentRect = self.bounds;
	CGFloat boundsX = contentRect.origin.x;
#define LEFT_OFFSET 20
#define WIDTH 280
#define HEIGHT  22
	
	self.Email.frame = CGRectMake(boundsX + LEFT_OFFSET, 22,WIDTH,HEIGHT);
	self.Name.frame =  CGRectMake(boundsX + LEFT_OFFSET, 2,WIDTH,HEIGHT);
	
}

- (void)setObject:(id)object {
	TTTableField* field = (TTTableField*)object;
	Name.text = field.text;
	Email.text = field.url;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)dealloc {
    [super dealloc];
}


@end
