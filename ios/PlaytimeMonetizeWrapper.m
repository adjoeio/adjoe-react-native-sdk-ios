#import "PlaytimeMonetizeWrapper.h"

@implementation PlaytimeMonetizeWrapper

RCT_EXPORT_MODULE(PlaytimeMonetizeWrapper)

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_METHOD(
    initialize:(NSDictionary *)params
    resolve:(RCTPromiseResolveBlock)resolve
    reject:(RCTPromiseRejectBlock)reject)
{
    NSString *sdkHash = params[@"sdkHash"];
    NSString *userId = params[@"userId"];
    NSString *uaNetwork = params[@"uaNetwork"];
    NSString *uaChannel = params[@"uaChannel"];
    NSString *uaSubPublisherCleartext = params[@"uaSubPublisherCleartext"];
    NSString *uaSubPublisherEncrypted = params[@"uaSubPublisherEncrypted"];
    NSString *placement = params[@"placement"];
    
    if (sdkHash == nil) {
        reject(@"playtime_error", @"sdkHash is required", nil);
        return;
    }

    [Playtime initializeWithUserID:userId
                           sdkHash:sdkHash
                         uaNetwork:uaNetwork
                         uaChannel:uaChannel
           uaSubPublisherCleartext:uaSubPublisherCleartext
           uaSubPublisherEncrypted:uaSubPublisherEncrypted
                         placement:placement
                 completionHandler:^(NSError * _Nullable error) {
        if (!error) {
            RCTLog(@"Playtime initialized successfully");
            resolve(nil);
        } else {
            RCTLogError(@"Error initializing Playtime: %@", error);
            reject(@"playtime_error", @"Initialization error", error);
        }
    }];
}

RCT_EXPORT_METHOD(
    showCatalog:(NSDictionary *)params
    resolve:(RCTPromiseResolveBlock)resolve
    reject:(RCTPromiseRejectBlock)reject)
{
    NSString *uaNetwork = params[@"uaNetwork"];
    NSString *uaChannel = params[@"uaChannel"];
    NSString *uaSubPublisherCleartext = params[@"uaSubPublisherCleartext"];
    NSString *uaSubPublisherEncrypted = params[@"uaSubPublisherEncrypted"];
    NSString *placement = params[@"placement"];

    [Playtime showCatalogWithUaNetwork:uaNetwork
                              uaChannel:uaChannel
              uaSubPublisherCleartext:uaSubPublisherCleartext
            uaSubPublisherEncrypted:uaSubPublisherEncrypted
                           placement:placement
                   completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            RCTLogError(@"Error showing Playtime catalog: %@", error);
            reject(@"playtime_error", @"Playtime catalog error", error);
            return;
        }
        
        resolve(nil);
    }];
}

@end
