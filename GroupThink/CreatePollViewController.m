//
//  CreatePollViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "CreatePollViewController.h"
#import "CreateParsePoll.h"

@interface CreatePollViewController ()
@property (nonatomic, strong) ButtonPeoplePicker *peoplePicker;
@property (nonatomic, strong) NSArray *sharingMembers;
@property (nonatomic, strong) UIImage *image;
@end

@implementation CreatePollViewController
@synthesize imageButton = _imageButton;
@synthesize questionField = _questionField;
@synthesize namesLabel = _namesLabel;
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
    //TODO(Yasumoto): We want people on devices with cameras to either take a photo
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
    [CreateParsePoll createNewPollWithQuestion:self.questionField.text sharingMembers:self.sharingMembers imageData:UIImagePNGRepresentation(self.image) block:^{
            self.navigationItem.rightBarButtonItem = sender;
    }];
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
	[self.namesLabel setText:namesString];
	CFRelease(addressBook);
}

- (void)buttonPeoplePickerDidFinish:(ButtonPeoplePicker *)controller {
    NSLog(@"%@", controller.group);
    [self updatePersonInfo:controller.group];
    [self dismissModalViewControllerAnimated:YES];
}
@end
