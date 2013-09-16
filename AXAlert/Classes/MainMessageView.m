#import "MainMessageView.h"
#import "NSString+KeyEvent.h"
#import "NotificationKeys.h"

@implementation MainMessageView

- (void) observer_kKeyDownNotification:(NSNotification*)notification
{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSEvent* event = [notification object];
    switch ([event type]) {
      case NSKeyDown:
        [self.keyEventType setStringValue:@"NSKeyDown"];
        break;
      case NSKeyUp:
        [self.keyEventType setStringValue:@"NSKeyUp"];
        break;
      case NSFlagsChanged:
        [self.keyEventType setStringValue:@"NSFlagsChanged"];
        break;
      default:
        // do nothing
        break;
    }
    [self.keyEventCharacters setStringValue:[NSString stringWithKeyEventCharactersIgnoringModifiers:event]];
  });
}

- (void) start;
{
  [self.keyEventType setStringValue:@"---"];
  [self.keyEventCharacters setStringValue:@""];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(observer_kKeyDownNotification:)
                                               name:kKeyDownNotification
                                             object:nil];
}

- (void) dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) drawRect:(NSRect)dirtyRect
{
  [NSGraphicsContext saveGraphicsState];
  {
    // Draw background
    NSRect bounds = [self bounds];
    [[[NSColor whiteColor] colorWithAlphaComponent:0.8] set];
    [[NSBezierPath bezierPathWithRoundedRect:bounds xRadius:10 yRadius:10] fill];
  }
  [NSGraphicsContext restoreGraphicsState];
}

- (void) adjustFrame
{
  NSRect sr = [[self superview] frame];
  NSRect r = [self frame];

  r.origin.x = (sr.size.width - r.size.width) / 2;
  r.origin.y = (sr.size.height - r.size.height - 200);

  [self setFrameOrigin:r.origin];
  [self setNeedsDisplay:YES];
}

@end
