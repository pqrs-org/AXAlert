// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-

#import <Cocoa/Cocoa.h>

@class KeyboardEventLeaker;
@class MainMessageView;
@class PreferencesController;
@class SUUpdater;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet KeyboardEventLeaker* keyboardEventLeaker;
@property (assign) IBOutlet MainMessageView* mainMessageView;
@property (assign) IBOutlet NSWindow* preferencesWindow;
@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet PreferencesController* preferencesController;
@property (assign) IBOutlet SUUpdater* suupdater;

@end
