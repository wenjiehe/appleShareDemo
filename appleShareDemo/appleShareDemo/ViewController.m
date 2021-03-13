//
//  ViewController.m
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/12.
//

#import "ViewController.h"
#import "WJCustomActivity.h"
#import <Social/Social.h>


typedef NS_ENUM(NSUInteger, ServiceShareType) {
    ServiceShareTypeWeChat, //微信
    ServiceShareTypeQQ, //腾讯QQ
    ServiceShareTypeSinaWeibo,  //新浪微博
    ServiceShareTypeTencentWeibo,  //腾讯微博
    ServiceShareTypeFacebook,
    ServiceShareTypeVimeo,
    ServiceShareTypeTwitter,  //推特
    ServiceShareTypeYouDao,  //有道笔记
    ServiceShareTypeYiXin,  //易信
};


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //系统自带的分享
//    [self callShare];
    
    //重写系统自带的分享或动作
//    [self callCustomShareOrAction];
    
    //自定义分享
    [self callCustomViewShare];
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

//自定义分享的平台或动作
- (void)callCustomShareOrAction
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

- (void)callCustomViewShare
{
//    NSString *type = [self serviceTypeWithType:ServiceShareTypeFacebook];
    NSString *type = @"com.apple.Maps.GeneralMapsWidget";
    if (![SLComposeViewController isAvailableForServiceType:type]) {
        NSLog(@"没有相关配置");
        return;
    }
    
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:type];
    if(composeVC){
//        [composeVC addImage:[UIImage imageNamed:@"wuzhuo.jpg"]];
        [composeVC addURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        [composeVC setInitialText:@"五竹"];
        
        [self presentViewController:composeVC animated:YES completion:^{
                    
        }];
        
        composeVC.completionHandler = ^(SLComposeViewControllerResult result) {
            if(result == SLComposeViewControllerResultDone){ //确定
                NSLog(@"SLComposeViewControllerResultDone");
            }else if (result == SLComposeViewControllerResultCancelled){ //取消
                NSLog(@"SLComposeViewControllerResultCancelled");
            }
        };
    }
    
}

- (NSString *)serviceTypeWithType:(ServiceShareType)shareType
{
    NSString *type = @"";
    switch(shareType){
        case ServiceShareTypeWeChat:
            type = @"com.tencent.xin.sharetimeline";
            break;
        case ServiceShareTypeVimeo:
            type = @"com.apple.share.Vimeo.post";
            break;
        case ServiceShareTypeQQ:
            type = @"com.tencent.mqq.ShareExtension";
            break;
        case ServiceShareTypeTwitter:
            type = @"com.apple.share.Twitter.post";
            break;
        case ServiceShareTypeFacebook:
            type = @"com.apple.share.Facebook.post";
            break;
        case ServiceShareTypeYiXin:
            type = @"com.yixin.yixin.YXShareExtension";
            break;
        case ServiceShareTypeYouDao:
            type = @"com.youdao.note.iphone.shareExtension";
            break;
        case ServiceShareTypeSinaWeibo:
            type = @"com.apple.share.SinaWeibo.post";
            break;
        case ServiceShareTypeTencentWeibo:
            type = @"com.apple.share.TencentWeibo.post";
            break;
    }
    return type;
}

@end
