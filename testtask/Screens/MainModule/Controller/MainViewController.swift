
import UIKit

class MainViewController: BaseViewController<MainView> {
    
    var coordinator: MainCoordinator?
    
    override init(mainView: MainView) {
        super.init(mainView: mainView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

