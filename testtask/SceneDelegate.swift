import UIKit
import Network

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    // Ссылки на контроллеры
    private var tabBarCoordinator: TabBarCoordinator?
    private var noInternetVC: NoInternetViewController?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        
        // Ставим splash
        let splashVC = UIViewController()
        splashVC.view.backgroundColor = .white
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()

        // Настраиваем монитор
        monitor.start(queue: queue)

        // after 0.2 decide what to show 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            let status = self.monitor.currentPath.status
            if status == .satisfied {
                self.setMainAsRoot()
            } else {
                self.setNoInternetAsRoot()
            }
        }

        // И продолжаем слушать изменения сети на будущее
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.updateRootController(for: path)
            }
        }
    }


    private func updateRootController(for path: NWPath) {
        if path.status == .satisfied {
            // Если есть интернет, устанавливаем основной экран
            setMainAsRoot()
        } else {
            // Если нет интернета, показываем экран без сети
            setNoInternetAsRoot()
        }
    }

    private func setMainAsRoot() {
        if tabBarCoordinator == nil {
            tabBarCoordinator = TabBarCoordinator()
            tabBarCoordinator?.start()
        }
        window?.rootViewController = tabBarCoordinator?.tabBarController
    }

    private func setNoInternetAsRoot() {
        if noInternetVC == nil {
            noInternetVC = NoInternetScreenBuilder.createNoInternetViewController()
            noInternetVC?.mainView.onTryAgain = { [weak self] in
                self?.retryNetworkCheck()
            }
        }
        window?.rootViewController = noInternetVC
    }
    
    private func retryNetworkCheck() {
        if monitor.currentPath.status == .satisfied {
            setMainAsRoot()
        } else {
            // Можно показать Alert или другую индикацию
            let alert = UIAlertController(title: "Still No Connection", message: "Please check your internet settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            noInternetVC?.present(alert, animated: true)
        }
    }

    // Остальные методы SceneDelegate остаются без изменений
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
