//
//  PullOverWindow.m
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import "PullOverWindow.h"

@implementation PullOverWindow
@synthesize controller;

+ (id)sharedWindow {
    static PullOverWindow *window = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[self alloc] init];
    });
    
    return window;
}

- (id)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
        self.windowLevel = UIWindowLevelAlert-1;
        [self setHidden:NO];
        self.alpha = 1;
        self.rootViewController = controller = [[PullOverViewController alloc] init];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)makeKeyAndVisible{
    [super makeKeyAndVisible];
}
- (bool)_shouldCreateContextAsSecure{
    return YES;
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitTestResult = [super hitTest:point withEvent:event];
    
    if ([controller isOpened]) {
        return hitTestResult;
    }else{
        if ([hitTestResult isKindOfClass:[POHandle class]]) {
            return controller.handle;
        }
        return nil;
    }
}


@end
