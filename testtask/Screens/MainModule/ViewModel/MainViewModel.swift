import UIKit

final class MainViewModel {
    
    typealias ModelFromRequest = APIResult<UsersResponse>
    private let network: APIManagerProtocol
    private var users = [UsersUI]()
    
    var displayError: ((String) -> Void)?
    var updateMainScreenData: (([UsersUI]) -> Void)?
    
    init(network: APIManagerProtocol) {
        self.network = network
    }
    
    func viewDidLoad() {
        getUsers(page: 1, count: 5) { data in
            self.users = data
            self.updateMainScreenData?(data)
        }
    }
    
    private func getUsers(page: Int, count: Int, completion: @escaping ([UsersUI]) -> Void) {
        network.makeRequest(for: MainEndpoint.getUsers(page: page, count: count)) { [weak self] (result: ModelFromRequest) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let usersUI = response.users.map{ UsersUI(apiModel: $0) }
      
                completion(usersUI)
            case .failure(let error):
                checkAPIError(apiError: error)
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
