//
//  LIneToolObj.m
//  ChartView
//
//  Created by chao on 2020/10/8.
//

#import "LIneToolObj.h"

@implementation ECAxisStyle
@end

@implementation ECGuideStyle
@end

@implementation ECAxisDataStyle
@end

@implementation ECBenchmarkLineStyle
@end

@implementation ECAnimationLayer
{
    CGPathRef (^animationAction)(CADisplayLink *displayLink);
    CADisplayLink *_displayLink;
}
- (void)animationSetPath:(CGPathRef (^)(CADisplayLink *displayLink))setPathAction{
    if (_displayLink) {[_displayLink invalidate];_displayLink = nil;}
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationDisPlayHistogram)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:(NSDefaultRunLoopMode)];
    animationAction = setPathAction;
}
- (void)animationDisPlayHistogram{
    if (animationAction) {[self setPath:animationAction(_displayLink)];}
}

@end
