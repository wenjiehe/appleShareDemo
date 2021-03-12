# appleShareDemo
原生分享

> 利用UIActivityViewController类进行分享，可以将图片视频直接分享至我们需要的平台，或者保存至系统的剪切板、备忘录、wechat等


## 部分示例代码

```Objective-C
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
```

## 可分享的平台或功能

```Objective-C
typedef NSString * UIActivityType NS_TYPED_EXTENSIBLE_ENUM;

UIKIT_EXTERN UIActivityType const UIActivityTypePostToFacebook     API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypePostToTwitter      API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypePostToWeibo        API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;    // SinaWeibo
UIKIT_EXTERN UIActivityType const UIActivityTypeMessage            API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeMail               API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypePrint              API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeCopyToPasteboard   API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeAssignToContact    API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeSaveToCameraRoll   API_AVAILABLE(ios(6.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeAddToReadingList   API_AVAILABLE(ios(7.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypePostToFlickr       API_AVAILABLE(ios(7.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypePostToVimeo        API_AVAILABLE(ios(7.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypePostToTencentWeibo API_AVAILABLE(ios(7.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeAirDrop            API_AVAILABLE(ios(7.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeOpenInIBooks       API_AVAILABLE(ios(9.0)) __TVOS_PROHIBITED;
UIKIT_EXTERN UIActivityType const UIActivityTypeMarkupAsPDF        API_AVAILABLE(ios(11.0)) __TVOS_PROHIBITED;
```

## 用到的类

* [UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller?language=objc)
* [UIActivity](https://developer.apple.com/documentation/uikit/uiactivity?language=objc)

## 参考

1. [UIActivityViewController系统分享](https://www.jianshu.com/p/f988fee55d85)

