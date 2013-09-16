// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-

#import "KeyboardEventLeaker.h"
#import "NotificationKeys.h"

@interface KeyboardEventLeaker ()

@property CFMachPortRef eventTap;

@end


@implementation KeyboardEventLeaker

static CGEventRef eventTapCallBack(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void* refcon)
{
  KeyboardEventLeaker* self = (__bridge KeyboardEventLeaker*)(refcon);
  if (! self) return event;

  switch (type) {
    case kCGEventTapDisabledByTimeout:
      // Re-enable the event tap if it times out.
      CGEventTapEnable(self.eventTap, true);
      break;

    default:
      [[NSNotificationCenter defaultCenter] postNotificationName:kKeyDownNotification
                                                          object:[NSEvent eventWithCGEvent:event]];
      break;
  }

  return event;
}

- (void) start
{
  if (self.eventTap) {
    CGEventTapEnable(self.eventTap, true);
  }

  CGEventMask mask = CGEventMaskBit(kCGEventKeyDown) |
                     CGEventMaskBit(kCGEventKeyUp) |
                     CGEventMaskBit(kCGEventFlagsChanged);

  self.eventTap = CGEventTapCreate(kCGSessionEventTap,
                                   kCGHeadInsertEventTap,
                                   kCGEventTapOptionDefault,
                                   mask,
                                   eventTapCallBack,
                                   (__bridge void*)(self));

  if (! self.eventTap) {
    NSLog(@"CGEventTapCreate is failed");
    return;
  }

  CFRunLoopSourceRef runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, self.eventTap, 0);
  CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);

  CGEventTapEnable(self.eventTap, 1);

  CFRelease(runLoopSource);

  // Do not release eventTap here.
  // We use eventTap in eventTapCallBack.
}

- (void) stop
{
  if (self.eventTap) {
    CGEventTapEnable(self.eventTap, false);
  }
}

@end
