//
//  WebService.swift
//  Currencies
//
//  Created by dede.exe on 31/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

public typealias ResponseHandler = (RequestResult<String?>, [String:Any]) -> Void

public class WebService {
    
    let manager : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    public static let instance : WebService = WebService()
    
    init() {}
    
    @discardableResult public func request(request : Endpoint, additionalHeaders:[String:String]? = nil, completion:@escaping ResponseHandler) -> URLRequest? {
        
        guard let url = URL(string: request.fullPath) else {
            return nil
        }
        
        var requestEntity = URLRequest(url: url)
        
        requestEntity.httpMethod = request.method.rawValue
        
        if let additionalHeaders = additionalHeaders {
            for (key, name) in additionalHeaders {
                requestEntity.setValue(name, forHTTPHeaderField: key)
            }
        }
        
        for (key, name) in request.headers {
            requestEntity.setValue(name, forHTTPHeaderField: key)
        }
        
        if request.encoding != .url {
            requestEntity.httpBody = request.body
        }
        
        manager.dataTask(with: requestEntity) { (data, response, error) in
            var statusCode = 0
            var description = ""
            var userInfo : [String:Any]? = [:]
            
            var headers : [String:Any] = [:]
            
            if let resp = response as? HTTPURLResponse {
                statusCode = resp.statusCode
                description = resp.description
                if let responseHeaders = resp.allHeaderFields as? [String : Any] {
                    headers = responseHeaders
                }
            }
            
            if let error = error {
                
                if let receivedData = data, let convertedData = String(data: receivedData, encoding: .utf8) {
                    userInfo?["data"] = convertedData
                }
                
                let err = NSError(domain: error.localizedDescription, code:statusCode, userInfo: userInfo)
                
                let result = RequestResult<String?>.fail(statusCode, err)
                completion(result, headers)
                return
            }
            
            if case 100..<400 = statusCode {
                let requestData = data ?? Data()
                let resultString = String(data: requestData, encoding: .utf8)
                let result = RequestResult<String?>.success(statusCode, resultString)
                completion(result, headers)
                return
            }
            
            userInfo?["errorDescription"] = description
            
            if let receivedData = data, let convertedData = String(data: receivedData, encoding: .utf8) {
                userInfo?["data"] = convertedData
            }
            
            let err = NSError(domain: "Networking Error", code: statusCode, userInfo:userInfo)
            let result = RequestResult<String?>.fail(statusCode, err)
            completion(result, headers)
            
            }.resume()
        
        return requestEntity
    }
    
}
