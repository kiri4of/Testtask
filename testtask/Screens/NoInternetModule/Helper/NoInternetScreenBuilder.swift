
import Foundation

class NoInternetScreenBuilder {
    public static func createNoInternetViewController() -> NoInternetViewController{
        let view = NoInternetView()
        let vc = NoInternetViewController(mainView: view)
        return vc
    }
}
