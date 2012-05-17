//
//  CreatePollViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "CreatePollViewController.h"

@interface CreatePollViewController ()
@property (nonatomic, strong) ButtonPeoplePicker *peoplePicker;
@property (nonatomic, strong) NSArray *sharingMembers;
@property (nonatomic, strong) UIImage *image;
- (void) sharePoll:(PFObject *) pollObject;
@end

@implementation CreatePollViewController
@synthesize imageButton;
@synthesize questionField = questionField;
@synthesize namesLabel;
@synthesize peoplePicker = _peoplePicker;
@synthesize sharingMembers = _sharingMembers;
@synthesize image = _image;

static NSString *kSegueIdentifier = @"showButtonPeoplePicker";

- (ButtonPeoplePicker *) peoplePicker {
    if (!_peoplePicker) self.peoplePicker = [[ButtonPeoplePicker alloc] init];
    return _peoplePicker;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.questionField.delegate = self;
    [self resetImageButtonImage];
}

- (void)viewDidUnload
{
    self.questionField = nil;
    [self setNamesLabel:nil];
    [self setImageButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueIdentifier]) {
        [segue.destinationViewController setDelegate:self];
    }
}

- (void) sharePoll:(PFObject *)pollObject {
    for (NSString *email in self.sharingMembers) {
        [self addWriteAccessOnPoll:pollObject ForEmailAddress:email];
    }
}

- (void) addWriteAccessOnPoll:(PFObject *)pollObject ForEmailAddress:(NSString *)emailAddress {
    PFQuery *query = [PFQuery queryForUser];
    [query whereKey:@"email" equalTo:emailAddress];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error && [object isKindOfClass:[PFUser class]]) {
            PFUser *user = (PFUser *)object;
            if (user) {
                PFACL *pollACL = [pollObject ACL];
                [pollACL setReadAccess:YES forUser:user];
                [pollACL setWriteAccess:YES forUser:user];
                [pollObject setACL:pollACL];
                NSLog(@"Sharing ACLs have been set for %@", [user email]);
            }
        }
        else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) resetImageButtonImage {
    [self.imageButton setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
    [self.imageButton setImage:[UIImage imageNamed:@"choose_hilighted.png"] forState:UIControlStateHighlighted];
}

- (IBAction)selectImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //TODO(joe): We want people on devices with cameras to either take a photo
    // or select from their library. Will need to display a new view.
    /*if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {*/
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //}
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)createPollButtonPressed:(UIBarButtonItem *)sender {
    if ([[self.questionField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] ||
        [self.sharingMembers count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoa Nelly!" message:@"Make sure you don't leave out the details!" delegate:nil cancelButtonTitle:@"fml" otherButtonTitles: nil];
        [alert show];
        return;
    }
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    PFObject *pollObject = [PFObject objectWithClassName:@"Poll"];
    [pollObject setObject:self.questionField.text forKey:@"question"];
    [pollObject setObject:self.sharingMembers forKey:@"members"];
    [pollObject setObject:[[PFUser currentUser] email] forKey:@"owner"];
    [self sharePoll:pollObject];
    if (self.image) {
        NSData *data = UIImagePNGRepresentation(self.image);
        PFFile *imageFile = [PFFile fileWithName:@"pollImage.png" data:data];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Photo has been uploaded and saved!");
                [pollObject setObject:imageFile forKey:@"image"];
                [pollObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"Saved poll (with photo)!");
                        self.navigationItem.rightBarButtonItem = sender;
                    }
                    else {
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }
            else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }

        }];
    }
    else {
        [pollObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Saved poll!");
                self.navigationItem.rightBarButtonItem = sender;
            }
            else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Chose a photo.");
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];

    [self.imageButton setImage:self.image forState:UIControlStateNormal];
    [self dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.image = nil;
    [self resetImageButtonImage];
    [self dismissModalViewControllerAnimated:YES];
}



#pragma mark - Update Person info
- (NSString *)getEmailAddressForPerson:(ABRecordRef) abPerson {
    NSString *email = nil;
    ABMultiValueRef emailAddresses = ABRecordCopyValue(abPerson, kABPersonEmailProperty);
    if (ABMultiValueGetCount(emailAddresses) > 0) {
        email = (__bridge_transfer NSString *)
        ABMultiValueCopyValueAtIndex(emailAddresses, 0);
    }
    else {
        email = @"[None ]";
    }
    return email;
}

- (void)updatePersonInfo:(NSArray *)group
{
	ABAddressBookRef addressBook = ABAddressBookCreate();
	NSMutableString *namesString = [NSMutableString string];
    NSMutableArray *members = [[NSMutableArray alloc] init];
	for (int i = 0; i < group.count; i++) {		
		NSNumber *personID = (NSNumber *)[group objectAtIndex:i];
		ABRecordID abRecordID = (ABRecordID)[personID intValue];
		ABRecordRef abPerson = ABAddressBookGetPersonWithRecordID(addressBook, abRecordID);
        [members addObject:[self getEmailAddressForPerson:abPerson]];
		NSString *name = (__bridge_transfer NSString *)ABRecordCopyCompositeName(abPerson);
		if (i < (group.count - 1)) {
			[namesString appendString:[NSString stringWithFormat:@"%@, ", name]];
		}
		else {
			[namesString appendString:[NSString stringWithFormat:@"%@", name]];
		}
	}
    self.sharingMembers = [members copy];
	[namesLabel setText:namesString];
	CFRelease(addressBook);
}

- (void)buttonPeoplePickerDidFinish:(ButtonPeoplePicker *)controller {
    NSLog(@"%@", controller.group);
    [self updatePersonInfo:controller.group];
    [self dismissModalViewControllerAnimated:YES];
}
@end
