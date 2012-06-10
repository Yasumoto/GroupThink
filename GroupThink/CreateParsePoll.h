//
//  CreateParsePoll.h
//  GroupThink
//
//  Created by Joe Smith on 6/10/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface CreateParsePoll : NSObject
typedef void (^ CreationCompletion)(void);

+ (void) createNewPollWithQuestion:(NSString *)question
                    sharingMembers:(NSArray *)members
                         imageData:(NSData *)imageData
                             block:(CreationCompletion)completion;
@end
