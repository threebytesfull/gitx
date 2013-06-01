//
//  PBGitDiff.h
//  GitX
//
//  Created by Rufus Cable on 01/06/2013.
//
//

#import <Foundation/Foundation.h>
#import "PBGitCommit.h"

@interface PBGitDiff : NSObject {
    NSString *diffText;
    PBGitCommit *fromCommit;
    PBGitCommit *toCommit;
}

@property (readonly) NSString *diffText;
@property (readonly) PBGitCommit *fromCommit;
@property (readonly) PBGitCommit *toCommit;

+ (PBGitDiff *)diffFromCommit:(PBGitCommit *)diffStartCommit
                     toCommit:(PBGitCommit *)diffEndCommit;

+ (PBGitDiff *)diffFiles:(NSArray *)filePaths
              fromCommit:(PBGitCommit *)diffStartCommit
                toCommit:(PBGitCommit *)diffEndCommit;

+ (PBGitDiff *)diffWithDiffText:(NSString *)text;

- (PBGitDiff *)initWithFromCommit:(PBGitCommit *)diffStartCommit
                         toCommit:(PBGitCommit *)diffEndCommit;

- (PBGitDiff *)initWithFiles:(NSArray *)filePaths
                  fromCommit:(PBGitCommit *)diffStartCommit
                    toCommit:(PBGitCommit *)diffEndCommit;

- (PBGitDiff *)initWithDiffText:(NSString *)diffText;

@end
