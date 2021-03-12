//
//  WJCustomActivity.m
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/12.
//

#import "WJCustomActivity.h"

@interface WJCustomActivity ()

@property(nonatomic, copy)NSString *title; /**< 分享按钮标题 */
@property(nonatomic, strong)UIImage *image; /**< 分享按钮图片 */
@property(nonatomic, strong)NSURL *url;  /**< URL */
@property(nonatomic, copy)NSString *type; /**< 平台类型 */
@property(nonatomic, strong)NSArray *shareContent; /**< 分享内容 */

@end

@implementation WJCustomActivity

- (instancetype)initWithTitle:(NSString *)title withActivityImage:(UIImage *)image withUrl:(NSURL *)url withType:(NSString *)type withShareContent:(NSArray *)shareContent
{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _url = url;
        _type = type;
        _shareContent = shareContent;
    }
    return self;
}

#pragma mark -- 显示位置 顶部title，中间share，底部action
+ (UIActivityCategory)activityCategory{
    return UIActivityCategoryShare;
}

- (NSString *)activityType{
    return _type;
}

- (NSString *)activityTitle{
    return _title;
}

- (UIImage *)activityImage
{
    return _image;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if (activityItems.count > 0) {
        return YES;
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    if ([_type isEqualToString:@"WJCustomActivity"]) {
        NSLog(@"WJCustomActivity");
    }else{
        NSLog(@"t43895439");
    }
}

- (void)performActivity{
    [self activityDidFinish:YES];
}

@end
