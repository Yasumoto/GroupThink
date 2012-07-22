//
//  CreateParsePollTest.h
//  Gather
//
//  Created by Joe Smith on 6/10/12.
//  Copyright (c) 2012 Gather. All rights reserved.
//

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import <SenTestingKit/SenTestingKit.h>
#import "CreateParsePoll.h"

@interface CreateParsePollTest : SenTestCase

@end

@interface CreateParsePoll ()
+ (void) sharePoll:(PFObject *) pollObject withMembers:(NSArray *)sharingMembers;
+ (PFObject *) addWriteAccessOnPoll:(PFObject *)pollObject forUser:(PFUser *)user;
@end
