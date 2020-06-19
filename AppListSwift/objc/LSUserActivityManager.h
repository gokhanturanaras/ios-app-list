/* Generated by RuntimeBrowser
   Image: /System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices
 */

@interface LSUserActivityManager : NSObject <LSUserActivityClientResponseProtocol> {
    NSUUID * _activeUserActivityUUID;
    bool  _activityContinuationIsEnabled;
    NSXPCConnection * _connection;
    bool  _connectionInitializationSucceeded;
    bool  _needToSendInitialMessage;
    NSObject<OS_dispatch_queue> * _serverQ;
    bool  _supportsActivityContinuation;
    NSMapTable * _userActivitiesByUUID;
}

@property (copy) NSUUID *activeUserActivityUUID;
@property (readonly) bool activityContinuationIsEnabled;
@property (readonly, retain) NSXPCConnection *connection;
@property (readonly, copy) NSString *debugDescription;
@property (readonly, copy) NSString *description;
@property (readonly) unsigned long long hash;
@property (readonly) NSObject<OS_dispatch_queue> *serverQ;
@property (readonly) Class superclass;
@property (readonly) bool supportsActivityContinuation;
@property (retain) NSMapTable *userActivitiesByUUID;

+ (id)defaultManager;
+ (bool)shouldSupportActivityContinuation;
+ (bool)userActivityContinuationSupported;

- (id)_findUserActivityForUUID:(id)arg1;
- (id)activeUserActivityUUID;
- (bool)activityContinuationIsEnabled;
- (void)addDynamicUserActivity:(id)arg1 matching:(id)arg2;
- (void)addUserActivity:(id)arg1;
- (void)askClientUserActivityToSave:(id)arg1;
- (void)askClientUserActivityToSave:(id)arg1 completionHandler:(id /* block */)arg2;
- (id)connection;
- (id)createByDecodingUserActivity:(id)arg1;
- (void)dealloc;
- (void)didReceiveInputStreamWithUUID:(id)arg1 inputStream:(id)arg2 outputStream:(id)arg3;
- (id)encodeUserActivity:(id)arg1;
- (void)fetchUUID:(id)arg1 withCompletionHandler:(id /* block */)arg2;
- (id)init;
- (id)initWithConnection:(id)arg1;
- (void)makeActive:(id)arg1;
- (void)makeInactive:(id)arg1;
- (void)markUserActivityAsDirty:(id)arg1 forceImmediate:(bool)arg2;
- (void)pinUserActivity:(id)arg1 withCompletionHandler:(id /* block */)arg2;
- (void)removeDynamicUserActivity:(id)arg1 matching:(id)arg2;
- (void)removeUserActivity:(id)arg1;
- (void)sendInitialMessage;
- (void)sendUserActivityInfoToLSUserActivityd:(id)arg1 makeCurrent:(bool)arg2;
- (id)serverQ;
- (void)setActiveUserActivityUUID:(id)arg1;
- (void)setUserActivitiesByUUID:(id)arg1;
- (bool)supportsActivityContinuation;
- (void)tellClientUserActivityItWasResumed:(id)arg1;
- (void)tellDaemonAboutNewLSUserActivity:(id)arg1;
- (id)userActivitiesByUUID;
- (bool)userActivityIsActive:(id)arg1;

@end
