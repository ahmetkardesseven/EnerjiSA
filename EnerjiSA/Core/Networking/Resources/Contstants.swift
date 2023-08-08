//
//  Contstants.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 5.08.2023.
//

import Foundation

final class Constants {
    static var shared = Constants()
    
    var baseURL: URL = URL(filePath: "https://raw.githubusercontent.com/bydevelopertr/enerjisa/main")
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
