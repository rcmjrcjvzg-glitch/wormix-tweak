// language: Objective-C, file: Tweak.x (Theos, Logos)
// Test tweak for Wormix inside LiveContainer.
// Shows a UIAlert with "P was here" ~3 seconds after app launch.
// Target: hook -[AppDelegate applicationDidFinishLaunching:] on any iOS app.

#import <UIKit/UIKit.h>

%hook AppDelegate

- (void)applicationDidFinishLaunching:(id)application {
    %orig; // let the app finish launching FIRST

    [self showWormixAlert];
}

%new
- (void)showWormixAlert {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)),
        dispatch_get_main_queue(),
        ^{
            // Find the active window (iOS 13+ scene-based)
            UIWindow *keyWindow = nil;
            for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    keyWindow = ((UIWindowScene *)scene).keyWindow;
                    break;
                }
            }
            if (!keyWindow) {
                keyWindow = [UIApplication sharedApplication].windows.firstObject;
            }
            if (!keyWindow || !keyWindow.rootViewController) {
                return;
            }

            UIAlertController *alert =
                [UIAlertController alertControllerWithTitle:@"P was here"
                                                    message:@"Wormix tweak loaded"
                                             preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil]];
            [keyWindow.rootViewController presentViewController:alert
                                                       animated:YES
                                                     completion:nil];
        });
}

%end
