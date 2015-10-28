//
//  Response.swift
//  WatsonCore
//
//  Scaled down version of Alamofire response object
//
//  Created by Vincent Herrin on 10/12/15.
//  Copyright © 2015 MIL. All rights reserved.
//

import SwiftyJSON
import Foundation


public enum CoreResponseEnum: String {
    case Status = "status"
    case StatusInfo = "statusInfo"
    case ErrorCode = "error_code"
    case ErrorMessage = "error_message"
    case ErrorMessage2 = "error"
    case Ok = "Ok"
    case Error = "Error"
    case Unknown = "Unknown"
    case Empty = ""
}

/**
*  The Main response back for Watson Core.  It will contain the status, status info
and the status code for the http response.
*/
public struct CoreResponse: CustomStringConvertible {
    
    // private capture of the response to report back with certain values to the caller
    let httpResponse: NSHTTPURLResponse!
    
    /// The data returned by the server.
    public let data: AnyObject!
    
    public var statusCode:Int {
        get {
            var codeValue = 0
            if (httpResponse != nil) {
                codeValue = HTTPStatusCode(HTTPResponse: httpResponse)!.rawValue
            }
            return codeValue
        }
    }
    
    private var _statusInfo: String! = nil
    
    public var statusInfo: String {
        get {
            
            if(_statusInfo == nil) {
                return HTTPStatusCode(HTTPResponse: httpResponse)!.description
            }
            return _statusInfo
        }
    }
    
    public var description: String {
        return "\(statusInfo)"
    }

    init(anyObject: AnyObject, httpresponse: NSHTTPURLResponse!) {
        self.httpResponse = httpresponse
        self.data = anyObject
        Log.sharedLogger.verbose("\(anyObject)")

        if (anyObject is NSError) {
            _statusInfo = (anyObject as! NSError).description
        }
        else {
            var returnData = JSON(anyObject)
            // Alchemy
            if let statusInfo = returnData[CoreResponseEnum.StatusInfo.rawValue].string {self._statusInfo = statusInfo}
            // Watson
            else if let statusInfo = returnData[CoreResponseEnum.ErrorMessage.rawValue].string {self._statusInfo = statusInfo}
            // Some Watson services
            else if let statusInfo = returnData[CoreResponseEnum.ErrorMessage2.rawValue].string {self._statusInfo = statusInfo}
        }
        Log.sharedLogger.debug(description)
    }
}