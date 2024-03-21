/*
 * Copyright (C) 2012-2016 Soomla Inc. - All Rights Reserved
 *
 *   Unauthorized copying of this file, via any medium is strictly prohibited
 *   Proprietary and confidential
 *
 *   Written by Refael Dakar <refael@soom.la>
 */

#import <Foundation/Foundation.h>
#import "ISAdQualityAdType.h"
#import "ISAdQualityConfig.h"
#import "ISAdQualityCustomMediationRevenue.h"
#import "ISAdQualitySegment.h"

#define IRONSOURCE_AD_QUALITY_VERSION    @"7.17.0"

static NSString *IRONSOURCE_AD_QUALITY_TAG = @"ISAdQualitySDK";

@protocol ISAdQualityDelegate <NSObject>

@required

@optional

- (void)adDisplayedForAdNetwork:(NSString *)adNetwork andAdType:(ISAdQualityAdType)adType;
- (void)adClosedForAdNetwork:(NSString *)adNetwork andAdType:(ISAdQualityAdType)adType;

@end

@interface IronSourceAdQuality : NSObject

@property (nonatomic, weak) id<ISAdQualityDelegate> delegate;

+ (IronSourceAdQuality *)getInstance;
+ (NSString *)getSDKVersion;

- (void)initializeWithAppKey:(NSString *)appKey;
- (void)initializeWithAppKey:(NSString *)appKey andConfig:(ISAdQualityConfig *)config;
- (void)shutdown;
- (void)changeUserId:(NSString *)userId;
- (void)sendCustomMediationRevenue:(ISAdQualityCustomMediationRevenue *)customMediationRev;
- (void)setSegment:(ISAdQualitySegment *)segment;

- (void)setUserConsent:(BOOL)userConsent __attribute__((deprecated("This method has been deprecated and will be removed soon")));

@end
