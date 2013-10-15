#import "PreferencesController.h"
#import "StartAtLoginController.h"

@implementation PreferencesController

- (void) load
{
  if ([StartAtLoginController isStartAtLogin]) {
    [startAtLogin_ setState:NSOnState];
  } else {
    [startAtLogin_ setState:NSOffState];
  }

  [version_ setStringValue:[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]];
}

- (IBAction) setStartAtLogin:(id)sender
{
  if ([StartAtLoginController isStartAtLogin]) {
    [StartAtLoginController setStartAtLogin:NO];
  } else {
    [StartAtLoginController setStartAtLogin:YES];
  }
}

@end
