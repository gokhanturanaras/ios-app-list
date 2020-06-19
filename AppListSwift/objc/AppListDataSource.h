//
//  AppListDataSource.h
//  AppListSwift
//
//  Created by Gökhan on 4.07.2019.
//  
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppListDataSource : NSObject
- (NSArray *) fetchApps;
- (NSArray *)buildAppDictionary:(NSArray * )apps type:(NSString *) type;
- (BOOL)isInstalled:(NSString *)bundleId;
+ (NSString *)wifiMac;
+ (NSString *)wifiName;
@end
NS_ASSUME_NONNULL_END
