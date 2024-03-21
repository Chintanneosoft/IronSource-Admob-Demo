/*
 * Copyright (C) 2012-2015 Soomla Inc. - All Rights Reserved
 *
 *   Unauthorized copying of this file, via any medium is strictly prohibited
 *   Proprietary and confidential
 *
 *   Written by Refael Dakar <refael@soom.la>
 */

/**
 an Enumaration listing all the ads available
 */
typedef enum {
    IS_AD_QUALITY_AD_TYPE_UNKNOWN           = -1,
    IS_AD_QUALITY_AD_TYPE_RICH_MEDIA        = 0,
    IS_AD_QUALITY_AD_TYPE_INTERSTITIAL      = 1,
    IS_AD_QUALITY_AD_TYPE_APP_WALL          = 2,
    IS_AD_QUALITY_AD_TYPE_VIDEO             = 3,
    IS_AD_QUALITY_AD_TYPE_REWARDED_VIDEO    = 4,
    IS_AD_QUALITY_AD_TYPE_NATIVE            = 5,
    IS_AD_QUALITY_AD_TYPE_BANNER            = 6,
    IS_AD_QUALITY_AD_TYPE_OFFER_WALL        = 7,
    IS_AD_QUALITY_AD_TYPE_NATIVE_HTML       = 8,
    IS_AD_QUALITY_AD_TYPE_EXTERNAL          = 9,
    IS_AD_QUALITY_AD_TYPE_REWARDED          = 10,
    IS_AD_QUALITY_AD_TYPE_INTERACTIVE       = 11
} ISAdQualityAdType;
