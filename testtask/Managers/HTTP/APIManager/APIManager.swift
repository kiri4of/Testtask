
import Foundation
import Alamofire

protocol APIManagerProtocol {
    //get
    func makeRequest<T: Decodable>(
        for endPoint: Endpoint,
        completion: @escaping (APIResult<T>) -> Void)
    
    //post
    func uploadMultipart<T: Decodable> (
        for endPoint: Endpoint,
        formDataBuilder: @escaping (MultipartFormData) -> Void,
        completion: @escaping (APIResult<T>) -> Void
    )
}

final class APIManager: APIManagerProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func makeRequest<T>(for endPoint: Endpoint, completion: @escaping (APIResult<T>) -> Void) where T : Decodable {
        //request from Endpoint
        guard let request = endPoint.urlRequest else {
            completion(.failure(.networkError(message: "Failed to create URLRequest")))
            return
        }
        //make request via networkManager
        networkManager.sendRequest(request: request, completion: completion)
    }
    
    func uploadMultipart<T>(for endPoint: Endpoint, formDataBuilder: @escaping (Alamofire.MultipartFormData) -> Void, completion: @escaping (APIResult<T>) -> Void) where T : Decodable {
        guard let request = endPoint.urlRequest else {
            completion(.failure(.networkError(message: "Failed to create URLRequest")))
            return
        }
        networkManager.uploadMultipart(request: request, formDataBuilder: formDataBuilder, completion: completion)
    }
    
}

