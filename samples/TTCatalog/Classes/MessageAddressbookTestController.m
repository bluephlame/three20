
#import "MessageAddressbookTestController.h"
#import "SearchTestController.h"
#import	"Three20/Three20.h"



@implementation MessageAddressbookTestController

- (id)init {
  if (self = [super init]) {
    _sendTimer = nil;
    _dataSource = nil;
  }
  return self;
}

- (void)dealloc {
  [_sendTimer invalidate];
  [_dataSource release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)compose {
  id recipient = [[[TTTableField alloc] initWithText:@"Alan Jones" url:TT_NULL_URL] autorelease];
  TTMessageController* controller = [[[TTMessageController alloc] 
    initWithRecipients:[NSArray arrayWithObject:recipient]] autorelease];
 
   controller.dataSource =  [TTAddressBookDataSource TheDataSource];
   controller.delegate = self;
  [self presentModalViewController:controller animated:YES];
}

- (void)cancelAddressBook {
  [[TTNavigationCenter defaultCenter].frontViewController dismissModalViewControllerAnimated:YES];
}

- (void)sendDelayed:(NSTimer*)timer {
  _sendTimer = nil;
  
  NSArray* fields = timer.userInfo;
  UIView* lastView = [self.view.subviews lastObject];
  CGFloat y = lastView.bottom + 20;
  
  TTMessageRecipientField* toField = [fields objectAtIndex:0];
  for (id recipient in toField.recipients) {
    UILabel* label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = self.view.backgroundColor;
    label.text = [NSString stringWithFormat:@"Sent to: %@", recipient];
    [label sizeToFit];
    label.frame = CGRectMake(30, y, label.width, label.height);
    y += label.height;
    [self.view addSubview:label];
  }
  
  [self.modalViewController dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
  CGRect appFrame = [UIScreen mainScreen].applicationFrame;
  self.view = [[[UIView alloc] initWithFrame:appFrame] autorelease];;
  self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
  
  UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setTitle:@"Compose Message" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(compose)
    forControlEvents:UIControlEventTouchUpInside];
  button.frame = CGRectMake(20, 20, 280, 50);
  [self.view addSubview:button];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTMessageControllerDelegate

- (void)composeController:(TTMessageController*)controller didSendFields:(NSArray*)fields {
  _sendTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self
    selector:@selector(sendDelayed:) userInfo:fields repeats:NO];
}

- (void)composeControllerDidCancel:(TTMessageController*)controller {
  [_sendTimer invalidate];
  _sendTimer = nil;

  [controller dismissModalViewControllerAnimated:YES];
}


- (void)composeControllerShowRecipientPicker:(TTMessageController*)controller {
	ABPeoplePickerNavigationController* ABPPNavigator = [[ABPeoplePickerNavigationController alloc] init];
	ABPPNavigator.peoplePickerDelegate = self;
	ABPPNavigator.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt: kABPersonEmailProperty]];
	[self.modalViewController presentModalViewController:ABPPNavigator animated:YES];
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// ABPeople Picker Delegate
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	return YES;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	TTContact* contact = [TTContact CreateFromAddressRef:person andEmailProperty:property identifier:identifier];
	[(TTMessageController*)self.modalViewController addRecipient:[contact TTTableFieldObject] forFieldAtIndex:0];
	[self.modalViewController.modalViewController dismissModalViewControllerAnimated:YES];
	return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[self.modalViewController.modalViewController dismissModalViewControllerAnimated:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// SearchTestControllerDelegate

- (void)searchTestController:(SearchTestController*)controller didSelectObject:(id)object {
  TTMessageController* composeController = (TTMessageController*)self.modalViewController;
  [composeController addRecipient:object forFieldAtIndex:0];
  [controller dismissModalViewControllerAnimated:YES];
}


@end
