#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NUIRenderer.h"

@interface UITextView (NUI)
- (void)override_UITextView_didMoveToWindow;
@end