//
//  WJMailManager.m
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/15.
//

#import "WJMailManager.h"
#import <MessageUI/MessageUI.h>

@interface WJMailManager ()<MFMailComposeViewControllerDelegate>

@property(nonatomic, strong)MFMailComposeViewController *mailComposeVC;
@property(nonatomic, weak)UIViewController *weakVC;

@end

@implementation WJMailManager

+ (WJMailManager *)sharedInstance
{
    static WJMailManager *Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[self alloc] init];

    });
    return Instance;
}

- (void)sendMail:(UIViewController *)vc title:(NSString *)title toRecipients:(NSArray<NSString *> *)toRecipients CcRecipients:(NSArray<NSString *> *)ccRecipients content:(NSString *)content isHTML:(BOOL)isHTML data:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName
{
    _weakVC = vc;
    if ([MFMailComposeViewController canSendMail]) { //用户是否已设置邮件账户
        if ([MFMessageComposeViewController canSendText]) {
            self.mailComposeVC = [[MFMailComposeViewController alloc] init];
            self.mailComposeVC.mailComposeDelegate = self;
            
            if (@available(iOS 11.0, *)) {
                [self.mailComposeVC setPreferredSendingEmailAddress:@"123610105@qq.com"]; //设置邮件发送账号
            } else {
                // Fallback on earlier versions
            }
            [self.mailComposeVC setSubject:title]; //设置邮件主题
            [self.mailComposeVC setToRecipients:toRecipients]; //邮件接收账户
            [self.mailComposeVC setCcRecipients:ccRecipients]; //添加抄送账户
//            [self.mailComposeVC setBccRecipients:@[@""]];
            if (data) {
                [self.mailComposeVC addAttachmentData:[NSData data] mimeType:mimeType fileName:fileName]; //添加附件 可以添加图片、文档等
            }else{
                [self.mailComposeVC setMessageBody:content isHTML:YES]; //邮件内容，支持HTML格式
            }
            
            [vc presentViewController:self.mailComposeVC animated:YES completion:^{
                            
            }];
        }else{
            NSLog(@"设备不支持");
        }
    }else{
        NSLog(@"未设置邮件账户");
    }
}

//不带附件
- (void)sendMail:(UIViewController *)vc title:(NSString *)title toRecipients:(NSArray<NSString *> *)toRecipients CcRecipients:(NSArray<NSString *> *)ccRecipients content:(NSString *)content isHTML:(BOOL)isHTML
{
    [self sendMail:vc title:title toRecipients:toRecipients CcRecipients:ccRecipients content:content isHTML:isHTML data:nil mimeType:nil fileName:nil];
}

//带附件
- (void)sendMail:(UIViewController *)vc title:(NSString *)title toRecipients:(NSArray<NSString *> *)toRecipients CcRecipients:(NSArray<NSString *> *)ccRecipients data:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName
{
    [self sendMail:vc title:title toRecipients:toRecipients CcRecipients:ccRecipients content:nil isHTML:NO data:data mimeType:mimeType fileName:fileName];
}

#pragma mark -- MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"error = %@", error);
    }
    if (result == MFMailComposeResultSent) {
        NSLog(@"邮件发送成功");
    }else if (result == MFMailComposeResultSaved){
        NSLog(@"邮件保存成功");
    }else if (result == MFMailComposeResultFailed){
        NSLog(@"邮件发送失败");
    }else if (result == MFMailComposeResultCancelled){
        NSLog(@"邮件发送取消");
    }
    [_weakVC dismissViewControllerAnimated:YES completion:^{
                
    }];
}

@end
