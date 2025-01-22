
import Foundation

enum Position: String {
    case frontend = "Frontend developer"
    case backend = "Backend developer"
    case designer = "Designer"
    case qa = "QA"
}

class SignUpViewModel {
    private let network: APIManagerProtocol
    
    private(set) var selectedPosition: Position? {
          didSet {
              print("Selected position updated to: \(selectedPosition?.rawValue ?? "None")")
          }
      }
    
    init(network: APIManagerProtocol) {
        self.network = network
    }
    
}
