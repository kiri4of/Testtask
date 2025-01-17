
import UIKit

class BaseViewController<View: UIView>: UIViewController {
    var mainView: View
    
    init(mainView: View){
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
}
