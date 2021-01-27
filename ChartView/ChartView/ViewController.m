//
//  ViewController.m
//  ChartView
//
//  Created by chao on 2020/10/8.
//

#import "ViewController.h"
#import "HistoryChart.h"

@interface ViewController ()
{
    HistoryChart *_hChartView;
    UIButton *_btn;
}
@property (strong, nonatomic) UIScrollView *myScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     //毛利额 = 销售额*毛利率 maolieArray = gmvArray * maolilvArray;
    
    
    

    [self.view addSubview:self.myScrollView];
    
    NSArray *salesAry = @[@"10000",@"3000",@"76300",@"5000",@"6000",@"6000",@"9800"];
    CGFloat w = salesAry.count *70 + 40 +40;
    HistoryChart *hChartView = [[HistoryChart alloc] initWithFrame:CGRectMake(0, 0, w, CGRectGetWidth(self.view.frame))];
//    hChartView.backgroundColor = UIColor.lightGrayColor;
    [self.myScrollView addSubview:hChartView];
    
    hChartView.row = 6;
    hChartView.valueDataAry1 = salesAry;
    hChartView.valueDataAry2 = @[@"5000",@"1000",@"30000",@"4000",@"5000",@"6000",@"9000"];
    hChartView.columnData = @[@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日"];
    hChartView.column = 7;
    self.myScrollView.contentSize = CGSizeMake(w, 400);
    
    _hChartView = hChartView;
    
    [hChartView reloadData];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    btn.frame = CGRectMake(150, 500, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    btn.showsTouchWhenHighlighted = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _btn = btn;
}

- (void)btnClick
{
    [_hChartView reloadData];
    [_btn setTitle:[NSString stringWithFormat:@"刷新 %ld",_hChartView.layer.sublayers.count] forState:0];
}

- (UIScrollView *)myScrollView
{
    if (_myScrollView) {
        return _myScrollView;
    }
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 400)];
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    return _myScrollView;
}
@end
