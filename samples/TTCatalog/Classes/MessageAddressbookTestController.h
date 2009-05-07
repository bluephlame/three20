#import "SearchTestController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@class MockDataSource;

@interface MessageAddressbookTestController : UIViewController
  <TTMessageControllerDelegate, ABPeoplePickerNavigationControllerDelegate> {
  TTAddressBookDataSource* _dataSource;
  NSTimer* _sendTimer;
}

@end

