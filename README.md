# [绘制柱状图 统计表](https://github.com/ChaoYuW/OCChart/blob/main/ChartView/ChartView/chartVIew.mov)
## 该模块来自一个外包项目一部分封装 可移植性强 
### 采用 CAShapeLayer + CADisplayLink 实现  动画流畅 内存稳定  

```objective-c

@property (nonatomic,assign)UIEdgeInsets edgeInsets;        // 内容边距
@property (nonatomic,assign)UIEdgeInsets canvasEdgeInsets;  // 画布边距
@property (nonatomic,strong)ECAxisStyle *xStyle;            // x轴样式
@property (nonatomic,strong)ECAxisStyle *yStyle;            // y轴样式

@property (nonatomic,assign)NSInteger row;                  // 图表有多少行
@property (nonatomic,assign)NSInteger column;               // 图表有多少列



@property (nonatomic,assign)BOOL isShowGriddingGuide;       // 是否显示网格线
@property (nonatomic,strong)ECGuideStyle *griddingStyle;    // 网格样式

@property (nonatomic,assign)BOOL isShowHorizontalGuide;     // 是否显示水平辅助线
@property (nonatomic,strong)ECGuideStyle *horizontalStyle;  // 水平线样式

@property (nonatomic,assign)BOOL isShowVerticalGuide;       // 是否显示竖直辅助线
@property (nonatomic,strong)ECGuideStyle *verticalStyle;    // 竖直线样式

@property (nonatomic,copy)NSArray *columnData;            // x轴下标
@property (nonatomic,copy)NSArray *row1Data; // y1下标准
@property (nonatomic,copy)NSArray *row2Data; // y2下标准
// 销售额
@property (nonatomic, copy) NSArray *valueDataAry1;
// 销售毛利额
@property (nonatomic, copy) NSArray *valueDataAry2;

//@property (nonatomic,strong)NSArray *valueData;             // 展示数据
@property (nonatomic,assign)NSInteger precisionScale;       // 计算精度,10,100,1000,默认是1
@property (nonatomic,assign)NSInteger yAxisPrecisionScale;  // y轴下标计算精度,0,1,2,3,4,5,默认是2

@property (nonatomic,strong)ECAxisDataStyle *xAxisDataStyle;   // x轴下标样式
@property (nonatomic,strong)ECAxisDataStyle *yAxisDataStyle;   // y轴下标样式

@property (nonatomic,strong)ECAxisDataStyle *yValueDataStyle;  // 显示数据样式

@property (nonatomic,assign)BOOL isShowBenchmarkLine;          // 是否显示阈值线
@property (nonatomic,strong)ECBenchmarkLineStyle *benchmarkLineStyle; // 阈值线样式

// 柱状图
@property (nonatomic,assign)CGFloat histogramWidth;            // 柱状图宽度
@property (nonatomic,strong)UIColor *histogramFillColor1;       // 填充颜色
@property (nonatomic,strong)UIColor *histogramFillColor2;       // 填充颜色
@property (nonatomic,strong)UIColor *histogramClickFillColor;  // 点击柱状图颜色

@property (nonatomic,strong)UIColor *lineChartColor;           // 折线颜色
@property (nonatomic,assign)CGFloat lineChartWidth;            // 折线宽度
@property (nonatomic,assign)CGFloat lineChartDotRadius;        // 折线圆点
@property (nonatomic,strong)UIColor *lineChartDotColor;        // 折线圆点颜色
@property (nonatomic,copy)void(^histogramClickAction)(NSInteger index); // 点击柱状图回调事件

// 绘制图表
- (void)reloadData;
```
