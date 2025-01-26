
import Foundation
import Alamofire

enum SignUpEndpoint {
    case createUser(token: String)
}

extension SignUpEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://frontend-test-assignment-api.abz.agency")!
    }

    var path: String {
        switch self {
        case .createUser:
            return "/api/v1/users"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .createUser:
            return .post
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createUser(let token):
            return ["Token": token]
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
}
