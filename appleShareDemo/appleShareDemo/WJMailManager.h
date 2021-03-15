//
//  WJMailManager.h
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJMailManager : NSObject

+ (WJMailManager *)sharedInstance;

//不带附件
- (void)sendMail:(UIViewController *)vc title:(NSString *)title toRecipients:(NSArray<NSString *> *)toRecipients CcRecipients:(NSArray<NSString *> *)ccRecipients content:(NSString *)content isHTML:(BOOL)isHTML;

//带附件
- (void)sendMail:(UIViewController *)vc title:(NSString *)title toRecipients:(NSArray<NSString *> *)toRecipients CcRecipients:(NSArray<NSString *> *)ccRecipients data:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
