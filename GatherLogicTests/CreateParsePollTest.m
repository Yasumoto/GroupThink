//
//  CreateParsePollTest.m
//  Gather
//
//  Created by Joe Smith on 6/10/12.
//  Copyright (c) 2012 Gather. All rights reserved.
//

#import "CreateParsePollTest.h"

@interface MockPFUser : PFUser @end
@implementation MockPFUser

- (void)setACL:(PFACL *)ACL {
    self.ACL = ACL;
}

@end

@interface MockPFACL : PFACL @end
@implementation MockPFACL

- (void)setReadAccess:(BOOL)allowed forUser:(PFUser *)user {
    
}

@end

@implementation CreateParsePollTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAddWriteAccessOnPollSuccess
{
    PFObject *object = [[PFObject alloc] initWithClassName:@"Poll"];
    PFACL *acl = [PFACL ACL];
    [object setACL:acl];
    PFUser *user = [[MockPFUser alloc] init];
    PFObject *sharedObject = [CreateParsePoll addWriteAccessOnPoll:object forUser:user];
    PFACL *sharedACL = [sharedObject ACL];
    NSLog(@"ACL is: %@", sharedACL);
    STAssertTrue([sharedACL getReadAccessForUser:user], @"Read access for user account.");
    STAssertTrue([sharedACL getWriteAccessForUser:user], @"Write access for user account.");
}

@end
