//
//  FBAddressBookDataSource.m
//  PhoneBugz
//
//  Created by Justin Boyd on 2/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "Three20/TTAddressBookDataSource.h"
#import <AddressBook/AddressBook.h>
#import "Three20/TTContact.h"



@implementation TTAddressBookDataSource

+ (TTAddressBookDataSource*) TheDataSource
{
	ABAddressBookRef addressBook = ABAddressBookCreate();
	CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
	
	CFIndex size = CFArrayGetCount (people);	
	NSMutableArray* ContactArray = [[NSMutableArray alloc] initWithCapacity:size];
	
	NSEnumerator *enumerator = [(NSArray*)people objectEnumerator];
	id obj;
	while ( obj = [enumerator nextObject] ) {
	
		[ContactArray addObjectsFromArray:[TTContact CreateFromAddressRef:obj]];
	}
	TTAddressBookDataSource* dataSource = [[TTAddressBookDataSource alloc] initWithContacts:ContactArray];
	return dataSource;	
}

-(id) initWithContacts:(NSArray*) ContactArray
{
	if(self = [self init])
	{
		_names = [ContactArray retain];
	}
	return self;
}


- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView {
	return [self lettersForSectionsWithSearch:YES withCount:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (NSString*)tableView:(UITableView*)tableView labelForObject:(id)object {
	TTTableField* field = object;
	return field.text;
}

- (UITableViewCell*)tableView:(UITableView*)tableView provideCellforRowAtIndexPath:(NSIndexPath*)indexPath
{	
	static NSString *MyIdentifier = @"TTContactViewCell";
	TTContactViewCell *cell = (TTContactViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil)
	{
		cell = [[TTContactViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier];
	}
	cell.Email.text = @"##Temp##";
	cell.Name.text = @"##Error! Should not display##";
	return cell;
}

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
	cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView*)tableView search:(NSString*)text {
	[_sections release];
	_sections = nil;
	[_items release];
	
	if (text.length) {
		_items = [[NSMutableArray alloc] init];
		
		text = [text lowercaseString];
		for (TTContact* contact in _names) {
			if([contact comparesTo:text]){
				TTTableField* field = [contact TTTableFieldObject];
				[_items addObject:field];
			}
		}    
	} else {
		_items = nil;
	}
	
	[self dataSourceDidFinishLoad];
}

@end
