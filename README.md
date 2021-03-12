# appleShareDemo
原生分享

> 利用UIActivityViewController类进行分享，可以将图片视频直接分享至我们需要的平台，或者保存至系统的剪切板、备忘录、wechat等

## 示例代码

```
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

## 用到的类

* [UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller?language=objc)
* [UIActivity](https://developer.apple.com/documentation/uikit/uiactivity?language=objc)

## 参考

1. [UIActivityViewController系统分享](https://www.jianshu.com/p/f988fee55d85)

