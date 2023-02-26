//
//  ApiClient.swift
//  SpaceX
//
//  Created by Александр Головин on 16.02.2023.
//

import Moya

enum ApiClient {
    case getData(page: Int)
    case getDetailInfo
}

extension ApiClient: TargetType {
    
    var baseURL: URL {
        URL(string: "https://api.spacexdata.com")!
    }
    var path: String {
        switch self {
        case .getData:
            return "/v4/launches/query"
        case .getDetailInfo:
            return "/v4/crew"
        }
    }
    
    var method: Method {
        switch self {
        case .getData:
            return .post
        case .getDetailInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDetailInfo:
            return .requestPlain
        case .getData(let page):
            return .requestParameters(parameters: ["options": ["page": page, "limit": 10, "sort": ["date_utc": "desc"]]], encoding: JSONEncoding.default)
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

    var utf8Encoded: Data {
        Data(self.utf8)
    }
}

