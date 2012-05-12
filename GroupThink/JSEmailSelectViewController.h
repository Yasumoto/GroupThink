//
//  JSEmailSelectViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/12/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface JSEmailSelectViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
@property (strong, nonatomic) NSArray *addressContacts;

@end
