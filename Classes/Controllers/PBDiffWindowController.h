//
//  PBDiffWindowController.h
//  GitX
//
//  Created by Pieter de Bie on 13-10-08.
//  Copyright 2008 Pieter de Bie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PBGitCommit;
@class PBGitDiff;

@interface PBDiffWindowController : NSWindowController {
	PBGitDiff *diff;
}

+ (void) showDiffWindowWithFiles:(NSArray *)filePaths fromCommit:(PBGitCommit *)startCommit diffCommit:(PBGitCommit *)diffCommit;
- (id) initWithDiff:(PBGitDiff *)diff;
- (PBGitCommit *)startCommit;
- (PBGitCommit *)diffCommit;

@property (readonly) PBGitDiff *diff;
@end
