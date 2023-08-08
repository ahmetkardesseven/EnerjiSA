//
//  APIRouter.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case userInvoices

    private var method: HTTPMethod {
        switch self {
        case .userInvoices:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .userInvoices:
            return "/userInvoices.json"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .userInvoices:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = Constants().baseURL
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
