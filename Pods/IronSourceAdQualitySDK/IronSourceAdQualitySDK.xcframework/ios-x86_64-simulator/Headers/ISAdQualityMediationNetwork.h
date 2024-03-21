//
//  ISAdQualityMediationNetwork.h
//  SoomlaTraceback
//
//  Created by Ben Zilonka on 02/10/2022.
//  Copyright © 2022 SOOMLA. All rights reserved.
//

typedef enum {
    IS_AD_QUALITY_MEDIATION_NETWORK_UNKNOWN             = -1,
    IS_AD_QUALITY_MEDIATION_NETWORK_ADMOB               = 0,
    IS_AD_QUALITY_MEDIATION_NETWORK_DT_FAIR_BID         = 1,
    IS_AD_QUALITY_MEDIATION_NETWORK_HELIUM              = 2,
    IS_AD_QUALITY_MEDIATION_NETWORK_LEVEL_PLAY          = 3,
    IS_AD_QUALITY_MEDIATION_NETWORK_MAX                 = 4,
    IS_AD_QUALITY_MEDIATION_NETWORK_UNITY               = 5,
    IS_AD_QUALITY_MEDIATION_NETWORK_SELF_MEDIATED       = 6,
    IS_AD_QUALITY_MEDIATION_NETWORK_OTHER               = 7
} ISAdQualityMediationNetwork;
