/*
 Copyright 2010-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */
 


#import <AWSAPIGateway/AWSAPIGateway.h>
	
@interface AWSAPIGatewayClient ()
	
// Networking	
@property (nonatomic, strong) NSURLSession *session;
	
// For requests
@property (nonatomic, strong) NSURL *baseURL;
	
// For responses
@property (nonatomic, strong) NSDictionary *HTTPHeaderFields;
@property (nonatomic, assign) NSInteger HTTPStatusCode;

- (AWSTask *)invokeHTTPRequest:(NSString *)HTTPMethod	
                     URLString:(NSString *)URLString	
                pathParameters:(NSDictionary *)pathParameters	
               queryParameters:(NSDictionary *)queryParameters	
              headerParameters:(NSDictionary *)headerParameters	
                          body:(id)body	
                 responseClass:(Class)responseClass;

@end

@interface AWSServiceConfiguration()

@property (nonatomic, strong) AWSEndpoint *endpoint;

@end
