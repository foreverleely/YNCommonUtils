//
//  YNCMacroHeader.h
//  YNCommonUtilsDemo
//
//  Created by liyangly on 2019/6/21.
//  Copyright © 2019 liyang. All rights reserved.
//

#ifndef YNCMacroHeader_h
#define YNCMacroHeader_h

#define YNCWIDTH(view) (view.frame.size.width)
#define YNCHEIGHT(view) (view.frame.size.height)
#define YNCLEFT(view) (view.frame.origin.x)
#define YNCTOP(view) (view.frame.origin.y)
#define YNCBOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define YNCRIGHT(view) (view.frame.origin.x + view.frame.size.width)

#ifndef YNC_DESIGN_WIDTH
#define YNC_DESIGN_WIDTH (375)
#endif

#ifndef YNC_DESIGN_HEIGHT
#define YNC_DESIGN_HEIGHT (667)
#endif

#ifndef YNC_SCREEN_WIDTH
#define YNC_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef YNC_SCREEN_HEIGHT
#define YNC_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#endif

#ifndef YNC_SX
#define YNC_SX(x)  ((x) * YNC_SCREEN_WIDTH / YNC_DESIGN_WIDTH)
#endif

#ifndef YNC_DEVICES_IS_PRO_12_9
#define YNC_DEVICES_IS_PRO_12_9 ([UIScreen mainScreen].bounds.size.width == 1024)
#endif

#ifndef YNC_SCALE_TO_PRO
#define YNC_SCALE_TO_PRO (YNC_DEVICES_IS_PRO_12_9? (1024.f/768.f): 1)
#endif

#ifndef YNC_SNAP2
#define YNC_SNAP2(s) ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? (s)*2*YNC_SCALE_TO_PRO : YNC_SX(s))
#endif

#ifndef YNC_SNAP
#define YNC_SNAP(s) ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? (s)*1.5*YNC_SCALE_TO_PRO : YNC_SX(s))
#endif


#ifndef ync_dispatch_queue_async_safe
#define ync_dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef ync_dispatch_main_async_safe
#define ync_dispatch_main_async_safe(block) ync_dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

#endif /* YNCMacroHeader_h */
