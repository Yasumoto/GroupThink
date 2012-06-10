//
//  CreateParsePoll.m
//  GroupThink
//
//  Created by Joe Smith on 6/10/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "CreateParsePoll.h"

@interface CreateParsePoll ()
+ (void) sharePoll:(PFObject *) pollObject withMembers:(NSArray *)sharingMembers;
+ (void) addWriteAccessOnPoll:(PFObject *)pollObject forUser:(PFUser *)user;
@end

@implementation CreateParsePoll

+ (void) sharePoll:(PFObject *)pollObject withMembers:(NSArray *)sharingMembers {
    NSString *invitation = [NSString stringWithFormat:@"%@ has invited you to a poll", [[PFUser currentUser] username]];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          invitation, @"alert",
                          [NSNumber numberWithInt:1], @"badge", nil];
    for (NSString *email in sharingMembers) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"email" equalTo:email];
        NSError *error = [[NSError alloc] init];
        PFObject *object = [query getFirstObject:&error];
        if([object isKindOfClass:[PFUser class]]) {
            PFUser *user = (PFUser *) object;
            NSLog(@"Sharing with %@", [user username]);
            [PFPush sendPushDataToChannelInBackground:[user username] withData:data block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Successfully sent out notification to %@", email);
                    [self addWriteAccessOnPoll:pollObject forUser:user];
                }
                else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }
}

+ (void) addWriteAccessOnPoll:(PFObject *)pollObject forUser:(PFUser *)user {
    PFACL *pollACL = [pollObject ACL];
    [pollACL setReadAccess:YES forUser:user];
    [pollACL setWriteAccess:YES forUser:user];
    [pollObject setACL:pollACL];
    [pollObject saveEventually];
    NSLog(@"Sharing ACLs have been set for %@", [user email]);
}

+ (void) createNewPollWithQuestion:(NSString *)question
                    sharingMembers:(NSArray *)members
                         imageData:(NSData *)imageData
                             block:(CreationCompletion)completion {
    PFObject *pollObject = [PFObject objectWithClassName:@"Poll"];
    [pollObject setObject:question forKey:@"question"];
    [pollObject setObject:members forKey:@"members"];
    [pollObject setObject:[[PFUser currentUser] email] forKey:@"owner"];
    [self sharePoll:pollObject withMembers:members];
    if (imageData) {
        PFFile *imageFile = [PFFile fileWithName:@"pollImage.png" data:imageData];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Photo has been uploaded and saved!");
                [pollObject setObject:imageFile forKey:@"image"];
            }
            else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
        }];
    }
    [pollObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Saved poll!");
            completion();
        }
        else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
