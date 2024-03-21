//
//  ISAdQualitySegment.h
//  SoomlaTraceback
//
//  Created by Yuri Marinkov on 20/11/2022.
//  Copyright © 2022 SOOMLA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISAdQualitySegment : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int age;
@property (nonatomic) NSString *gender;
@property (nonatomic) int level;
@property (nonatomic) BOOL isPaying;
@property (nonatomic) double inAppPurchasesTotal;
@property (nonatomic, strong) NSDate *userCreationDate;
@property (nonatomic, strong, readonly) NSMutableDictionary *customData;

- (void)setCustomValue:(NSString *)value forKey:(NSString *)key;

@end
