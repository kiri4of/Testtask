
import Foundation

enum Position: String {
    case frontend = "Frontend developer"
    case backend = "Backend developer"
    case designer = "Designer"
    case qa = "QA"
}

class SignUpViewModel {
    private let network: APIManagerProtocol
    
    var selectedPosition: Position? {
          didSet {
              print("Selected position updated to: \(selectedPosition?.rawValue ?? "None")")
          }
      }
    
    init(network: APIManagerProtocol) {
        self.network = network
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
