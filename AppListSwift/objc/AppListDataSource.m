//
//  AppListDataSource.m
//  AppListSwift
//
//  Created by Gökhan on 4.07.2019.
//  
//

#import "AppListDataSource.h"
#import "AppInfo.h"
#import "LSPlugInKitProxy.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface AppListDataSource ()
    @property (nonatomic, strong) NSDictionary *appsByCategory;
@end


static NSString *const SYSTEMAPPS_KEY = @"System";
static NSString *const USERAPPS_KEY = @"User";
static NSString *const ALLAPPS_KEY = @"allapps";
static NSMutableArray *datelistArray;

NSInteger nameSort(LSPlugInKitProxy *app1, LSPlugInKitProxy *app2, void *context) {
    return [app1.containingBundle.localizedName caseInsensitiveCompare:app2.containingBundle.localizedName];
}

@implementation AppListDataSource

+ (NSString *)wifiMac
{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *bssid = [dic objectForKey:@"BSSID"];
    
    return bssid;
}

+ (NSString *)wifiName
{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *bssid = [dic objectForKey:@"SSID"];
    
    return bssid;
}

- (NSArray *)fetchApps {
    if (datelistArray == nil) {
   

            NSMethodSignature *methodSignature = [NSClassFromString(@"LSApplicationWorkspace") methodSignatureForSelector:NSSelectorFromString(@"defaultWorkspace")];
            NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invoke setSelector:NSSelectorFromString(@"defaultWorkspace")];
            [invoke setTarget:NSClassFromString(@"LSApplicationWorkspace")];
        
            [invoke invoke];
            NSObject * __unsafe_unretained objc;
            [invoke getReturnValue:&objc];
        
        
            NSMethodSignature *installedPluginsmethodSignature = [NSClassFromString(@"LSApplicationWorkspace") instanceMethodSignatureForSelector:NSSelectorFromString(@"installedPlugins")];
            NSInvocation *installed = [NSInvocation invocationWithMethodSignature:installedPluginsmethodSignature];
            [installed setSelector:NSSelectorFromString(@"installedPlugins")];
            [installed setTarget:objc];
        
            [installed invoke];
            NSArray * __unsafe_unretained arr;
            [installed getReturnValue:&arr];

            for (NSObject *objc in arr) {
                if ([objc isKindOfClass:NSClassFromString(@"LSPlugInKitProxy")]) {
                    if (objc != nil) {
                        NSMethodSignature *installedPluginsmethodSignature = [NSClassFromString(@"LSPlugInKitProxy") instanceMethodSignatureForSelector:NSSelectorFromString(@"containingBundle")];
                        if (installedPluginsmethodSignature != nil) {
                            NSInvocation *installed = [NSInvocation invocationWithMethodSignature:installedPluginsmethodSignature];
                            if (installed != nil) {
                                [installed setSelector:NSSelectorFromString(@"containingBundle")];
                                [installed setTarget:objc];
                                
                                [installed invoke];
                                NSArray * __unsafe_unretained app;
                                [installed getReturnValue:&app];
                                
                                NSLog(@"%@",app);
                            }
                            
                        }
                        
                    }
                }
                
            }
        
            datelistArray = [[NSMutableArray alloc]init];
            NSMutableArray *dubList = [[NSMutableArray alloc]init];
            arr = [arr sortedArrayUsingFunction:nameSort context:NULL];
            for (LSPlugInKitProxy * data in arr)
            {
                if (data.containingBundle != nil) {
                    if([dubList indexOfObject:data.containingBundle.applicationIdentifier] == NSNotFound){
                        if (data.containingBundle.applicationIdentifier == data.containingBundle.bundleIdentifier) {
                            NSLog(@"%@", data.containingBundle.applicationIdentifier);
                            [dubList addObject:data.containingBundle.applicationIdentifier];
                            [datelistArray addObject:data];
                        }
                    
                    }
                }
               
            }
        }
    return datelistArray;
}

- (NSArray *)buildAppDictionary:(NSArray *)apps type:(NSString *) type {
    NSMutableArray *datelistArray = [[NSMutableArray alloc]init];

    
    for (LSPlugInKitProxy *app in apps) {
        // TODO: what if category is not "User" or "System"?
        if (app.containingBundle.bundleType == type || [type  isEqual: @"allApps"]) {
            [datelistArray addObject:app];
        }
    }
    
    NSLog(@"%@",[datelistArray sortedArrayUsingFunction:nameSort context:NULL]);
        return  [datelistArray sortedArrayUsingFunction:nameSort context:NULL];
}


- (BOOL)isInstalled:(NSString *)bundleId {
    NSBundle *container = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
    if ([container load]) {
        Class appContainer = NSClassFromString(@"MCMAppContainer");
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
        id container = [appContainer performSelector:@selector(containerWithIdentifier:error:) withObject:bundleId withObject:nil];
        #pragma clang diagnostic pop
        NSLog(@"%@", [container performSelector:@selector(identifier)]);
        if (container) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

@end
