// -*- Mode: objc -*-

#import <Cocoa/Cocoa.h>

@interface PreferencesController : NSObject {
  IBOutlet NSButton* startAtLogin_;
  IBOutlet NSTextField* version_;
}

- (void) load;

- (IBAction) setStartAtLogin:(id)sender;

@end
