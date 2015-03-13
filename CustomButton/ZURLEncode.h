//
//  ZURLEncode.h
//  Connection
//
//  Created by Shashank Shandilya on 02/09/13.
//  Copyright (c) 2013 zovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZURLEncode : NSObject

    +(NSString*)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params;
@end
