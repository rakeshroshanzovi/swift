//
//  ZURLEncode.m
//  Connection
//
//  Created by Shashank Shandilya on 02/09/13.
//  Copyright (c) 2013 zovi. All rights reserved.
//

#import "ZURLEncode.h"

@interface ZURLEncode(){
 
//    -(NSString *)urlEscape:(NSString *)unencodedString;
    
    
    
}

    +(NSString *)urlEscape:(NSString *)unencodedString;

@end

@implementation ZURLEncode

    +(NSString *)urlEscape:(NSString *)unencodedString{
        NSString *s = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) unencodedString, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]%", kCFStringEncodingUTF16));
        return s;
    }

    static NSString *toString(id object) {
        return [NSString stringWithFormat: @"%@", object];
    }
    static NSString *urlEncode(id object) {
        NSString *string = toString(object);
        return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    }

    +(NSString*)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params{
        
        NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:url];
        if(params){
            [urlWithQuerystring appendString:@"?"];
            NSMutableArray *parts = [NSMutableArray array];
            for (id key in params) {
                id value = [params objectForKey: key];
                NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
                [parts addObject: part];
            }
            [urlWithQuerystring appendString:[parts componentsJoinedByString:@"&"]];
        }
        return urlWithQuerystring;
    }
    
@end
