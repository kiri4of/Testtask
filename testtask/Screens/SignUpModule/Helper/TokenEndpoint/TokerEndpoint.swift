
import Alamofire
import Foundation

enum TokenEndpoint {
    case getToken
}

extension TokenEndpoint: Endpoint {
    var baseURL: URL {
        URL(string: "https://frontend-test-assignment-api.abz.agency")!
    }
    
    var path: String {
        switch self {
        case .getToken:
            return "/api/v1/token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
}
