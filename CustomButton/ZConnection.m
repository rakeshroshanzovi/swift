//
//  ZConnection.m
//  Connection
//
//  Created by Shashank Shandilya on 19/08/13.
//  Copyright (c) 2013 zovi. All rights reserved.
//

#import "ZConnection.h"
#import "CustomButton-Swift.h"

#define TIMEOUT 30.0
@interface ZConnection(){

    NSURLRequest* _request;
	NSURLConnection* _connection;
	NSMutableData* _data;
	NSURLResponse* _response;
    NSDictionary* _param;
    NSString* _type;

    void (^_responseReceivedBlock)(NSURLResponse*);
	void (^_progressBlock)(NSUInteger,long long);
	void (^_completionBlock)(NSData*, NSInteger);
	void (^_errorBlock)(NSError*);
}

    -(NSURLRequest *) processGetUrlString:(NSString *)url withParam:(NSDictionary *)param;
    -(NSURLRequest *) processPostUrlString:(NSString *)url withParam:(NSDictionary *)param;
    -(NSURLRequest *) processPutUrlString:(NSString *)url withParam:(NSDictionary *)parma;

@end

@implementation ZConnection


    -(NSURLRequest *) processPutUrlString:(NSString *)url withParam:(NSMutableDictionary *)param{
        count = 1;
        NSMutableURLRequest *req;
        NSData *requestData = nil;
        req = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:TIMEOUT];
        [req setHTTPMethod:@"PUT"];
        [req setHTTPShouldHandleCookies:YES];
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error;
        requestData = [NSJSONSerialization dataWithJSONObject:param
                                                      options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                        error:&error];
        if (!error) {
            [req setHTTPBody:requestData];
        }else{
            NSLog(@"problem with converting parameter into json");
        }
        return req;
    }

    -(NSURLRequest *) processPostUrlString:(NSString *)url withParam:(NSDictionary *)param{
        count = 1;
        NSMutableURLRequest *req;
        NSData *requestData = nil;
        req = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:TIMEOUT];
        [req setHTTPMethod:@"POST"];
        [req setHTTPShouldHandleCookies:YES];
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSError *error;
        requestData = [NSJSONSerialization dataWithJSONObject:param
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (!error) {
            [req setHTTPBody:requestData];
        }else{
            NSLog(@"problem with converting parameter into json");
        }
        return req;
    }

    -(NSURLRequest *) processGetUrlString:(NSString *)url withParam:(NSDictionary *)param{
        count = 1;
        NSURLRequest *req;
        NSString *eurl  = [ZURLEncode addQueryStringToUrl:url params:param];
     
        eurl = [eurl stringByReplacingOccurrencesOfString:@"&="
                                             withString:@"&"];
        eurl = [eurl stringByReplacingOccurrencesOfString:@"?="
                                               withString:@"?"];
        req = [NSURLRequest requestWithURL:[ NSURL URLWithString:eurl ]  cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:TIMEOUT];
        return req;
    }

    -(id)initWithRequestUrl:(NSString *)url type:(NSString *)type withParam:(NSDictionary *)param{
        
        NSLog(@"init with request url %@ with type %@ withParam %@", url , type, param);
        self = [ super init]  ;
        
        if ( [ type  isEqualToString:@"GET"] ){
            _request = [self processGetUrlString:url withParam:param];
        }else if ([ type isEqualToString:@"POST"]){
            _request = [self processPostUrlString:url withParam:param];
        }else if ([ type isEqualToString:@"PUT"]){
            _request = [self processPutUrlString:url withParam:param];
        }
        return self;
    }



    -(void)processRequestWithResponseHandler:(void (^)(NSURLResponse *))responseReceivedHandler progress:(void (^)(NSUInteger, long long))progressHandler completion:(void (^)(NSData *, NSInteger))completionHandler errorHandler:(void (^)(NSError *))errorHandler{
    
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.connectionAvail == 2) {
            NSLog(@"connection Unavailable");
            return;
        }
        _responseReceivedBlock = [responseReceivedHandler copy];
        _progressBlock = [progressHandler copy];
        _completionBlock = [completionHandler copy];
        _errorBlock = [errorHandler copy];
        _response = nil;
        _data = [[NSMutableData alloc] init];
        if(_request && count < 2){
            count = count + 1;
                _connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];

        }else{
            NSLog(@"request object not defined");
           
        }
        
    }

    -(void)processRequsetWithCompletion:(void (^)(NSData *, NSInteger))completionHandler errorHandler:(void (^)(NSError *))errorHandler{
       

        [self processRequestWithResponseHandler:nil progress:nil completion:completionHandler errorHandler:errorHandler];
        
    }

    // NSURLConnection Delegate Methods

    -(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

        [_data setLength:0];
        _response = response;
        if (_responseReceivedBlock) {
            _responseReceivedBlock(response);
        }
    }


    -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
        [_data appendData:data];
        if (_progressBlock) {
            _progressBlock([self.receivedData length],[self.response expectedContentLength]);
        }

    }

    -(void)connectionDidFinishLoading:(NSURLConnection *)connection {
        if (_completionBlock) {
            _completionBlock(self.receivedData,self.httpStatusCode);
        }
        _connection = nil;
    }

    -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
        if (_errorBlock) {
            _errorBlock(error);
        }
        _connection = nil;
       
    }

    -(NSData*)receivedData {
        return (NSData*)_data;
    }

    -(NSInteger)httpStatusCode {
        if ([_response isKindOfClass:[NSHTTPURLResponse class]]) {
            return ((NSHTTPURLResponse*)_response).statusCode;
        } else {
            return 0;
        }
    }

    -(NSString*)receivedString {
        NSStringEncoding enc = NSISOLatin1StringEncoding; // Default fallback
	
        NSString* textEncodingName = _response.textEncodingName;
        if (textEncodingName) {
            CFStringEncoding cfEnc = CFStringConvertIANACharSetNameToEncoding((CFStringRef)textEncodingName);
            enc = CFStringConvertEncodingToNSStringEncoding(cfEnc);
        }
        return [[NSString alloc] initWithData:self.receivedData encoding:enc];
    }

@end
