//
//  ZConnection.h
//  Connection
//
//  Created by Shashank Shandilya on 19/08/13.
//  Copyright (c) 2013 zovi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZURLEncode.h"
@class AppDelegate;
@interface ZConnection : NSObject {
    int count;
}
    
    
    @property(readonly) NSData* receivedData;
    @property(readonly) NSURLResponse* response;

    // Commodity accesors to "response" values :
    @property(readonly) NSInteger httpStatusCode;
	@property(readonly) NSString* receivedString; // NSString built using receivedData and response.textEncodingName

    -(id)initWithRequestUrl:(NSString *)url type:(NSString *)type withParam:(NSDictionary *)param;

    -(void)processRequestWithResponseHandler:(void (^)(NSURLResponse* response))responseReceivedHandler progress:(void (^)(NSUInteger receivedBytes, long long expectedBytes))progressHandler completion:(void (^)(NSData* receivedData,NSInteger httpStatusCode))completionHandler errorHandler:(void (^)(NSError* error))errorHandler;

    -(void)processRequsetWithCompletion:(void (^)(NSData* receivedData,NSInteger httpStatusCode))completionHandler errorHandler:(void (^)(NSError* error))errorHandler;

@end
