//
//  CreateParsePollTest.m
//  Gather
//
//  Created by Joe Smith on 6/10/12.
//  Copyright (c) 2012 Gather. All rights reserved.
//

#import "CreateParsePollTest.h"

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
    PFObject *object = mock([PFObject class]);
    object = [object initWithClassName:@"Poll"];
    PFACL *mockACL = mock([[PFACL ACL] class]);
    PFUser *user = mock([PFUser class]);
    PFObject *sharedObject = [CreateParsePoll addWriteAccessOnPoll:object forUser:user];
    //[verify(mockACL) setReadAccess:YES forUser:user];
    //[verify(mockACL) setWriteAccess:YES forUser:user];
    //[verify(object) setACL:mockACL];
}

@end
