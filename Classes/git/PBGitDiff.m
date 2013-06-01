//
//  PBGitDiff.m
//  GitX
//
//  Created by Rufus Cable on 01/06/2013.
//
//

#import "PBGitDiff.h"
#import "PBGitCommit.h"
#import "PBGitRepository.h"
#import "PBGitDefaults.h"

@implementation PBGitDiff

@synthesize diffText, fromCommit, toCommit;

+ (PBGitDiff *)diffFromCommit:(PBGitCommit *)diffStartCommit
                     toCommit:(PBGitCommit *)diffEndCommit
{
    return [self diffFiles:nil
                fromCommit:diffStartCommit
                  toCommit:diffEndCommit];
}

+ (PBGitDiff *)diffFiles:(NSArray *)filePaths fromCommit:(PBGitCommit *)diffStartCommit toCommit:(PBGitCommit *)diffEndCommit
{
    return [[self alloc] initWithFiles:filePaths
                            fromCommit:diffStartCommit
                              toCommit:diffEndCommit];
}

+ (PBGitDiff *)diffWithDiffText:(NSString *)text
{
    return [[self alloc] initWithDiffText:text];
}

- (PBGitDiff *)initWithFromCommit:(PBGitCommit *)diffStartCommit
                         toCommit:(PBGitCommit *)diffEndCommit
{
    return [self initWithFiles:nil
                    fromCommit:diffStartCommit
                      toCommit:diffEndCommit];
}

- (PBGitDiff *)initWithFiles:(NSArray *)filePaths fromCommit:(PBGitCommit *)diffStartCommit toCommit:(PBGitCommit *)diffEndCommit
{
    if (!diffStartCommit)
        return nil;
    
    fromCommit = diffStartCommit;
    
    if (diffEndCommit)
        toCommit = diffEndCommit;
    else
        toCommit = [fromCommit.repository headCommit];
    
    NSString *commitSelector = [NSString stringWithFormat:@"%@..%@",
                                fromCommit.realSha, toCommit.realSha];
    NSMutableArray *arguments = [NSMutableArray arrayWithObjects:@"diff", @"--no-ext-diff",
                                 commitSelector, nil];
    
    if (![PBGitDefaults showWhitespaceDifferences])
        [arguments insertObject:@"-w" atIndex:1];
    
    if (filePaths) {
        [arguments addObject:@"--"];
        [arguments addObjectsFromArray:filePaths];
    }
    
    int retValue;
    diffText = [fromCommit.repository outputInWorkdirForArguments:arguments
                                                     retValue:&retValue];
    if (retValue) {
		NSLog(@"diff failed with retValue: %d   for command: '%@'    output: '%@'", retValue, [arguments componentsJoinedByString:@" "], diffText);
		return nil;
    }
    
    return self;
}

- (PBGitDiff *)initWithDiffText:(NSString *)diffText
{
    NSLog(@"UNIMPLEMENTED DIFF FROM OUTPUT TEXT");
    abort();
}

@end
