#import "AppDelegate.h"
#import "KeyboardEventLeaker.h"
#import "MainMessageView.h"
#import "PreferencesController.h"
#import "Sparkle/SUUpdater.h"
#import "StartAtLoginController.h"

@interface AppDelegate ()

@property BOOL lastAXAPIStatus;

@end

@implementation AppDelegate

- (void) showWindowIfNeeded
{
  if (self.lastAXAPIStatus) {
    [self.window orderFront:nil];
  } else {
    [self.window orderOut:nil];
  }
}

- (void) adjustFrame
{
  NSWindow* w = self.window;

  [w orderOut:nil];

  NSRect rect = [[NSScreen mainScreen] frame];
  [w setFrame:rect display:NO];
  [[w contentView] setFrame:rect];
  [self.mainMessageView adjustFrame];

  [self showWindowIfNeeded];
}

- (void) observer_NSApplicationDidChangeScreenParametersNotification:(NSNotification*)notification
{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"observer_NSApplicationDidChangeScreenParametersNotification");
    [self adjustFrame];
  });
}

- (void) timerCallback
{
  BOOL currentAXAPIStatus = AXAPIEnabled();
  if (currentAXAPIStatus != self.lastAXAPIStatus) {
    self.lastAXAPIStatus = currentAXAPIStatus;

    if (currentAXAPIStatus) {
      [self.keyboardEventLeaker start];
    } else {
      [self.keyboardEventLeaker stop];
    }
    [self adjustFrame];
  }
}

- (void) applicationDidFinishLaunching:(NSNotification*)aNotification
{
  [self.preferencesController load];

  // ------------------------------------------------------------
  // Note:
  // Do not show AXAlert in Dock.
  // (== Do not call TransformProcessType with kProcessTransformToForegroundApplication.)
  // Because a foreground app will not be shown in other app's fullscreen mode.

  NSWindowCollectionBehavior behavior = NSWindowCollectionBehaviorCanJoinAllSpaces |
                                        NSWindowCollectionBehaviorStationary |
                                        NSWindowCollectionBehaviorIgnoresCycle;

  NSWindow* w = self.window;

  [w setAlphaValue:(CGFloat)(0.8)];
  [w setBackgroundColor:[[NSColor blueColor] colorWithAlphaComponent:0.2]];
  [w setOpaque:NO];
  [w setHasShadow:NO];
  [w setStyleMask:NSBorderlessWindowMask];
  [w setLevel:NSStatusWindowLevel];
  [w setIgnoresMouseEvents:YES];
  [w setCollectionBehavior:behavior];

  [self adjustFrame];
  [self.mainMessageView start];

  // ------------------------------------------------------------
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(observer_NSApplicationDidChangeScreenParametersNotification:)
                                               name:NSApplicationDidChangeScreenParametersNotification
                                             object:nil];

  // ------------------------------------------------------------
  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];

  // ------------------------------------------------------------
  if (! [StartAtLoginController isStartAtLogin]) {
    [self.preferencesWindow makeKeyAndOrderFront:nil];
  }

  // ------------------------------------------------------------
  [self.suupdater checkForUpdatesInBackground];
}

- (BOOL) applicationShouldHandleReopen:(NSApplication*)theApplication hasVisibleWindows:(BOOL)flag
{
  [self.preferencesWindow makeKeyAndOrderFront:nil];
  return YES;
}

@end
