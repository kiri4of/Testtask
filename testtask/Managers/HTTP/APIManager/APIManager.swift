
import Foundation

protocol APIManagerProtocol {
    func makeRequest<T: Decodable>(
        for endPoint: Endpoint,
        completion: @escaping (APIResult<T>) -> Void)
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
}

