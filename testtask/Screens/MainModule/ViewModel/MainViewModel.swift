import UIKit

final class MainViewModel {
    
    typealias ModelFromRequest = APIResult<UsersResponse>
    private let network: APIManagerProtocol
    private var users = [UsersUI]()
    
    var displayError: ((String) -> Void)?
    var updateMainScreenData: (() -> Void)?
    
    init(network: APIManagerProtocol) {
        self.network = network
    }
    
    func fetchUsers() {
           network.makeRequest(for: MainEndpoint.getUsers(page: 1, count: 10))
        { [weak self] (result: ModelFromRequest) in
               guard let self = self else { return }
               
               switch result {
               case .success(let response):
                   self.users = response.users.map { UsersUI(apiModel: $0) }
                   self.updateMainScreenData?()
               case .failure(let error):
                   self.checkAPIError(apiError: error)
               }
           }
       }
    
    private func checkAPIError(apiError: APIError) {
         displayError?(apiError.displayMessage)
     }
}

//Methods for tableView
extension MainViewModel {
    func numberOfUsers() -> Int {
        return users.count
    }
    
    //for single user
    func user(at index: Int) -> UsersUI? {
        guard index >= 0 && index < users.count else { return nil }
        return users[index]
    }
}
