// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-

#import <Cocoa/Cocoa.h>

@interface MainMessageView : NSView

@property (assign) IBOutlet NSTextField* keyEventCharacters;
@property (assign) IBOutlet NSTextField* keyEventType;

- (void) start;
- (void) adjustFrame;

@end
