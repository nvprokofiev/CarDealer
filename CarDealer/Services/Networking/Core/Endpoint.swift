//
//  Endpoint.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
    var parameterEncoding: ParameterEnconding { get }
    var method: HTTPMethod { get }
}

//MARK:- Default overriding
extension Endpoint {
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameterEncoding: ParameterEnconding {
        return .defaultEncoding
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: [String : Any]? {
        return [:]
    }
}

//MARK: - Endpoint implementation
extension Endpoint {

    private var scheme: String { return "https" }
    private var host: String { return "carfax-for-consumers.firebaseio.com" }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        guard let params = params, method != .get else { return request }

        switch parameterEncoding {
        case .defaultEncoding:
            request.httpBody = params.percentEscaped().data(using: .utf8)
        case .jsonEncoding:
            request.setJSONContentType()
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = jsonData
        case .compositeEncoding:
            if let bodyParams = params["body"] as? [String: Any] {
                request.setJSONContentType()
                let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams)
                request.httpBody = jsonData
            }
        }
        return request
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum ParameterEnconding {
    case defaultEncoding
    case jsonEncoding
    case compositeEncoding
}
