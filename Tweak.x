#import <UIKit/UIKit.h>

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *targetWindow = nil;
        
        // Ищем активное окно через современные сцены
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        targetWindow = window;
                        break;
                    }
                }
                if (targetWindow) break;
            }
        }

        if (!targetWindow) return;
        UIViewController *rootVC = targetWindow.rootViewController;
        if (!rootVC) return;

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"P was here"
                                                                       message:@"Wormix tweak loaded"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}
