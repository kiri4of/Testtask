import UIKit

class MainScreenBuilder {
    public static func createMainViewController() -> MainViewController{
        let view = MainView()
        let viewModel = MainViewModel()
        let vc = MainViewController(mainView: view)
        return vc
    }
}
