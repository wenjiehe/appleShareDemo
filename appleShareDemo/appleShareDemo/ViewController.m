//
//  ViewController.m
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/12.
//

#import "ViewController.h"
#import "WJCustomActivity.h"
#import <Social/Social.h>
#import "WJMailManager.h"

typedef NS_ENUM(NSUInteger, ServiceShareType) {
    ServiceShareTypeWeChat, //微信
    ServiceShareTypeQQ, //腾讯QQ
    ServiceShareTypeSinaWeibo,  //新浪微博
    ServiceShareTypeTencentWeibo,  //腾讯微博
    ServiceShareTypeFacebook,
    ServiceShareTypeVimeo,
    ServiceShareTypeTwitter,  //推特
    ServiceShareTypeYouDao,  //有道笔记
    ServiceShareTypeHealth, //健康app
    ServiceShareTypeDing, //钉钉
    ServiceShareTypeAlipay, //支付宝
    ServiceShareTypeTaobao, //淘宝
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
//    [self callCustomViewShare];
    
    //发送邮件
    [[WJMailManager sharedInstance] sendMail:self title:@"随意打的" toRecipients:@[@"94282425@qq.com"] CcRecipients:@[@""] content:@"个人及饿哦该金融恶搞金融嗯根据哦我机构外加工外加工未根据欧文架构概括为顾客王凯文OK哦顾客我刚看我的空空" isHTML:NO];
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
    /*
     SOCIAL_EXTERN NSString *const SLServiceTypeTwitter NS_DEPRECATED(10_8, 10_13, 6_0, 11_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeFacebook NS_DEPRECATED(10_8, 10_13, 6_0, 11_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo NS_DEPRECATED(10_8, 10_13, 6_0, 11_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo NS_DEPRECATED(10_8, 10_13, 6_0, 11_0);
     SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn NS_DEPRECATED(10_8, 10_13, 6_0, 11_0);
     */
    NSString *type = [self serviceTypeWithType:ServiceShareTypeDing];
    //匹配其他app的Share Extension
    if (![SLComposeViewController isAvailableForServiceType:type]) {
        NSLog(@"没有相关配置");
        return;
    }
    
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:type];
    if(composeVC){
        [composeVC addImage:[UIImage imageNamed:@"wuzhuo.jpg"]];
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
        case ServiceShareTypeDing:
            type = @"com.laiwang.DingTalk.ShareExtension";
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
        case ServiceShareTypeAlipay:
            type = @"com.alipay.iphoneclient.ExtensionSchemeShare";
            break;
        case ServiceShareTypeHealth:
            type = @"com.apple.Health.HealthShareExtension";
            break;
        case ServiceShareTypeTaobao:
            type = @"com.taobao.taobao4iphone.ShareExtension";
            break;
    }
    return type;
}

@end
