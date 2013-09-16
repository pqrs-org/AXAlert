// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-

@interface NSString (KeyEvent)

+ (NSString*) stringWithKeyEventCharactersIgnoringModifiers:(NSEvent*)event;

@end
