
import UIKit

struct InfoScreenModel {
    let image: UIImage
    let titleText: String
    let buttonTitle: String
}

enum InfoScreenType {
    case success
    case failure

    var image: UIImage {
        switch self {
        case .success:
            return AppImages.successImage ?? UIImage()
        case .failure:
            return AppImages.failureImage ?? UIImage()
        }
    }

    var titleText: String {
        switch self {
        case .success: return "User succesfully registered"
        case .failure: return "That email or phone is already registered"
        }
    }

    var buttonText: String {
        switch self {
        case .success: return "Got it"
        case .failure: return "Try again"
        }
    }
}

