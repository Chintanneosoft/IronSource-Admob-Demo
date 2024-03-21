//
//  ISAdQualityConfig.h
//  ironSource Ad Quality
//
//  Created by Boris Spektor on 25/10/2018.
//  Copyright © 2018 SOOMLA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IS_AD_QUALITY_LOG_LEVEL_NONE       = 0,
    IS_AD_QUALITY_LOG_LEVEL_ERROR      = 1,
    IS_AD_QUALITY_LOG_LEVEL_WARNING    = 2,
    IS_AD_QUALITY_LOG_LEVEL_INFO       = 3,
    IS_AD_QUALITY_LOG_LEVEL_DEBUG      = 4,
    IS_AD_QUALITY_LOG_LEVEL_VERBOSE    = 5
} ISAdQualityLogLevel;

typedef enum {
    IS_AD_QUALITY_INIT_ERROR_SDK_WAS_SHUTDOWN                               = 0,
    IS_AD_QUALITY_INIT_ERROR_ILLEGAL_USER_ID                                = 1,
    IS_AD_QUALITY_INIT_ERROR_ILLEGAL_APPKEY                                 = 2,
    IS_AD_QUALITY_INIT_ERROR_EXCEPTION_ON_INIT                              = 3,
    IS_AD_QUALITY_INIT_ERROR_NO_NETWORK_CONNECTION                          = 4,
    IS_AD_QUALITY_INIT_ERROR_CONFIG_LOAD_TIMEOUT                            = 5,
    IS_AD_QUALITY_INIT_ERROR_CONNECTOR_LOAD_TIMEOUT                         = 6,
    IS_AD_QUALITY_INIT_ERROR_AD_NETWORK_VERSION_NOT_SUPPORTED_YET           = 7,
    IS_AD_QUALITY_INIT_ERROR_AD_NETWORK_SDK_REQUIRES_NEWER_AD_QUALITY_SDK   = 8,
    IS_AD_QUALITY_INIT_ERROR_AD_QUALITY_ALREADY_INITIALIZED                 = 9
} ISAdQualityInitError;

typedef enum {
    IS_AD_QUALITY_DEVICE_ID_TYPE_NONE       = 0,
    IS_AD_QUALITY_DEVICE_ID_TYPE_GAID       = 1,
    IS_AD_QUALITY_DEVICE_ID_TYPE_IDFA       = 2,
} ISAdQualityDeviceIdType;

@protocol ISAdQualityInitDelegate <NSObject>
- (void)adQualitySdkInitSuccess;
- (void)adQualitySdkInitFailed:(ISAdQualityInitError)error withMessage:(NSString *)message;
@end

@interface ISAdQualityConfig : NSObject

@property (nonatomic) NSString *userId;
@property (nonatomic) BOOL testMode;
@property (nonatomic) ISAdQualityLogLevel logLevel;
@property (nonatomic, weak) id<ISAdQualityInitDelegate> adQualityInitDelegate;
@property (nonatomic) NSString *initializationSource;
@property (nonatomic) BOOL coppa;
@property (nonatomic) ISAdQualityDeviceIdType deviceIdType;
@property (nonatomic, strong, readonly) NSMutableDictionary *metaData;

+ (ISAdQualityConfig *)config;

- (void)setMetaDataDictionary:(NSDictionary *)dict;

- (void)setMetaData:(NSString *)value forKey:(NSString *)key;

@end
