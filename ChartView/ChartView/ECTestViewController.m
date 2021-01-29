//
//  ECTestViewController.m
//  ChartView
//
//  Created by chao on 2021/1/28.
//

#import "ECTestViewController.h"

@interface ECTestViewController ()
{
    CGPoint _centerPosition;
}
@property (strong, nonatomic) UIView *displayView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;


@end

@implementation ECTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 11.0, *)) {
            UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                self.navHeight.constant = 88;
            }
        }else
        {
            self.navHeight.constant = 64;
        }

    
    CGFloat selfWidth = [UIScreen mainScreen].bounds.size.width;

    self.displayView.frame = CGRectMake(20, 150, selfWidth-2*20, 300);
    [self.view addSubview:self.displayView];
    
    _centerPosition = CGPointMake(self.displayView.center.x,self.displayView.center.y-CGRectGetMinY(self.displayView.frame));

    [self addBezierPath2];
    
}
// 二次贝塞尔曲线
- (void)addBezierPath2
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:(CGPoint){0,0}];
//    [path addQuadCurveToPoint:(CGPoint){100,50} controlPoint:(CGPoint){100,100}];
    [path addArcWithCenter:(CGPoint){0,0} radius:10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.position = _centerPosition;
    pathLayer.lineWidth = 2.0;
    pathLayer.strokeColor = [UIColor yellowColor].CGColor;
    pathLayer.fillColor = UIColor.whiteColor.CGColor;
    pathLayer.path = path.CGPath;
    [self.displayView.layer addSublayer:pathLayer];
    
    // 红色二次贝塞尔曲线
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, 0)];
    CGPoint end2Point = CGPointMake(100, 50);
//    [path2 addQuadCurveToPoint:end2Point controlPoint:CGPointMake(100, 200)]; // 二次贝塞尔曲线
    CAShapeLayer *path2Layer = [CAShapeLayer layer];
    path2Layer.position = _centerPosition;
    path2Layer.lineWidth = 2;
    path2Layer.strokeColor = [UIColor redColor].CGColor;
    path2Layer.fillColor = nil; // 默认为blackColor
    path2Layer.path = path2.CGPath;
    [self.displayView.layer addSublayer:path2Layer];
    
}


- (IBAction)closeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIView *)displayView
{
    if (_displayView == nil) {
        _displayView = UIView.new;
        _displayView.backgroundColor = UIColor.systemPinkColor;
    }
    return _displayView;
}
@end
