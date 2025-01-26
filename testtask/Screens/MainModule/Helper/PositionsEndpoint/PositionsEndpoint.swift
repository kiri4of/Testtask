
import Alamofire
import Foundation

enum PositionsEndpoint {
    case getPositions
}

extension PositionsEndpoint: Endpoint {
    var baseURL: URL {
        URL(string: "https://frontend-test-assignment-api.abz.agency")!
    }
    
    var path: String {
        switch self {
        case .getPositions:
            return "/api/v1/positions"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
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

