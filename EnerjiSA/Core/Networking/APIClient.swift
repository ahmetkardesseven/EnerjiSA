//
//  APIClient.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import Foundation
import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
        }
    }
    
    static func userInvoices(completion:@escaping (Result<InvoiceModel, AFError>)->Void) {
        performRequest(route: APIRouter.userInvoices, completion: completion)
    }
}
