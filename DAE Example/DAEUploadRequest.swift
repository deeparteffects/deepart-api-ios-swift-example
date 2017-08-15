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
 

import Foundation
import AWSCore

 
public class DAEUploadRequest : AWSModel {
    
    /** The unique identifier for a style */
    var styleId: String?
    /** Base64 decoded image */
    var imageBase64Encoded: String?
    /** Image size in px. Picture will be resized for processing. */
    var imageSize: NSNumber?
    /** The unique identifier for a partner with dedicated api access. */
    var partnerId: String?
    /** Use this flag to get an artwork optimized for print. */
    var optimizeForPrint: NSNumber?
    /** Use this flag to use the original color from your photo for the artwork. */
    var useOriginalColors: NSNumber?
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["styleId"] = "styleId"
		params["imageBase64Encoded"] = "imageBase64Encoded"
		params["imageSize"] = "imageSize"
		params["partnerId"] = "partnerId"
		params["optimizeForPrint"] = "optimizeForPrint"
		params["useOriginalColors"] = "useOriginalColors"
		
        return params
	}
}
