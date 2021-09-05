//
//  AppDelegate.m
//  appleShareDemo
//
//  Created by 贺文杰 on 2021/3/12.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#if DEBUG
 // iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#endif
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if (self.window) {
        if (url) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *fileNameStr = [NSString stringWithFormat:@"appleShareFile/%@", [url lastPathComponent]];
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *filePath = [documentPath stringByAppendingPathComponent:@"shareFile"];
            if (![fileManager fileExistsAtPath:filePath]) {
                [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
            }else{
                NSError *error = nil;
                NSArray *fileList = [fileManager contentsOfDirectoryAtPath:filePath error:&error];
                if (!error) {
                    //清除之前存储的文件
                    BOOL isDir = NO;
                    for (NSString *file in fileList) {
                        NSString *path = [filePath stringByAppendingPathComponent:file];
                        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
                        if (!isDir) {
                            NSError *removeError = nil;
                            [fileManager removeItemAtPath:path error:&removeError];
                            if (removeError) {
                                NSLog(@"清除失败:%@, 失败原因:%@", path, removeError.description);
                            }
                        }
                        isDir = NO;
                    }
                }
            }
            NSData *data = [NSData dataWithContentsOfURL:url];
            BOOL success = [data writeToFile:[NSString stringWithFormat:@"%@/%@", filePath, [url lastPathComponent]] atomically:YES];
            NSLog(@"文件%@%@存到本地文件夹内", fileNameStr, success ? @"已经" : @"没有");
        }
    }
    return YES;
}


@end
