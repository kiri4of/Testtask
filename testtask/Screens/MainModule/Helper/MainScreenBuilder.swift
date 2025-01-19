import UIKit

class MainScreenBuilder {
    public static func createMainViewController() -> MainViewController{
        let view = MainView()
        let network = APIManager()
        let viewModel = MainViewModel(network: network)
        let vc = MainViewController(mainView: view, viewModel: viewModel)
        return vc
    }
}
