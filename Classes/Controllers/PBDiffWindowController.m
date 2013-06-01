//
//  PBDiffWindowController.m
//  GitX
//
//  Created by Pieter de Bie on 13-10-08.
//  Copyright 2008 Pieter de Bie. All rights reserved.
//

#import "PBDiffWindowController.h"
#import "PBGitRepository.h"
#import "PBGitCommit.h"
#import "PBGitDefaults.h"
#import "PBGitDiff.h"


@implementation PBDiffWindowController
@synthesize diff;

- (id) initWithDiff:(PBGitDiff *)aDiff
{
    self = [super initWithWindowNibName:@"PBDiffWindow"];

    if (self)
        diff = aDiff;
    
	return self;
}


+ (void) showDiffWindowWithFiles:(NSArray *)filePaths fromCommit:(PBGitCommit *)startCommit diffCommit:(PBGitCommit *)diffCommit
{
    PBGitDiff *diff = [PBGitDiff diffFiles:filePaths
                                fromCommit:startCommit
                                  toCommit:diffCommit];
    
    if (!diff) {
        NSLog(@"failed to get diff output for diff window");
        return;
    }

	PBDiffWindowController *diffController = [[PBDiffWindowController alloc] initWithDiff:diff];
	[diffController showWindow:nil];
}

- (PBGitCommit *)startCommit
{
    return diff.fromCommit;
}

- (PBGitCommit *)diffCommit
{
    return diff.toCommit;
}

@end
