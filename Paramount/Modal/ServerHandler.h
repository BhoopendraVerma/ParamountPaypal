//
//  AppDelegate.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 27/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ServiceTypeGetCurrency,
    ServiceTypeGetHistory,
    ServiceTypeGetCardDetails,


}ServiceRequestType;

typedef void(^CompletionBlock)(id response, NSError *error);

@interface ServerHandler : NSObject

@property (nonatomic, strong)NSMutableData * responseData;

@property (nonatomic, strong)CompletionBlock  completionBlock;

-(void)serviceRequestWithInfo:(NSDictionary *)infoDict serviceType:(ServiceRequestType)serviceType params:(id)params completionBlock:(CompletionBlock)block;
    -(void)getPaypalAccessTocken:(NSString *)tokenString;
    
@end
