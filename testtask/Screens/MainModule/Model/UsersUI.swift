
import Foundation

//UI Model 
struct UsersUI {
    let name: String
    let email: String
    let phone: String
    let position: String
    let photo: String
    
    init(apiModel: UserAPI) {
        self.name = apiModel.name
        self.email = apiModel.email
        self.phone = apiModel.phone
        self.position = apiModel.position
        self.photo = apiModel.photo
    }
}

