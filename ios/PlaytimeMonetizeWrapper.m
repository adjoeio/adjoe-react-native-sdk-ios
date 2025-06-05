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
    
    NSString *subId1 = params[@"subId1"];
    NSString *subId2 = params[@"subId2"];
    NSString *subId3 = params[@"subId3"];
    NSString *subId4 = params[@"subId4"];
    NSString *subId5 = params[@"subId5"];
    
    PlaytimeExtensionsBuilder *extensionsBuilder = [[PlaytimeExtensionsBuilder alloc] init];
    extensionsBuilder = [extensionsBuilder setSubId1:subId1];
    extensionsBuilder = [extensionsBuilder setSubId2:subId2];
    extensionsBuilder = [extensionsBuilder setSubId3:subId3];
    extensionsBuilder = [extensionsBuilder setSubId4:subId4];
    extensionsBuilder = [extensionsBuilder setSubId5:subId5];
    
    PlaytimeParamsBuilder *paramsBuilder = [[PlaytimeParamsBuilder alloc] init];
    paramsBuilder = [paramsBuilder setUANetwork:uaNetwork];
    paramsBuilder = [paramsBuilder setUAChannel:uaChannel];
    paramsBuilder = [paramsBuilder setUASubPublisherCleartext:uaSubPublisherCleartext];
    paramsBuilder = [paramsBuilder setUASubPublisherEncrypted:uaSubPublisherEncrypted];
    paramsBuilder = [paramsBuilder setPlacement:placement];

    PlaytimeOptionsBuilder *optionsBuilder = [[PlaytimeOptionsBuilder alloc] init];
    optionsBuilder = [optionsBuilder setParams:[paramsBuilder build]];
    optionsBuilder = [optionsBuilder setExtensions:[extensionsBuilder build]];
    
    [Playtime showCatalogWithOptions:[optionsBuilder build]
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
