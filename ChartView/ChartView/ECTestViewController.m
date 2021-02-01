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

//    [self addBezierPath2];
    

    CGFloat offsetY = 20;
    
    CGFloat headerCornerRadius=80;
    CGFloat arcCenterX = selfWidth/2;
    CGFloat arcCenterY= offsetY+headerCornerRadius;
    
    //画头部
    CAShapeLayer *headLayer=[[CAShapeLayer alloc] init];
    UIBezierPath *headerPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(selfWidth/2-headerCornerRadius, offsetY, headerCornerRadius*2, headerCornerRadius*2) cornerRadius:headerCornerRadius];
    [self setLayer:headLayer path:headerPath];
    
    //脸
    CAShapeLayer *faceLayer=[CAShapeLayer layer];
    UIBezierPath *facePath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(selfWidth/2, offsetY+headerCornerRadius+10) radius:70 startAngle:M_PI endAngle:3*M_PI clockwise:YES];
    [self setLayer:faceLayer path:facePath];
    
    //左眼
    CAShapeLayer *leftEyeLayer = [CAShapeLayer layer];
    UIBezierPath *leftEyePath = [UIBezierPath bezierPath];
    
    [leftEyePath moveToPoint:CGPointMake(arcCenterX-30, arcCenterY-25)];
    
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX-15, arcCenterY-45) controlPoint:CGPointMake(arcCenterX-30, arcCenterY-45)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX, arcCenterY-25) controlPoint:CGPointMake(arcCenterX, arcCenterY-45)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX-15, arcCenterY-5) controlPoint:CGPointMake(arcCenterX, arcCenterY-5)];
    [leftEyePath addQuadCurveToPoint:CGPointMake(arcCenterX-30, arcCenterY-25) controlPoint:CGPointMake(arcCenterX-30, arcCenterY-5)];
    
    [self setLayer:leftEyeLayer path:leftEyePath];
    leftEyeLayer.backgroundColor = UIColor.redColor.CGColor;
    
    
    //左眼珠
    CAShapeLayer *leftEyeBallLayer = [CAShapeLayer layer];
    UIBezierPath *leftEyeBallPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX-5, arcCenterY-30) radius:2.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:leftEyeBallLayer path:leftEyeBallPath ];
    
    //右眼
    CAShapeLayer *rightEyeLayer = [CAShapeLayer layer];
    UIBezierPath *rightEyePath = [UIBezierPath bezierPath];
    [rightEyePath moveToPoint:CGPointMake(arcCenterX, arcCenterY-25)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX+15, arcCenterY-45) controlPoint:CGPointMake(arcCenterX, arcCenterY-45)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX+30, arcCenterY-25) controlPoint:CGPointMake(arcCenterX+30, arcCenterY-45)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX+15, arcCenterY-5) controlPoint:CGPointMake(arcCenterX+30, arcCenterY-5)];
    [rightEyePath addQuadCurveToPoint:CGPointMake(arcCenterX, arcCenterY-25) controlPoint:CGPointMake(arcCenterX, arcCenterY-5)];
    [self setLayer:rightEyeLayer path:rightEyePath  ];
    
    
    //右眼珠
    CAShapeLayer *rightEyeBallLayer = [CAShapeLayer layer];
    UIBezierPath *rightEyeBallPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX+5, arcCenterY-30) radius:2.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:rightEyeBallLayer path:rightEyeBallPath];
    
    //鼻子
    CAShapeLayer *noseLayer  = [CAShapeLayer layer];
    UIBezierPath *nosePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX, arcCenterY) radius:10 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:noseLayer path:nosePath ];
    
    //鼻子光晕
    CAShapeLayer *noseHaloLayer = [CAShapeLayer layer];
    UIBezierPath *noseHaloPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX-4, arcCenterY-5) radius:2.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:noseHaloLayer path:noseHaloPath ];
    
    //嘴巴
    CAShapeLayer *mouthLayer = [CAShapeLayer layer];
    UIBezierPath *mouthPath = [UIBezierPath bezierPath];
    [mouthPath moveToPoint:CGPointMake(arcCenterX-60, arcCenterY+25)];
    [mouthPath addQuadCurveToPoint:CGPointMake(arcCenterX+60, arcCenterY+25) controlPoint:CGPointMake(arcCenterX, arcCenterY+90)];
    [self setLayer:mouthLayer path:mouthPath];
    
    CAShapeLayer *mouthLayer1 = [CAShapeLayer layer];
    UIBezierPath *mouthPath1 = [UIBezierPath bezierPath];
    [mouthPath1 moveToPoint:CGPointMake(arcCenterX, arcCenterY+10)];
    [mouthPath1 addLineToPoint:CGPointMake(arcCenterX, arcCenterY+55)];
    [self setLayer:mouthLayer1 path:mouthPath1];
    
    //胡子
    [self addBeardFromPoint:CGPointMake(arcCenterX-58, arcCenterY-5) toPoint:CGPointMake(arcCenterX-15, arcCenterY+10)  ];
    [self addBeardFromPoint:CGPointMake(arcCenterX-68, arcCenterY+15) toPoint:CGPointMake(arcCenterX-15, arcCenterY+20)  ];
    [self addBeardFromPoint:CGPointMake(arcCenterX-61, arcCenterY+45) toPoint:CGPointMake(arcCenterX-15, arcCenterY+30)  ];
    [self addBeardFromPoint:CGPointMake(arcCenterX+58, arcCenterY-5) toPoint:CGPointMake(arcCenterX+15, arcCenterY+10)  ];
    [self addBeardFromPoint:CGPointMake(arcCenterX+68, arcCenterY+15) toPoint:CGPointMake(arcCenterX+15, arcCenterY+20) ];
    [self addBeardFromPoint:CGPointMake(arcCenterX+61, arcCenterY+45) toPoint:CGPointMake(arcCenterX+15, arcCenterY+30) ];
    
    
    //左手
    CAShapeLayer *leftHandLayer = [CAShapeLayer layer];
    UIBezierPath *leftHandPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX-95, arcCenterY+110) radius:20 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:leftHandLayer path:leftHandPath ];
    
    //左胳膊
    CGFloat distanceXToArcCenter = 80*cos(M_PI_2*4/9);
    CGFloat distanceYToArcCenter = 80*sin(M_PI_2*4/9);
    CAShapeLayer *leftArmLayer = [CAShapeLayer layer];
    UIBezierPath *leftArmPath = [UIBezierPath bezierPath];
    [leftArmPath moveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+distanceYToArcCenter)];
    [leftArmPath addLineToPoint:CGPointMake(arcCenterX-95, arcCenterY+90)];
    [leftArmPath addQuadCurveToPoint:CGPointMake(arcCenterX-75, arcCenterY+110) controlPoint:CGPointMake(arcCenterX-92, arcCenterY+107)];
    [leftArmPath addLineToPoint:CGPointMake(arcCenterX-distanceXToArcCenter+1.5, arcCenterY+95)];
    [self setLayer:leftArmLayer path:leftArmPath ];
    
    //围巾
    CAShapeLayer *mufflerLayer = [CAShapeLayer layer];
    UIBezierPath *mufflerPath = [UIBezierPath bezierPath];
    [mufflerPath moveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+distanceYToArcCenter)];
    [mufflerPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter, arcCenterY+distanceYToArcCenter) controlPoint:CGPointMake(arcCenterX, arcCenterY+109)];
    [mufflerPath addLineToPoint:CGPointMake(arcCenterX+distanceXToArcCenter+2, arcCenterY+distanceYToArcCenter+7)];
    [mufflerPath addQuadCurveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter-4, arcCenterY+distanceYToArcCenter+5) controlPoint:CGPointMake(arcCenterX, arcCenterY+115)];
    [mufflerPath addLineToPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+distanceYToArcCenter)];
    [self setLayer:mufflerLayer path:mufflerPath ];
    
    //身体
    CAShapeLayer *bodyLayer = [CAShapeLayer layer];
    UIBezierPath *bodyPath = [UIBezierPath bezierPath];
    [bodyPath moveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+distanceYToArcCenter+7)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter+5, arcCenterY+150) controlPoint:CGPointMake(arcCenterX-distanceXToArcCenter+2, arcCenterY+140)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter+3, arcCenterY+170) controlPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+160)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX-8, arcCenterY+170) controlPoint:CGPointMake(arcCenterX-(distanceXToArcCenter+5)/2, arcCenterY+175)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+8, arcCenterY+170) controlPoint:CGPointMake(arcCenterX, arcCenterY+155)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter-3, arcCenterY+170) controlPoint:CGPointMake(arcCenterX+(distanceXToArcCenter+5)/2, arcCenterY+175)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter-5, arcCenterY+150) controlPoint:CGPointMake(arcCenterX+distanceXToArcCenter-2, arcCenterY+160)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter, arcCenterY+distanceYToArcCenter+8) controlPoint:CGPointMake(arcCenterX+distanceXToArcCenter-2, arcCenterY+140)];
    [bodyPath addQuadCurveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter, arcCenterY+distanceYToArcCenter+7) controlPoint:CGPointMake(arcCenterX, arcCenterY+115)];
    [self setLayer:bodyLayer path:bodyPath ];
    
    
    //左脚
    CAShapeLayer *leftFootLayer = [CAShapeLayer layer];
    UIBezierPath *leftFootPath = [UIBezierPath bezierPath];
    [leftFootPath moveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter+3, arcCenterY+170)];
    [leftFootPath addQuadCurveToPoint:CGPointMake(arcCenterX-distanceXToArcCenter+3, arcCenterY+195) controlPoint:CGPointMake(arcCenterX-distanceXToArcCenter-20, arcCenterY+185)];
    [leftFootPath addQuadCurveToPoint:CGPointMake(arcCenterX-13, arcCenterY+195) controlPoint:CGPointMake(arcCenterX-(distanceXToArcCenter+10)/2, arcCenterY+200)];
    [leftFootPath addQuadCurveToPoint:CGPointMake(arcCenterX-10, arcCenterY+170) controlPoint:CGPointMake(arcCenterX+8, arcCenterY+187)];
    [self setLayer:leftFootLayer path:leftFootPath ];
    
    
    //右脚
    CAShapeLayer *rightFootLayer = [CAShapeLayer layer];
    UIBezierPath *rightFootPath = [UIBezierPath bezierPath];
    [rightFootPath moveToPoint:CGPointMake(arcCenterX+10, arcCenterY+170)];
    [rightFootPath addQuadCurveToPoint:CGPointMake(arcCenterX+15, arcCenterY+195) controlPoint:CGPointMake(arcCenterX-12, arcCenterY+185)];
    [rightFootPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter-5, arcCenterY+195) controlPoint:CGPointMake(arcCenterX+(distanceXToArcCenter+20)/2, arcCenterY+200)];
    [rightFootPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter-3, arcCenterY+170) controlPoint:CGPointMake(arcCenterX+distanceXToArcCenter+18, arcCenterY+185)];
    [self setLayer:rightFootLayer path:rightFootPath];
    
    //肚子
    CAShapeLayer *bellyLayer = [CAShapeLayer layer];
    UIBezierPath *bellyPath = [UIBezierPath bezierPath];
    [bellyPath moveToPoint:CGPointMake(arcCenterX-30, arcCenterY+80)];
    [bellyPath addCurveToPoint:CGPointMake(arcCenterX-30, arcCenterY+150) controlPoint1:CGPointMake(arcCenterX-65, arcCenterY+95) controlPoint2:CGPointMake(arcCenterX-60, arcCenterY+140)];
    [bellyPath addQuadCurveToPoint:CGPointMake(arcCenterX+30, arcCenterY+150) controlPoint:CGPointMake(arcCenterX, arcCenterY+160)];
    [bellyPath addCurveToPoint:CGPointMake(arcCenterX+30, arcCenterY+80) controlPoint1:CGPointMake(arcCenterX+60, arcCenterY+140) controlPoint2:CGPointMake(arcCenterX+65, arcCenterY+95)];
    [bellyPath addQuadCurveToPoint:CGPointMake(arcCenterX-30, arcCenterY+80) controlPoint:CGPointMake(arcCenterX, arcCenterY+92)];
    [self setLayer:bellyLayer path:bellyPath ];
    
    //铃铛
    CAShapeLayer *bellLayer = [CAShapeLayer layer];
    UIBezierPath *bellPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX, arcCenterY+97) radius:15 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:bellLayer path:bellPath  ];
    
    
    //铃铛上的线
    CAShapeLayer *bellLineLayer = [CAShapeLayer layer];
    UIBezierPath *BellLinePath = [UIBezierPath bezierPath];
    [BellLinePath moveToPoint:CGPointMake(arcCenterX-(sqrt(pow(15.0, 2)-pow(5.0, 2))), arcCenterY+92)];
    [BellLinePath addLineToPoint:CGPointMake(arcCenterX+(sqrt(pow(15.0, 2)-pow(5.0, 2))), arcCenterY+92)];
    [BellLinePath moveToPoint:CGPointMake(arcCenterX+(sqrt(pow(15.0, 2)-pow(2.0, 2))), arcCenterY+95)];
    [BellLinePath addLineToPoint:CGPointMake(arcCenterX-(sqrt(pow(15.0, 2)-pow(2.0, 2))), arcCenterY+95)];
    [self setLayer:bellLineLayer path:BellLinePath ];
    
    
    //铃铛上的小圆点
    CAShapeLayer *bellCirLayer = [CAShapeLayer layer];
    UIBezierPath *bellCirPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX, arcCenterY+102) radius:2.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [bellCirPath moveToPoint:CGPointMake(arcCenterX, arcCenterY+104.5)];
    [bellCirPath addLineToPoint:CGPointMake(arcCenterX, arcCenterY+112)];
    [self setLayer:bellCirLayer path:bellCirPath ];
    
    //口袋
    CAShapeLayer *bagLayer = [CAShapeLayer layer];
    UIBezierPath *bagPath = [UIBezierPath bezierPath];
    [bagPath moveToPoint:CGPointMake(arcCenterX-40, arcCenterY+112)];
    [bagPath addQuadCurveToPoint:CGPointMake(arcCenterX+40, arcCenterY+112) controlPoint:CGPointMake(arcCenterX, arcCenterY+120)];
    [bagPath addCurveToPoint:CGPointMake(arcCenterX-40, arcCenterY+112) controlPoint1:CGPointMake(arcCenterX+28, arcCenterY+160) controlPoint2:CGPointMake(arcCenterX-28, arcCenterY+160)];
    [self setLayer:bagLayer path:bagPath];
    
    
    //右手
    CAShapeLayer *rightHandLayer = [CAShapeLayer layer];
    UIBezierPath *rightHandPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcCenterX+85*cos(27/180.0*M_PI), arcCenterY-85*sin(27/180.0*M_PI)) radius:20 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self setLayer:rightHandLayer path:rightHandPath ];
    
    
    //右胳膊
    CAShapeLayer *rightArmLayer = [CAShapeLayer layer];
    UIBezierPath *rightArmPath = [UIBezierPath bezierPath];
    [rightArmPath moveToPoint:CGPointMake(arcCenterX+80*cos(13/180.0*M_PI), arcCenterY-80*sin(13/180.0*M_PI))];
    [rightArmPath addQuadCurveToPoint:CGPointMake(arcCenterX+distanceXToArcCenter, arcCenterY+distanceYToArcCenter) controlPoint:CGPointMake(arcCenterX+80*cos(13/180.0*M_PI)+9, arcCenterY+20)];
    [rightArmPath addLineToPoint:CGPointMake(arcCenterX+distanceXToArcCenter, arcCenterY+distanceYToArcCenter+25)];
    [rightArmPath addQuadCurveToPoint:CGPointMake(arcCenterX+93*cos(15/180.0*M_PI), arcCenterY-93*sin(15/180.0*M_PI)) controlPoint:CGPointMake(arcCenterX+90*cos(13/180.0*M_PI)+15, arcCenterY+25)];
    [rightArmPath addQuadCurveToPoint:CGPointMake(arcCenterX+80*cos(13/180.0*M_PI), arcCenterY-80*sin(13/180.0*M_PI)) controlPoint:CGPointMake(arcCenterX+80*cos(13/180.0*M_PI)+5, arcCenterY-93*sin(15/180.0*M_PI)+5)];
    [self setLayer:rightArmLayer path:rightArmPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(selfWidth/2+90, offsetY, 70, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1];
    label.text = @"Hello";
    label.font = [UIFont fontWithName:@"Chalkduster" size:20];
    [self.displayView addSubview:label];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 0.5f;
    [label.layer addAnimation:animation forKey:nil];
    
    //上色
    faceLayer.fillColor = [UIColor whiteColor].CGColor;
    leftEyeLayer.fillColor = [UIColor whiteColor].CGColor;
    rightEyeLayer.fillColor = [UIColor whiteColor].CGColor;
    leftEyeBallLayer.fillColor = [UIColor blackColor].CGColor;
    rightEyeBallLayer.fillColor = [UIColor blackColor].CGColor;
    noseLayer.fillColor = [UIColor redColor].CGColor;
    noseHaloLayer.fillColor = [UIColor whiteColor].CGColor;
    headLayer.fillColor = [UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1].CGColor;
    leftArmLayer.fillColor = [UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1].CGColor;
    leftHandLayer.fillColor = [UIColor whiteColor].CGColor;
    mufflerLayer.fillColor = [UIColor redColor].CGColor;
    bellyLayer.fillColor = [UIColor whiteColor].CGColor;
    bellLayer.fillColor = [UIColor yellowColor].CGColor;
    bodyLayer.fillColor = [UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1].CGColor;
    rightHandLayer .fillColor=[UIColor whiteColor].CGColor ;
    rightArmLayer .fillColor=[UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1] .CGColor;
    
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
- (void)addBeardFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
{
    CAShapeLayer *beardLayer1 = [CAShapeLayer layer];
    UIBezierPath *beardPath1 = [UIBezierPath bezierPath];
    [beardPath1 moveToPoint:fromPoint];
    [beardPath1 addLineToPoint:toPoint];
    [self setLayer:beardLayer1 path:beardPath1 ];
}
-(void)setLayer:(CAShapeLayer *)layer path:(UIBezierPath *)path{
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor=[UIColor lightGrayColor].CGColor;
    [self.displayView.layer addSublayer:layer];
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
