
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = MainScreenBuilder.createMainViewController()
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: true)
    }
}

