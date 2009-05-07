//
//  FBContact.m
//  PhoneBugz
//
//  Created by Justin Boyd on 2/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TTContact.h"

@implementation TTContact
@synthesize FirstName;
@synthesize LastName;
@synthesize Email;
@synthesize EmailLabel;

-(id) initWithFirstName:(NSString*) firstName LastName:(NSString*) lastName Email:(NSString*)email andEmailLabel:(NSString*) emailLabel
{
	FirstName = firstName;
	LastName = lastName;
	Email = email;
	EmailLabel =  emailLabel;
	return self	;
}

+ (NSArray*) CreateFromAddressRef:(ABRecordRef) person
{
	NSString* theFirstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);	
    NSString* theLastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);

	
	ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
	
	CFIndex size = ABMultiValueGetCount(emailMulti);
	
	NSMutableArray* array = [NSMutableArray arrayWithCapacity:size];
	for(CFIndex i=0;i<size;i++)
	{
		NSString* emailLabel = (NSString*)ABMultiValueCopyLabelAtIndex(emailMulti,i);
		NSString* emailValue = (NSString*)ABMultiValueCopyValueAtIndex(emailMulti,i);
		TTContact* contact = [[TTContact alloc] initWithFirstName:theFirstName LastName:theLastName Email:emailValue andEmailLabel:emailLabel];
		[array addObject:contact];
	}
	return array;
}

+ (TTContact*) CreateFromAddressRef:(ABRecordRef) person andEmailProperty:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	NSString* theFirstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);	
    NSString* theLastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
	ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, property);
	NSString* emailLabel = (NSString*)ABMultiValueCopyLabelAtIndex(emailMulti,identifier);
	NSString* emailValue = (NSString*)ABMultiValueCopyValueAtIndex(emailMulti,identifier);
	
	return [[TTContact alloc] initWithFirstName:theFirstName LastName:theLastName Email:emailValue andEmailLabel:emailLabel];
	
}

- (BOOL) comparesTo:(NSString*) Text
{
	if(Text == nil)
		return YES;
	
	NSRange inEmail = [Email rangeOfString:Text options:(NSAnchoredSearch|NSCaseInsensitiveSearch)];
	if(inEmail.location != NSNotFound)
		return YES;
	
	NSRange inLastName = [LastName rangeOfString:Text options:(NSAnchoredSearch|NSCaseInsensitiveSearch)];
	if(inLastName.location != NSNotFound)
		return YES;
	
	NSRange inFirstName = [FirstName rangeOfString:Text options:(NSAnchoredSearch|NSCaseInsensitiveSearch)];
	if(inFirstName.location != NSNotFound)
		return YES;
	return NO;
}

-(TTTableField *) TTTableFieldObject
{
	return [[[TTTableField alloc] initWithText:[self FormattedName] url:self.Email] autorelease];
}
	

-(NSString*) FormattedName
{
	return [NSString stringWithFormat:@"%@ %@",FirstName, LastName];
}
@end
