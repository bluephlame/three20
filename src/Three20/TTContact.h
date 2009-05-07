//
//  FBContact.h
//  PhoneBugz
//
//  Created by Justin Boyd on 2/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "Three20/TTTableField.h"

@interface TTContact : NSObject {	
	NSString* FirstName;
	NSString* LastName;
	NSString* Email;
	NSString* EmailLabel;
}

@property (nonatomic,retain) NSString* FirstName;
@property (nonatomic, retain) NSString* LastName;
@property (nonatomic, retain) NSString* Email;
@property (nonatomic, retain) NSString* EmailLabel;

-(id) initWithFirstName:(NSString*) firstName LastName:(NSString*) lastName Email:(NSString*)email andEmailLabel:(NSString*) emailLabel;
- (BOOL) comparesTo:(NSString*) text;
- (NSString*) FormattedName;
- (TTTableField*) TTTableFieldObject;

+ (TTContact*) CreateFromAddressRef:(ABRecordRef) person andEmailProperty:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier;
+ (NSArray*) CreateFromAddressRef:(ABRecordRef) person;

@end
