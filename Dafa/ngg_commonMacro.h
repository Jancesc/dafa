//
//  ngg_commonMacro.h
//  Dafa
//
//  Created by jan on 2018/6/12.
//  Copyright © 2018 Unity. All rights reserved.
//

#ifndef ngg_commonMacro_h
#define ngg_commonMacro_h

#ifndef OLWNCOMMACRO_H_
#define OLWNCOMMACRO_H_
#pragma mark ---- APPLICATION
#define VERSION_FLOAT [[[UIDevice currentDevice] systemVersion] floatValue]
#define STATUS_BAR_ORIENTATION [[UIApplication sharedApplication] statusBarOrientation]
#define isIpad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define isIphone6Plus ([[UIScreen mainScreen] bounds].size.height == 736 || [[UIScreen mainScreen] bounds].size.width == 736)
#define isIphone6 ([[UIScreen mainScreen] bounds].size.height == 667 || [[UIScreen mainScreen] bounds].size.width == 667)
#define FRAME_H(frame) (((frame).size).height)
#define cgpAdd(p, q) CGPointMake((p).x + (q).x, (p).y + (q).y)
#define cgpSub(p, q) CGPointMake((p).x - (q).x, (p).y - (q).y)
#define cgpStr(p) [NSString stringWithFormat:@"(%.1f, %.1f)", (p).x, (p).y]
#define cgrOrigin(r, x, y) CGRectMake((x), (y), (((r).size).width), (((r).size).height))
#define cgrX(r, x) cgrOrigin((r), (x), ((r).origin.y))
#define cgrY(r, y) cgrOrigin((r), ((r).origin.x), (y))
#define cgrSize(r, w, h) CGRectMake(((r).origin.x), ((r).origin.y), (w), (h))
#define cgrWidth(r, w) cgrSize((r), (w), (r).size.height)
#define cgrHeight(r, h) cgrSize((r), (r).size.width, (h))
#define cgrGetX(r) (((r).origin).x)
#define cgrGetY(r) (((r).origin).y)
#define cgrGetWidth(r) (((r).size).width)
#define cgrGetHeight(r) (((r).size).height)
#define cgrStr(r) [NSString stringWithFormat:@"(%.1f, %.1f, %.1f, %.1f)", cgrGetX((r)), cgrGetY((r)), cgrGetWidth((r)), cgrGetHeight((r))]
#define LogPt(s, p) NSLog(@"%@%@", s, cgpStr(p))
#define LogRect(s, r) NSLog(@"%@%@", s, cgrStr(r))
#define UIColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0f]
#define UIColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a) / 255.0f]
#define isStringEmpty(str)  ((str) == nil || [(str) isEqual:@""] || [(str) isKindOfClass:[NSNull class]])
#define isArrayEmpty(array) (((array) == nil) || ([(array) count] == 0) || [(array) isKindOfClass:[NSNull class]])
#define isCollectionEmpty(collection) (((collection) == nil) || [(collection) isKindOfClass:[NSNull class]] || ([(collection) count] == 0))
#define DOCUMENTS_DIR_PATH  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define TMP_DIR_PATH        [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]
#define CACHES_DIR_PATH        [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define PathInDocumentsDirectory(name)   [(DOCUMENTS_DIR_PATH) stringByAppendingPathComponent:(name)]
#define PathInTmpDirectory(name)   [(DOCUMENTS_DIR_PATH) stringByAppendingPathComponent:(name)]
#define PathInCachesDirectory(name)   [(CACHES_DIR_PATH) stringByAppendingPathComponent:(name)]
#define STATUS_BAR_HEIGHT   (isIphoneX ? 44.f : 20.f)
#define NAVIGATION_BAR_HEIGHT 44
#define TAB_BAR_HEIGHT  (isIphoneX ? (49.f) : 49.f)
#define HOME_INDICATOR  (isIphoneX ? (34.f) : 0.f)
#define KEYBOARD_HEIGHT  216
#define KEYBOARD_HEIGHT_CANDIDATES  252
#define NGGWeakSelf __weak typeof(self) weakSelf = self;
#define isIphone5 ([[UIScreen mainScreen] bounds].size.height == 568 || [[UIScreen mainScreen] bounds].size.width == 568)
#define isIphone4 ([[UIScreen mainScreen] bounds].size.height == 480 || [[UIScreen mainScreen] bounds].size.width == 480)
#define isIphoneX ([[UIScreen mainScreen] bounds].size.height == 812 || [[UIScreen mainScreen] bounds].size.width == 812)
#define APPDELEGATE [[UIApplication sharedApplication] delegate]
#define APP [UIApplication sharedApplication]
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define IMG(name) [UIImage imageNamed:name]
#define VIEW_TLX(view) (view.frame.origin.x)
#define VIEW_TLY(view) (view.frame.origin.y)
#define VIEW_BRX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BRY(view) (view.frame.origin.y + view.frame.size.height)
#define VIEW_W(view) (view.bounds.size.width)
#define VIEW_H(view) (view.bounds.size.height)
#define FRAME_TLX(frame) (frame.origin.x)
#define FRAME_TLY(frame) (frame.origin.y)
#define FRAME_W(frame) (((frame).size).width)
#endif



#endif /* ngg_commonMacro_h */
