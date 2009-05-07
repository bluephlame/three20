//
//  FBTTContactViewCell.h
//  PhoneBugz
//
//  Created by Justin Boyd on 2/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface TTContactViewCell : TTTableViewCell {
	IBOutlet UILabel* Name;
	IBOutlet UILabel* Email;
}
@property (nonatomic, retain) UILabel* Name;
@property (nonatomic, retain) UILabel* Email;
@end
