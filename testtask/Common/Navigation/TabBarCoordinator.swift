
import UIKit

class TabBarCoordinator {
    var tabBarController = UITabBarController()
    
    func start() {
        let mainVC = MainScreenBuilder.createMainViewController()
        let signUpVC = SignUpScreenBuilder.createSignUpViewController()
        
        //icons
        mainVC.tabBarItem = UITabBarItem(title: "", image: AppImages.users, tag: 0)
        signUpVC.tabBarItem = UITabBarItem(title: "", image: AppImages.signUp, tag: 1)
        
        tabBarController.viewControllers = [mainVC,signUpVC]
        
        //custom
        tabBarController.tabBar.tintColor = AppColors.tabBarTintColor
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = AppColors.tabBarBgColor
    }
    
}


