//
//  FBAddressBookDataSource.h
//  PhoneBugz
//
//  Created by Justin Boyd on 2/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/TTContactViewCell.h"

@interface TTAddressBookDataSource : TTSectionedDataSource {
	NSArray* _names;
}

+ (TTAddressBookDataSource*) TheDataSource;
-(id) initWithContacts:(NSArray*) ContactArray;
@end
