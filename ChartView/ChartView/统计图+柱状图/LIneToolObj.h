//
//  LIneToolObj.h
//  ChartView
//
//  Created by chao on 2020/10/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 轴线样式
@interface ECAxisStyle : NSObject
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,assign)CGFloat lineWidth;
@end

// 辅助线样式
@interface ECGuideStyle : NSObject
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,assign)CGFloat lineWidth;
@end

// X轴数据样式
@interface ECAxisDataStyle : NSObject
@property (nonatomic,strong)UIColor *fontColor;
@property (nonatomic,assign)CGFloat fontSize;
@end

// 阈值线样式
@interface ECBenchmarkLineStyle : NSObject
@property (nonatomic,copy)NSString *benchmarkValue;
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)UIColor *fontColor;
@property (nonatomic,assign)CGFloat fontSize;
@end

// 动态layer
@interface ECAnimationLayer : CAShapeLayer
@property (nonatomic,strong)id obj;
@property (nonatomic,assign)CGRect selfRect;
- (void)animationSetPath:(CGPathRef (^)(CADisplayLink *displayLink))setPathAction;

@end

NS_ASSUME_NONNULL_END
