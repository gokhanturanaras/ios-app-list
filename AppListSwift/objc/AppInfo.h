//
//  AppInfo.h
//  AppListSwift
//
//  Created by Gökhan on 4.07.2019.
//  
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LSApplicationProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppInfo : NSObject
@property (nonatomic, readonly) NSString *filterdata; // so we can build predicates for filtering
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) NSString *companyName;
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) BOOL isUserApp;

@property (nonatomic, readonly) UIImage *icon;

- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy;
- (NSInteger)propertyCount;
- (id)objectAtIndexedSubscript:(NSInteger)idx;
- (id)objectForKeyedSubscript:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
