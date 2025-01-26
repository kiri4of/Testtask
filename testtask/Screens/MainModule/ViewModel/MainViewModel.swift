import UIKit

final class MainViewModel {
    
    typealias ModelFromRequest = APIResult<UsersResponse>
    
    private let network: APIManagerProtocol
    private var users = [UsersUI]()
    private var positionsList = [PositionAPI]()
    private var currentPage = 1
    private let pageSize = 6
    
     var isLoading = false
    
    var updatePositions: (() -> Void)?
    var displayError: ((String) -> Void)?
    var updateMainScreenData: (() -> Void)?
    
    init(network: APIManagerProtocol) {
        self.network = network
    }
    
    // Remove data and fetch again
      func reloadUsers() {
          currentPage = 1
          users.removeAll()
          updateMainScreenData?() //for ui reload
          fetchUsers()
      }
    
    func fetchUsers() {
        guard !isLoading else { return }
        isLoading = true
        network.makeRequest(for: MainEndpoint.getUsers(page: currentPage, count: pageSize))
        { [weak self] (result: ModelFromRequest) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                let newUsers = response.users.map { UsersUI(apiModel: $0)}
                self.users.append(contentsOf: newUsers)
     
                if newUsers.count == self.pageSize {
                    self.currentPage += 1
                }
                
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
