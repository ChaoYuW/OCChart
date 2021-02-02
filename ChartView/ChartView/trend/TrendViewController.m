//
//  TrendViewController.m
//  ChartView
//
//  Created by chao on 2021/2/2.
//

#import "TrendViewController.h"
#import "NavBarView.h"

@interface TrendViewController ()

@end

@implementation TrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    NavBarView *navBarView = [NavBarView navBarView];
    navBarView.navtitle = @"分时图";
    navBarView.CloseBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:navBarView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
