//
//  ISAdQualityCustomMediationRevenue.h
//  SoomlaTraceback
//
//  Created by Ben Zilonka on 29/09/2022.
//  Copyright © 2022 SOOMLA. All rights reserved.
//

#import "ISAdQualityMediationNetwork.h"
#import "ISAdQualityAdType.h"

@interface ISAdQualityCustomMediationRevenue : NSObject

@property (nonatomic) ISAdQualityMediationNetwork mediationNetwork;
@property (nonatomic) ISAdQualityAdType adType;
@property (nonatomic) double revenue;
@property (nonatomic) NSString *placement;

@end
