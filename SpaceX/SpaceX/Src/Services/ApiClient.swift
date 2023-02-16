//
//  ApiClient.swift
//  SpaceX
//
//  Created by Александр Головин on 16.02.2023.
//

import Moya

enum ApiClient {
    case getData(page: Int)
    case getDetailInfo(id: String)
}

extension ApiClient: TargetType {
    
    var baseURL: URL {
        URL(string: "https://api.spacexdata.com")!
    }
    
    var path: String {
        switch self {
        case .getData:
            return "/v4/launches"
        case .getDetailInfo(let id):
            return "/v4/launches/:\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .getData, .getDetailInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
         case .getDetailInfo, .getData:
             return .requestPlain
         }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}

