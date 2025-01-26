
import Foundation
import Alamofire

enum MainEndpoint {
    case getUsers(page: Int, count: Int)
}

extension MainEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://frontend-test-assignment-api.abz.agency")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/api/v1/users"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getUsers(let page, let count):
            return ["page": page, "count": count]
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
}
