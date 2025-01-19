
import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        setupTabBarController()
        navigationController.viewControllers = [tabBarController]
    }
    
    private func setupTabBarController() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        let mainVC = MainScreenBuilder.createMainViewController()
        mainVC.mainView.backgroundColor = .white
        
        //Future
        let secondCoordinator = MainCoordinator(navigationController: navigationController)
        let secondVC = MainScreenBuilder.createMainViewController()
        secondVC.mainView.backgroundColor = .white
        
        let firstNavController = UINavigationController(rootViewController: mainVC)
        let secondNavController = UINavigationController(rootViewController: secondVC)
        
        //setupUI
        mainVC.tabBarItem = UITabBarItem(title: "", image: AppImages.users, tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "", image: AppImages.signUp, tag: 1)
        
        tabBarController.tabBar.tintColor = AppColors.tabBarTintColor
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = AppColors.tabBarBgColor
        
        tabBarController.viewControllers = [firstNavController, secondNavController]
    
    }
}

