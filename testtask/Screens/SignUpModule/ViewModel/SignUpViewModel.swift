
import Foundation

class SignUpViewModel {
    //typealias for model name
    typealias SignUpResult = APIResult<SignUpResponse>
    typealias TokenResult = APIResult<TokenResponse>
    typealias PositionResult = APIResult<PositionsResponse>
    
    private let network: APIManagerProtocol
    
    var displayError: ((String) -> Void)?
    var onSignUpSucces: ((String) -> Void)?
    
    private var token: String?
    
    // Список позиций, полученный с сервера
    var positionsList: [PositionAPI] = []
    
    // Выбранный ID позиции
    var selectedPositionId: Int?
    
    // Колбэк, чтобы контроллер мог знать, что positionsList обновился
    var updatePositions: (() -> Void)?
    
    init(network: APIManagerProtocol) {
        self.network = network
    }
    
    func signUpUser(name: String,
                    email: String,
                    phone: String,
                    photoData: Data,
                    completion: (() -> Void)? = nil) {
        guard let token = token else {
            displayError?("No token found. Fetch the token first")
            return
        }
        
        guard let positionId = selectedPositionId else {
            displayError?("No position selected!")
            return
        }
        //converting position Id
        // let positionId = positionIdFromEnum(position)
        
        let endPoint = SignUpEndpoint.createUser(token: token)
        
        network.uploadMultipart(for: endPoint) { formData in
            formData.append(name.data(using: .utf8) ?? Data(), withName: "name")
            formData.append(email.data(using: .utf8) ?? Data(), withName: "email")
            formData.append(phone.data(using: .utf8) ?? Data(), withName: "phone")
            formData.append("\(positionId)".data(using: .utf8) ?? Data(), withName: "position_id")
            
            formData.append(photoData,
                            withName: "photo",
                            fileName: "photo.jpg",
                            mimeType: "image/jpeg")
        } completion: { [weak self] (result: SignUpResult) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if response.success {
                    //here can be user that already exists
                    self.onSignUpSucces?(response.message)
                    completion?()
                    //if it used once => make it nil
                    self.token = nil
                } else {
                    self.displayError?(response.message)
                    //the token has already been spent => make it nil
                    self.token = nil
                }
            case .failure(let error):
                self.displayError?(error.displayMessage)
                //in any case of error => make it nil
                self.token = nil
            }
        }
        
    }
    
    func fetchToken(completion: @escaping () -> Void) {
        network.makeRequest(for: TokenEndpoint.getToken) { [weak self] (result: TokenResult) in
            guard let self = self else {return}
            switch result {
            case .success(let tokenResponse):
                if tokenResponse.success {
                    self.token = tokenResponse.token
                    completion()
                } else {
                    self.displayError?("Token request failed")
                }
            case .failure(let error):
                self.displayError?(error.localizedDescription)
            }
        }
    }
    
    func fetchPositions() {
        network.makeRequest(for: PositionsEndpoint.getPositions) { (result: PositionResult) in
            switch result {
            case .success(let response):
                let positions = response.positions
                self.positionsList = positions
                self.updatePositions?()
            case .failure(let error):
                self.displayError?(error.displayMessage)
            }
        }
    }
    
    //Return tuple(String?,String?,String?) where you have String or nil
    func validate(name: String?, email: String?, phone: String?) -> (String?, String?, String?) {
        let nameError: String?
        if let name = name, !name.isEmpty {
            nameError = nil
        } else {
            nameError = "Required field"
        }
        
        let emailError: String?
        if let email = email, isValidEmail(email) {
            emailError = nil
        } else {
            emailError = "Invalid email format"
        }
        
        let phoneError: String?
        if let phone = phone, isPhoneNumberValid(phone) {
            phoneError = nil
        } else {
            phoneError = "Required Field"
        }
        
        return (nameError, emailError, phoneError)
    }
    
    //Is email valid via NSPredicate
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    //Is numeber valid via NSPredicate
    private func isPhoneNumberValid(_ phone: String) -> Bool {
        let phoneRegex = "^\\+380\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phone)
    }
    
}
