//
//  WJCustomActivity.h
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJCustomActivity : UIActivity

- (instancetype)initWithTitle:(NSString *)title withActivityImage:(UIImage *)image withUrl:(NSURL *)url withType:(NSString *)type withShareContent:(NSArray *)shareContent;

@end

NS_ASSUME_NONNULL_END
