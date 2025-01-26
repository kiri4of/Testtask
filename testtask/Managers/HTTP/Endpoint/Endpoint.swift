
import Foundation
import Alamofire

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    var urlRequest: URLRequest? {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        if let parameters = parameters {
            do {
                request = try encoding.encode(request, with: parameters)
            } catch {
                //if error in encoding process
                return nil
            }
        }
        return request
    }
}

