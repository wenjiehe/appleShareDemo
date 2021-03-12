//
//  ViewController.m
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/12.
//

#import "ViewController.h"
#import "WJCustomActivity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self callShare];
    [self callCustomShare];
}

- (void)callShare
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    UIImage *image = [UIImage imageNamed:@"wuzhuo.jpg"];
    NSString *str = @"do something";
    NSArray *items = @[url, image, str];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    //设置分享弹框，点击视图外，是否可以消失，YES不消失
    if (@available(iOS 13.0, *)) {
        activityVC.modalInPresentation = YES;
    } else {
        activityVC.modalInPopover = YES;
    }
    //去除特定的分享功能
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
    [self presentViewController:activityVC animated:YES completion:^{
            
    }];
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        if (completed) {
            NSLog(@"完成");
        }else{
            NSLog(@"取消 error = %@", activityError);
        }
    };
    activityVC.completionWithItemsHandler = itemsBlock;
    
}

- (void)callCustomShare
{
    UIImage *image = [UIImage imageNamed:@"wuzhuo.jpg"];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSString *str = @"ice";
    NSArray *items = @[url, image, str];


    WJCustomActivity *customActivity = [[WJCustomActivity alloc] initWithTitle:@"五竹" withActivityImage:image withUrl:url withType:@"WJCustomActivity" withShareContent:items];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:@[customActivity]];
    [self presentViewController:activityVC animated:YES completion:^{
            
    }];
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        if (completed) {
            if ([activityType isEqualToString:@"WJCustomActivity"]) {
                //do something
            }
            NSLog(@"完成");
        }else{
            NSLog(@"取消 error = %@", activityError);
        }
    };
    activityVC.completionWithItemsHandler = itemsBlock;
}

@end
