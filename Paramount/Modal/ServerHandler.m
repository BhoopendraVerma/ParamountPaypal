//
//  AppDelegate.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 27/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

#import "ServerHandler.h"

@implementation ServerHandler

-(void)serviceRequestWithInfo:(NSDictionary *)infoDict serviceType:(ServiceRequestType)serviceType params:(id)params completionBlock:(CompletionBlock)block
{
    self.completionBlock=block;
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    NSString * urlString;
    
   if (serviceType == ServiceTypeGetCurrency)
    {
        urlString = [NSString stringWithFormat:@"http://data.fixer.io/api/latest?access_key=a8385073328d4bf3b32350c631ef323b&format=1"];
    }
    else if (serviceType == ServiceTypeGetHistory)
    {
        NSString * urlSt = [NSString new];
        urlSt = @"https://api.sandbox.paypal.com/v2/payments/authorizations/0VF52814937998046 ";
        urlString = [NSString stringWithFormat:@"%@",urlSt];
    }
    else if (serviceType == ServiceTypeGetCardDetails)
    {
        urlString = [NSString stringWithFormat:@"http://203.92.41.131/paramount/"];
        [request setHTTPMethod:@"POST"];
    }
   
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Url : %@",urlString);
    
    NSString * tokenString = [NSString new];
    tokenString = [NSString stringWithFormat:@"Bearer\%@",tokenString];
    
    
    if (params)
    {
        NSLog(@" Check Params %@",params);
        [request setURL:[NSURL URLWithString:urlString]];
        NSData *myData = [NSJSONSerialization dataWithJSONObject:params
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:nil];;
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:tokenString forHTTPHeaderField:@"Authorization"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:myData];
    }
    //        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

    
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    NSURLConnection * connection = [NSURLConnection connectionWithRequest:request delegate:(id)self];
    
}
    -(void)getPaypalAccessTocken:(NSString *)tokenString
    {
        NSString * tokenStr = [NSString new];
        
        NSString *clientID = @"AfhVxBUKOnf1E1DeT4o7-CQA0rfUco2NLLG0OAYXGdSRuf8gjbxzH7P77bTevnzY_1I60N6MXYYeLQqO";
        NSString *secret = @"EHoo2JnwGF_9FHUT6suHhUqPxy7GqZF4IjORONDW15zDHasBUf8KMpI6g3Jpb18GGr0_vpwrmjojvXYn";
        
        NSString *authString = [NSString stringWithFormat:@"%@:%@", clientID, secret];
        NSData * authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *credentials = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [configuration setHTTPAdditionalHeaders:@{ @"Accept": @"application/json", @"Accept-Language": @"en_US", @"Content-Type": @"application/x-www-form-urlencoded", @"Authorization": credentials }];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.sandbox.paypal.com/v1/oauth2/token"]];
        request.HTTPMethod = @"POST";
        
        NSString *dataString = @"grant_type=client_credentials";
        NSData *theData = [dataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:theData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
           //     NSLog(@"data = %@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
                NSDictionary * userInfo = [NSDictionary new];
                userInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSString * paypalToken = [NSString new];
                paypalToken = [userInfo valueForKey:@"access_token"];
                NSLog(@"Response %@",paypalToken);
                [[NSUserDefaults standardUserDefaults]setValue:paypalToken forKey:@"token"];
                
            }
        }];
        
        [task resume];
    }

#pragma NSURL Connection Delegates

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"error : %@",error.localizedDescription);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
    self.completionBlock(dict,nil);
    NSLog(@"Finished");
}


@end

