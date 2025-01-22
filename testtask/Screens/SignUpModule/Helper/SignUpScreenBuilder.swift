
import Foundation

class SignUpScreenBuilder {
    public static func createSignUpViewController() -> SignUpViewController{
        let view = SignUpView()
        let network = APIManager()
        let viewModel = SignUpViewModel(network: network)
        let vc = SignUpViewController(mainView: view, viewModel: viewModel)
        return vc
    }
}
