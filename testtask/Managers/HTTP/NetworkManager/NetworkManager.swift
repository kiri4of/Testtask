
import Alamofire
import Foundation

enum APIError: Error {
    case clientError(String)
    case serverError(String)
    case unknownError(String)
    case networkError(message: String)
}

enum APIResult<T> {
    case success(T)
    case failure(APIError)
}

protocol NetworkManagerProtocol {
    func sendRequest<T: Decodable>(request: URLRequestConvertible, completion: @escaping (APIResult<T>) -> Void)
    
    func uploadMultipart<T: Decodable> (
        request: URLRequestConvertible,
        formDataBuilder: @escaping ((MultipartFormData) -> Void),
        completion: @escaping ((APIResult<T>) -> Void)
    )
}

final class NetworkManager: NetworkManagerProtocol {
    func sendRequest<T>(request: Alamofire.URLRequestConvertible, completion: @escaping (APIResult<T>) -> Void) where T : Decodable {
        AF.request(request)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if let error = self.processStatusCode(statusCode) {
                            completion(.failure(error))
                        } else {
                            completion(.failure(APIError.unknownError(error.localizedDescription)))
                        }
                    }
                }
            }
    }
    
    func uploadMultipart<T>(request: Alamofire.URLRequestConvertible, formDataBuilder: @escaping ((Alamofire.MultipartFormData) -> Void), completion: @escaping ((APIResult<T>) -> Void)) where T : Decodable {
        AF.upload(multipartFormData: formDataBuilder, with: request)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if let error = self.processStatusCode(statusCode) {
                            completion(.failure(error))
                        } else {
                            completion(.failure(APIError.unknownError(error.localizedDescription)))
                        }
                    } else {
                        completion(.failure(APIError.unknownError(error.localizedDescription)))
                    }
                }
            }
    }
    
    
    private func processStatusCode(_ statusCode: Int) -> APIError? {
        switch statusCode {
        case 400..<500:
            return .clientError("Client Error: \(statusCode)")
        case 500..<600:
            return .serverError("Server Error: \(statusCode)")
        default:
            return .unknownError("Unknown Error: \(statusCode)")
        }
    }
}

extension APIError {
    var displayMessage: String {
        switch self {
        case .clientError(let message):
            return message
        case .serverError(let message):
            return message
        case .unknownError(let message):
            return message
        case .networkError(let message):
            return message
        }
    }
}

