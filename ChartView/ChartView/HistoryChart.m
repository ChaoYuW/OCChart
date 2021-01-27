//
//  HistoryChart.m
//  ChartView
//
//  Created by chao on 2020/10/8.
//

#import "HistoryChart.h"



#define POINT(A,B) CGPointMake(A,B)

#pragma mark - 图表四个顶点 -
#define BoxLeftTopPoint POINT(_edgeInsets.left, _size.height - _edgeInsets.top)
#define BoxRightTopPoint POINT(_size.width - _edgeInsets.right, _size.height - _edgeInsets.top)
#define BoxLeftBottomPoint POINT(_edgeInsets.left, _edgeInsets.bottom)
#define BoxRightBottomPoint POINT(_size.width - _edgeInsets.right, _edgeInsets.bottom)

#pragma mark - 画布四个顶点 -
#define CanvasLeftTopPoint POINT(BoxLeftTopPoint.x + _canvasEdgeInsets.left,BoxLeftTopPoint.y - _canvasEdgeInsets.top)
#define CanvasRightTopPoint POINT(BoxRightTopPoint.x - _canvasEdgeInsets.right,BoxRightTopPoint.y - _canvasEdgeInsets.top)
#define CanvasLeftBottomPoint POINT(BoxLeftBottomPoint.x + _canvasEdgeInsets.left,BoxLeftBottomPoint.y + _canvasEdgeInsets.bottom)
#define CanvasRightBottomPoint POINT(BoxRightBottomPoint.x - _canvasEdgeInsets.right,BoxRightBottomPoint.y + _canvasEdgeInsets.bottom)

#pragma mark - 计算两个点直接距离 -
#define TwoPointSpacing(A,B) sqrt(pow(A.x - B.x,2) + pow(A.y - B.y, 2))

#define padding (10)


@interface HistoryChart ()
{
    CGSize _size;
    CGFloat space_value;
    NSMutableArray *chartLayerAry;
}
@property (nonatomic,assign)CGFloat rowSpace;               // 竖直方向每一行间距
@property (nonatomic,assign)CGFloat columnSpace;            // 水平方向每一列间距
@end

@implementation HistoryChart


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _size = frame.size;
        self.layer.geometryFlipped = YES;
        // 设置初始值
        [self customDefaultParams];
        
    }
    return self;
}
- (CGFloat)rowSpace{
    if (_rowSpace == 0) {
        _rowSpace = TwoPointSpacing(CanvasLeftTopPoint, CanvasLeftBottomPoint) / _row;
    }
    return _rowSpace;
}
- (CGFloat)columnSpace{
    if (_columnSpace == 0) {
//        _columnSpace = TwoPointSpacing(CanvasRightBottomPoint, CanvasLeftBottomPoint) / _column;
        _columnSpace = 3*padding+_histogramWidth*2;
    }
    return _columnSpace;
}
#pragma mark - 设置初始值 -
- (void)customDefaultParams{
    // 图表边距 {top, left, bottom, right}
    _edgeInsets = UIEdgeInsetsMake(60, 40, 20, 40);
    // 画布边距
    _canvasEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 坐标轴样式
    ECAxisStyle *xdefaulyAxisStyle = [[ECAxisStyle alloc] init];
    xdefaulyAxisStyle.lineWidth = 1;
    xdefaulyAxisStyle.lineColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1];
    _xStyle = xdefaulyAxisStyle;
    ECAxisStyle *ydefaulyAxisStyle = [[ECAxisStyle alloc] init];
    ydefaulyAxisStyle.lineWidth = 1;
    ydefaulyAxisStyle.lineColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1];
    _yStyle = ydefaulyAxisStyle;
    
    // 辅助线样式
    ECGuideStyle *horizontaldefaultGuideStyle = [[ECGuideStyle alloc] init];
    horizontaldefaultGuideStyle.lineWidth = 0.5;
    horizontaldefaultGuideStyle.lineColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    _horizontalStyle = horizontaldefaultGuideStyle;
    ECGuideStyle *verticaldefaultGuideStyle = [[ECGuideStyle alloc] init];
    verticaldefaultGuideStyle.lineWidth = 0.5;
    verticaldefaultGuideStyle.lineColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    _verticalStyle = verticaldefaultGuideStyle;
    _isShowVerticalGuide = NO;
    _isShowHorizontalGuide = YES;
    
    // 坐标轴数据样式
    ECAxisDataStyle *xdefaultAxisDataStyle = [[ECAxisDataStyle alloc] init];
    xdefaultAxisDataStyle.fontSize = 10;
    xdefaultAxisDataStyle.fontColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    _xAxisDataStyle = xdefaultAxisDataStyle;
    ECAxisDataStyle *ydefaultAxisDataStyle = [[ECAxisDataStyle alloc] init];
    ydefaultAxisDataStyle.fontSize = 10;
    ydefaultAxisDataStyle.fontColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    _yAxisDataStyle = ydefaultAxisDataStyle;
    
    // 网格样式
    ECGuideStyle *defaultGriddingStyle = [[ECGuideStyle alloc] init];
    defaultGriddingStyle.lineWidth = 0.5;
    defaultGriddingStyle.lineColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    _griddingStyle = defaultGriddingStyle;
    _isShowGriddingGuide = NO;
    
    // 精度
    _precisionScale = 1;
    _yAxisPrecisionScale = 2;
    
    _histogramWidth = 20;
    _histogramFillColor1 = [UIColor colorWithRed:194 / 255.0 green:53 / 255.0 blue:49 / 255.0 alpha:1];
    _histogramFillColor2 = [UIColor colorWithRed:47 / 255.0 green:69 / 255.0 blue:84 / 255.0 alpha:1];
    _histogramClickFillColor = [UIColor redColor];
    ECAxisDataStyle *yValuedefaultAxisDataStyle = [[ECAxisDataStyle alloc] init];
    yValuedefaultAxisDataStyle.fontSize = 10;
    yValuedefaultAxisDataStyle.fontColor = [UIColor blackColor];
    _yValueDataStyle = yValuedefaultAxisDataStyle;
    
    _isShowBenchmarkLine = NO;
    ECBenchmarkLineStyle *benchmarkLineStyle = [[ECBenchmarkLineStyle alloc] init];
    benchmarkLineStyle.lineColor = [UIColor redColor];
    benchmarkLineStyle.lineWidth = 1;
    benchmarkLineStyle.fontSize = 9;
    benchmarkLineStyle.fontColor = [UIColor redColor];
    _benchmarkLineStyle = benchmarkLineStyle;
    
    
    _lineChartColor = [UIColor colorWithRed:67 / 255.0 green:155 / 255.0 blue:231 / 255.0 alpha:1];
    _lineChartWidth = 1;
    _lineChartDotRadius = 2;
    _lineChartDotColor = [UIColor colorWithWhite:1 alpha:1];
}

#pragma mark - 开始绘制 -
- (void)reloadData{
    // 绘制前清空画布

    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    // 绘制XY轴
    [self drawXYAxis];
    // 绘制辅助线
    [self drawGuide];
//    // 计算数据
    [self calculateValue];
//    // 绘制坐标轴数据
    [self drawAxisData];
//    // 画图
    [self drawHistogram];
    [self drawLineChart];
    [self drawInitView];
}
- (void)drawInitView
{
    //毛利额
    CGPoint point = POINT(200, CanvasLeftTopPoint.y + 20);
    ECAnimationLayer *mleLayer = [self histogramWith:point width:_histogramWidth height:10];
    mleLayer.zPosition = 999999;
    mleLayer.backgroundColor = _histogramFillColor1.CGColor;
    [self.layer addSublayer:mleLayer];
    
    CATextLayer *jetext = [self textLayer:POINT(CGRectGetMaxX(mleLayer.frame)+5, CanvasLeftTopPoint.y + 20) text:@"毛利额" fontColor:_yAxisDataStyle.fontColor fontSize:_yAxisDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, 20)];
    jetext.anchorPoint = CGPointMake(0, 0);
    jetext.alignmentMode = kCAAlignmentCenter;
    [self.layer addSublayer:jetext];
    
    
    point = POINT(CGRectGetMaxX(jetext.frame), CanvasLeftTopPoint.y + 20);
    ECAnimationLayer *xseLayer = [self histogramWith:point width:_histogramWidth height:10];
    xseLayer.zPosition = 999999;
    xseLayer.backgroundColor = _histogramFillColor2.CGColor;
    [self.layer addSublayer:xseLayer];
    
    point = POINT(CGRectGetMaxX(xseLayer.frame)+5, CanvasLeftTopPoint.y + 20);
    
    CATextLayer *xsetext = [self textLayer:point text:@"销售额" fontColor:_yAxisDataStyle.fontColor fontSize:_yAxisDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, 20)];
    xsetext.anchorPoint = CGPointMake(0, 0);
    xsetext.alignmentMode = kCAAlignmentCenter;
    [self.layer addSublayer:jetext];
    
    point = POINT(CGRectGetMaxX(xsetext.frame), CanvasLeftTopPoint.y + 20);
    ECAnimationLayer *animationLayer = [self lineChartWith:point width:_histogramWidth height:10];
    animationLayer.anchorPoint = CGPointMake(0, 0);
    animationLayer.strokeColor = _histogramFillColor2.CGColor;
    animationLayer.fillColor = [UIColor redColor].CGColor;
    animationLayer.zPosition = 999999;
    [self.layer addSublayer:animationLayer];
    [animationLayer animationSetPath:^CGPathRef _Nonnull(CADisplayLink * _Nonnull displayLink) {
        UIBezierPath *path = [UIBezierPath bezierPath];

        [path moveToPoint:POINT(CGRectGetMaxX(xsetext.frame), 0)];
        [path addLineToPoint:POINT(CGRectGetMaxX(xsetext.frame)+_histogramWidth, 0)];
        CAShapeLayer *dot = [self dotWith:POINT(CGRectGetMaxX(xsetext.frame)+5, 0) radius:_lineChartDotRadius color:_lineChartColor];
        dot.anchorPoint = POINT(0.5, 0.5);
        [animationLayer addSublayer:dot];
        [displayLink invalidate];
        return path.CGPath;
    }];
    
    
}
#pragma mark - 绘制坐标轴数据
#pragma mark - 绘制XY轴 -
- (void)drawXYAxis{
    CAShapeLayer *x = [self horizontalLine:BoxLeftBottomPoint width:TwoPointSpacing(BoxLeftBottomPoint, BoxRightBottomPoint) linecolor:_xStyle.lineColor lineHeight:_xStyle.lineWidth];
    x.anchorPoint = CGPointMake(0, 1);
    x.zPosition = 999999;
    [self.layer addSublayer:x];
    
    
    CAShapeLayer *y = [self verticalLine:BoxLeftBottomPoint height:TwoPointSpacing(BoxLeftTopPoint, BoxLeftBottomPoint) linecolor:_yStyle.lineColor lineWidth:_yStyle.lineWidth];
    y.anchorPoint = CGPointMake(1, 0);
    y.zPosition = 999999;
    [self.layer addSublayer:y];
    
    CAShapeLayer *y1 = [self verticalLine:BoxRightBottomPoint height:TwoPointSpacing(BoxRightTopPoint, BoxRightBottomPoint) linecolor:_yStyle.lineColor lineWidth:_yStyle.lineWidth];
    y1.anchorPoint = CGPointMake(1, 0);
    y1.zPosition = 999999;
    [self.layer addSublayer:y1];
    
    // 弥补左下角缺陷
    CAShapeLayer *pane = [self horizontalLine:BoxLeftBottomPoint width:1 linecolor:_xStyle.lineColor lineHeight:_xStyle.lineWidth];
    pane.anchorPoint = CGPointMake(1, 1);
    [self.layer addSublayer:pane];
}

#pragma mark - 画条形图 -
//销售额
- (void)drawSales
{
    CGFloat scale = self.rowSpace / space_value;
    NSLog(@"左边距 = CanvasLeftBottomPoint.x = %f %f",CanvasLeftBottomPoint.x,CanvasLeftBottomPoint.y);
    for (int i = 0; i < _valueDataAry1.count; i++) {
        NSString *curValue = _valueDataAry1[i];
        CGPoint point = POINT(CanvasLeftBottomPoint.x + (padding+i  * self.columnSpace), CanvasLeftBottomPoint.y + 0.5);
        ECAnimationLayer *histogramLayer = [self histogramWith:point width:_histogramWidth height:TwoPointSpacing(CanvasLeftTopPoint, CanvasLeftBottomPoint)];
        histogramLayer.anchorPoint = CGPointMake(0, 0);
        histogramLayer.zPosition = 999999;
        histogramLayer.fillColor = _histogramFillColor1.CGColor;
        [self.layer addSublayer:histogramLayer];
        [chartLayerAry addObject:histogramLayer];
        CGFloat curheight = [curValue floatValue] * scale;
        histogramLayer.selfRect = CGRectMake(point.x, point.y, _histogramWidth, curheight);
        histogramLayer.obj = @0;
        
        
        [histogramLayer animationSetPath:^CGPathRef (CADisplayLink *displayLink) {
            CGFloat targetValue = curheight;
            CGFloat currentValue = [histogramLayer.obj floatValue];
            CGFloat speed = (targetValue - currentValue) / 10;
            
 
            if (speed <= 1.0 / _precisionScale) {
                [displayLink invalidate];
                CGRect rect = [self rectWithSize:CGSizeMake(_edgeInsets.left, self.rowSpace) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_yValueDataStyle.fontSize]} forStr:curValue];

                CATextLayer *ytext = [self textLayer:POINT(_histogramWidth / 2.0, [histogramLayer.obj floatValue]) text:curValue fontColor:_yValueDataStyle.fontColor fontSize:_yValueDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, rect.size.height)];
                ytext.anchorPoint = CGPointMake(0.5, 0);
                ytext.alignmentMode = kCAAlignmentCenter;
                [histogramLayer addSublayer:ytext];
            }
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:POINT(0, 0)];
            [path addLineToPoint:POINT(_histogramWidth, 0)];
            [path addLineToPoint:POINT(_histogramWidth, currentValue + speed)];
            [path addLineToPoint:POINT(0, currentValue + speed)];
            [path addLineToPoint:POINT(0, 0)];
            histogramLayer.obj = @(currentValue + speed);
            return path.CGPath;
        }];
    }
}
//毛利额
- (void)drawMarginDollar
{
    CGFloat scale = self.rowSpace / space_value;
    NSLog(@"左边距 = CanvasLeftBottomPoint.x = %f %f",CanvasLeftBottomPoint.x,CanvasLeftBottomPoint.y);
    for (int i = 0; i < [_valueDataAry2 count]; i++) {
        NSString *curValue = _valueDataAry2[i];
        CGPoint point = POINT(CanvasLeftBottomPoint.x + (padding+_histogramWidth+padding +i  * self.columnSpace), CanvasLeftBottomPoint.y + 0.5);
        ECAnimationLayer *histogramLayer = [self histogramWith:point width:_histogramWidth height:TwoPointSpacing(CanvasLeftTopPoint, CanvasLeftBottomPoint)];
        histogramLayer.anchorPoint = CGPointMake(0, 0);
        histogramLayer.zPosition = 999999;
        histogramLayer.fillColor = _histogramFillColor2.CGColor;
        [self.layer addSublayer:histogramLayer];
        [chartLayerAry addObject:histogramLayer];
        CGFloat curheight = [curValue floatValue] * scale;
        histogramLayer.selfRect = CGRectMake(point.x, point.y, _histogramWidth, curheight);
        histogramLayer.obj = @0;
        
        [histogramLayer animationSetPath:^CGPathRef (CADisplayLink *displayLink) {
            CGFloat targetValue = curheight;
            CGFloat currentValue = [histogramLayer.obj floatValue];
            CGFloat speed = (targetValue - currentValue) / 10;
            if (speed <= 1.0 / _precisionScale)
            {
                [displayLink invalidate];
                CGRect rect = [self rectWithSize:CGSizeMake(_edgeInsets.left, self.rowSpace) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_yValueDataStyle.fontSize]} forStr:curValue];
                CATextLayer *ytext = [self textLayer:POINT(_histogramWidth / 2.0, [histogramLayer.obj floatValue]) text:curValue fontColor:_yValueDataStyle.fontColor fontSize:_yValueDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, rect.size.height)];
                ytext.anchorPoint = CGPointMake(0.5, 0);
                ytext.alignmentMode = kCAAlignmentCenter;
                [histogramLayer addSublayer:ytext];
            }
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:POINT(0, 0)];
            [path addLineToPoint:POINT(_histogramWidth, 0)];
            [path addLineToPoint:POINT(_histogramWidth, currentValue + speed)];
            [path addLineToPoint:POINT(0, currentValue + speed)];
            [path addLineToPoint:POINT(0, 0)];
            histogramLayer.obj = @(currentValue + speed);
            return path.CGPath;
        }];
    }
}
- (void)drawHistogram{
    [self drawSales];
    [self drawMarginDollar];
}
- (void)drawLineChart{
    
    CGFloat scale = self.rowSpace / space_value;
    NSMutableArray *tempAry = [NSMutableArray array];
    for (int i = 0; i < [_valueDataAry1 count]; i++) {
        [tempAry addObject:@0];
    }
    
    ECAnimationLayer *animationLayer = [self lineChartWith:CanvasLeftBottomPoint width:TwoPointSpacing(CanvasRightBottomPoint, CanvasLeftBottomPoint) height:TwoPointSpacing(CanvasLeftTopPoint, CanvasLeftBottomPoint)];
    animationLayer.anchorPoint = CGPointMake(0, 0);
    animationLayer.strokeColor = _lineChartColor.CGColor;
    animationLayer.fillColor = [UIColor clearColor].CGColor;
    animationLayer.zPosition = 999999;
    [self.layer addSublayer:animationLayer];
    
    [animationLayer animationSetPath:^CGPathRef(CADisplayLink *displayLink) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat posX = padding+_histogramWidth+padding*0.5;
        if (_valueDataAry1.count > 0) {
            [path moveToPoint:POINT(posX, [_valueDataAry1[0] floatValue] * scale)];
        }
        for (int i = 1; i < [_valueDataAry1 count]; i++)
        {
            NSString *curValue = _valueDataAry1[i];
            [path addLineToPoint:POINT(posX + self.columnSpace * i, [curValue floatValue] * scale)];
            
            CAShapeLayer *dot = [self dotWith:POINT(posX + self.columnSpace * i, [curValue floatValue] * scale) radius:_lineChartDotRadius color:_lineChartColor];
            dot.anchorPoint = POINT(0.5, 0.5);
            [animationLayer addSublayer:dot];
            
            
            CGRect rect = [self rectWithSize:CGSizeMake(_edgeInsets.left, self.rowSpace) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_yValueDataStyle.fontSize]} forStr:curValue];
            
            CATextLayer *ytext = [self textLayer:POINT(posX + self.columnSpace * i, [curValue floatValue] * scale + 10) text:curValue fontColor:_yValueDataStyle.fontColor fontSize:_yValueDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, rect.size.height)];
            ytext.anchorPoint = CGPointMake(0.5, 0);
            ytext.alignmentMode = kCAAlignmentCenter;
            [animationLayer addSublayer:ytext];

        }
        [displayLink invalidate];
        return path.CGPath;
    }];
    
    
}
#pragma mark - 创建水平线 -
- (CAShapeLayer *)horizontalLine:(CGPoint)leftPoint width:(CGFloat)width linecolor:(UIColor *)linecolor lineHeight:(CGFloat)lineHeight{
    CAShapeLayer *line = [CAShapeLayer layer];
    line.bounds = CGRectMake(0, 0, width, lineHeight);
    line.anchorPoint = CGPointMake(0, 0.5);
    line.position = leftPoint;
    line.backgroundColor = linecolor.CGColor;
    return line;
}
#pragma mark - 创建竖线 -
- (CAShapeLayer *)verticalLine:(CGPoint)bottomPoint height:(CGFloat)height linecolor:(UIColor *)linecolor lineWidth:(CGFloat)lineWidth{
    CAShapeLayer *line = [CAShapeLayer layer];
    line.bounds = CGRectMake(0, 0, lineWidth, height);
    line.anchorPoint = CGPointMake(0.5, 0);
    line.position = bottomPoint;
    line.backgroundColor = linecolor.CGColor;
    return line;
}
// 创建折线图
- (ECAnimationLayer *)lineChartWith:(CGPoint)point width:(CGFloat)width height:(CGFloat)height{
    ECAnimationLayer *layer = [ECAnimationLayer layer];
    layer.position = point;
    layer.bounds = CGRectMake(0, 0, width, height);
    return layer;
}
#pragma mark - 绘制坐标轴数据
- (void)drawAxisData{
    for (int i = 0; i < [_columnData count]; i++) {
        CGRect rect = [self rectWithSize:CGSizeMake(self.columnSpace, _edgeInsets.bottom) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_xAxisDataStyle.fontSize]} forStr:_columnData[i]];
        CATextLayer *xtext = [self textLayer:POINT(CanvasLeftBottomPoint.x + ((i + 1) * self.columnSpace) - (self.columnSpace * 0.5), BoxLeftBottomPoint.y - _xStyle.lineWidth) text:_columnData[i] fontColor:_xAxisDataStyle.fontColor fontSize:_xAxisDataStyle.fontSize boxSize:CGSizeMake(rect.size.width, rect.size.height)];
        xtext.anchorPoint = CGPointMake(0.5, 1);
        [self.layer addSublayer:xtext];
    }
    
    CGRect jeRect = [self rectWithSize:CGSizeMake(_edgeInsets.left, self.rowSpace) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_yAxisDataStyle.fontSize]} forStr:@"金额"];
    CATextLayer *jetext = [self textLayer:POINT(BoxLeftTopPoint.x, CanvasLeftTopPoint.y + 20) text:@"金额" fontColor:_yAxisDataStyle.fontColor fontSize:_yAxisDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, jeRect.size.height)];
    jetext.anchorPoint = CGPointMake(0.5, 0);
    jetext.alignmentMode = kCAAlignmentCenter;
    [self.layer addSublayer:jetext];
    
    for (int i = 0; i < [_row1Data count]; i++) {
        CGRect rect = [self rectWithSize:CGSizeMake(_edgeInsets.left, self.rowSpace) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_yAxisDataStyle.fontSize]} forStr:_row1Data[i]];
        CATextLayer *ytext = [self textLayer:POINT(BoxLeftBottomPoint.x - _yStyle.lineWidth-5, CanvasLeftBottomPoint.y + (i* self.rowSpace)) text:_row1Data[i] fontColor:_yAxisDataStyle.fontColor fontSize:_yAxisDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, rect.size.height)];
        ytext.anchorPoint = CGPointMake(1, 0.5);
        ytext.alignmentMode = kCAAlignmentRight;
        [self.layer addSublayer:ytext];
    }
    for (int i = 0; i < [_row2Data count]; i++) {
        CGRect rect = [self rectWithSize:CGSizeMake(_edgeInsets.right, self.rowSpace) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_yAxisDataStyle.fontSize]} forStr:_row2Data[i]];
        CATextLayer *ytext = [self textLayer:POINT(BoxRightBottomPoint.x + _yStyle.lineWidth+5, CanvasRightBottomPoint.y + (i* self.rowSpace)) text:_row2Data[i] fontColor:_yAxisDataStyle.fontColor fontSize:_yAxisDataStyle.fontSize boxSize:CGSizeMake(_edgeInsets.left, rect.size.height)];
        ytext.anchorPoint = CGPointMake(0, 0.5);
        ytext.alignmentMode = kCAAlignmentLeft;
        [self.layer addSublayer:ytext];
    }
}
#pragma mark - 绘制辅助线 -
- (void)drawGuide{
    if (_isShowGriddingGuide) {
        for (int i = 0; i < _row + 1; i++) {
            CGPoint point = POINT(CanvasLeftBottomPoint.x, CanvasLeftBottomPoint.y + (i * self.rowSpace));
            CAShapeLayer *xGuide = [self horizontalLine:point width:self.columnSpace * _column linecolor:_griddingStyle.lineColor lineHeight:_griddingStyle.lineWidth];
            xGuide.zPosition = 777777;
            [self.layer addSublayer:xGuide];
        }
        for (int i = 0; i < _column + 1; i++) {
            CGPoint point = POINT(CanvasLeftBottomPoint.x + (i * self.columnSpace), CanvasLeftBottomPoint.y);
            CAShapeLayer *yGuide = [self verticalLine:point height:self.rowSpace * _row linecolor:_griddingStyle.lineColor lineWidth:_griddingStyle.lineWidth];
            yGuide.zPosition = 777777;
            [self.layer addSublayer:yGuide];
        }
    }
    
    if (_isShowHorizontalGuide) {
        for (int i = 0; i < _row + 1; i++) {
            CGPoint point = POINT(BoxLeftBottomPoint.x, CanvasLeftBottomPoint.y + (i * self.rowSpace));
            CAShapeLayer *xGuide = [self horizontalLine:point width:TwoPointSpacing(BoxRightTopPoint, BoxLeftTopPoint) linecolor:_horizontalStyle.lineColor lineHeight:_horizontalStyle.lineWidth];
            xGuide.zPosition = 888888;
            [self.layer addSublayer:xGuide];
        }
    }
    if (_isShowVerticalGuide) {
        for (int i = 0; i < _column + 1; i++) {
            CGPoint point = POINT(CanvasLeftBottomPoint.x + (i * self.columnSpace), BoxLeftBottomPoint.y);
            CAShapeLayer *yGuide = [self verticalLine:point height:TwoPointSpacing(CanvasLeftTopPoint, BoxLeftBottomPoint) - (_isShowHorizontalGuide ? _horizontalStyle.lineWidth : 0) linecolor:_verticalStyle.lineColor lineWidth:_verticalStyle.lineWidth];
            yGuide.zPosition = 888888;
            [self.layer addSublayer:yGuide];
        }
    }
#define anchorLenth (5)
    // 画锚点
    for (int i = 1; i < _row +1; i++) {
        CGPoint point = POINT(CanvasLeftBottomPoint.x-anchorLenth, CanvasLeftBottomPoint.y + (i * self.rowSpace));
        CAShapeLayer *xGuide = [self horizontalLine:point width:anchorLenth linecolor:_yStyle.lineColor lineHeight:_yStyle.lineWidth];
        xGuide.zPosition = 777777;
        [self.layer addSublayer:xGuide];
    }
    for (int i = 1; i < _column ; i++) {
        CGPoint point = POINT(CanvasLeftBottomPoint.x + (i * self.columnSpace), CanvasLeftBottomPoint.y-anchorLenth);
        CAShapeLayer *yGuide = [self verticalLine:point height:anchorLenth linecolor:_xStyle.lineColor lineWidth:_xStyle.lineWidth];
        yGuide.zPosition = 777777;
        [self.layer addSublayer:yGuide];
    }
}
// 获取字符串在指定区域的rect
- (CGRect)rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes forStr:(NSString *)string{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [string boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect;
}
// 创建轴标题
- (CATextLayer *)textLayer:(CGPoint)positionPoint text:(NSString *)text fontColor:(UIColor *)fontColor fontSize:(CGFloat)fontSize boxSize:(CGSize)boxSize{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = text;
    textLayer.foregroundColor = fontColor.CGColor;
    textLayer.position = positionPoint;
    textLayer.fontSize = fontSize;
    textLayer.bounds = CGRectMake(0, 0, boxSize.width, boxSize.height);
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
    textLayer.contentsScale = [[UIScreen mainScreen] scale];
    return textLayer;
}
// 创建柱状图
- (ECAnimationLayer *)histogramWith:(CGPoint)point width:(CGFloat)width height:(CGFloat)height{
    ECAnimationLayer *layer = [ECAnimationLayer layer];
    layer.position = point;
    layer.bounds = CGRectMake(0, 0, width, height);
    return layer;
}
// 绘制圆点
- (CAShapeLayer *)dotWith:(CGPoint)point radius:(CGFloat)radius color:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds = CGRectMake(0, 0, 4 * radius, 4 * radius);
    layer.position = point;
    layer.cornerRadius = radius;
    layer.backgroundColor = color.CGColor;
    return layer;
}
- (void)calculateValue{
    NSMutableArray *tempRowData = [NSMutableArray array];
    NSMutableArray *tempRowData1 = [NSMutableArray array];
    space_value = [self spaceValue];
    
    for (int i = 0; i < _row + 1; i++) {
        [tempRowData1 addObject:[NSString stringWithFormat:@"%.0f%%",(i * space_value/space_value)/100*100]];
        [tempRowData addObject:[self getFormat:i * space_value]];
    }
    tempRowData[0] = @"0";
    _row1Data = [NSArray arrayWithArray:tempRowData];
    _row2Data = [NSArray arrayWithArray:tempRowData1];
//    if (_isHundredPercent == YES) {
//        space_value = 1.0 / _row;
//    }
    
}

- (NSString *)getFormat:(CGFloat)value
{
    int bit = 0;
    while (value/10000 > 1) {
        value = value/10000;
        bit++;
    }
    NSArray *ary = @[@"",@"万",@"亿",@"万亿"];
    NSString *str = @"";
    switch (_yAxisPrecisionScale) {
        case 0:
        {
            str = [NSString stringWithFormat:@"%.0f%@",value,ary[bit]];

        }
            break;
        case 1:
        {
            str = [NSString stringWithFormat:@"%.0f%@",value,ary[bit]];
        }
            break;
        case 2:
        {
            str = [NSString stringWithFormat:@"%.0f%@",value,ary[bit]];
        }
            break;
        case 3:
        {
            str = [NSString stringWithFormat:@"%.0f%@",value,ary[bit]];
        }
            break;
        case 4:
        {
            str = [NSString stringWithFormat:@"%.0f%@",value,ary[bit]];
        }
            break;
        case 5:
        {
            str = [NSString stringWithFormat:@"%.0f%@",value,ary[bit]];
        }
            break;
        default:
            break;
    }
    return str;
}



// 获取数据最大值,并计算每一行间隔值
- (CGFloat)spaceValue{
    CGFloat minValue = MAXFLOAT;
    CGFloat maxValue = -MAXFLOAT;
    for (int i = 0; i < [_valueDataAry1 count]; i++)
    {
        if ([_valueDataAry1[i] floatValue] * _precisionScale> maxValue) {
            maxValue = [_valueDataAry1[i] floatValue] * _precisionScale;
        }
        if ([_valueDataAry1[i] floatValue] * _precisionScale < minValue) {
            minValue = [_valueDataAry1[i] floatValue] * _precisionScale;
        }
    }
    int max = (int)[self getNumber:maxValue];
    NSInteger tenValue = 0;
    while (max / 10) {max = max / 10;tenValue++;}
    CGFloat space_Value = ((max + 1) * pow(10, tenValue)) / _row;
    return space_Value / _precisionScale;
}
// 只取小数点之前的数字
- (CGFloat)getNumber:(CGFloat)value{
    NSString *string = [NSString stringWithFormat:@"%f",value];
    if (![[NSMutableString stringWithString:string] containsString:@"."]) {
        return value;
    }
    return [[[string componentsSeparatedByString:@"."] firstObject] floatValue];
}


@end
