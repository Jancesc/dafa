


#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

#define HUDErrorMessage(msg,d) ([SVProgressHUD showErrorWithStatus:(msg) duration:(d)])

#define HUDSuccessMessage(msg,d) ([SVProgressHUD showSuccessWithStatus:(msg) duration:(d)])

#define HUDBlockView(v)         ([(v) setUserInteractionEnabled:NO])
#define HUDResumeBlockedView(v) ([(v) setUserInteractionEnabled:YES])

enum {
    SVProgressHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    SVProgressHUDMaskTypeClear, // don't allow
    SVProgressHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    SVProgressHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger SVProgressHUDMaskType;

@interface SVProgressHUD : UIView

+ (void)show;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType;

+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration;
+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

+ (void)dismiss; // simply dismiss the HUD with a fade+scale out animation
+ (void)dismissWithSuccess:(NSString*)successString; // also displays the success icon image
+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithError:(NSString*)errorString; // also displays the error icon image
+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds;

+ (BOOL)isVisible;

@end
