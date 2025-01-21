
import UIKit

class TabBarCoordinator {
    var tabBarController = UITabBarController()
    
    func start() {
        let mainVC = MainScreenBuilder.createMainViewController()
        mainVC.mainView.backgroundColor = .white
        let secondVC = MainScreenBuilder.createMainViewController()
        
        //icons
        mainVC.tabBarItem = UITabBarItem(title: "", image: AppImages.users, tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "", image: AppImages.signUp, tag: 1)
        
        tabBarController.viewControllers = [mainVC,secondVC]
        
        //custom
        tabBarController.tabBar.tintColor = AppColors.tabBarTintColor
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = AppColors.tabBarBgColor
        
        
    }
    
    private func setupTabBarController() {
        let mainVC = MainScreenBuilder.createMainViewController()
        mainVC.mainView.backgroundColor = .white
        
        //Future
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

