
import UIKit

class SignUpViewController: BaseViewController<SignUpView> {
    private var viewModel: SignUpViewModel
    
    init(mainView: SignUpView, viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(mainView: mainView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [mainView.frontendButton,mainView.backendButton,mainView.designerButton,mainView.qaButton].forEach { button in
            button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc private func radioButtonTapped(_ sender: RadioButton) {
        mainView.frontendButton.isSelected = (sender == mainView.frontendButton)
        mainView.backendButton.isSelected = (sender == mainView.backendButton)
        mainView.designerButton.isSelected = (sender == mainView.designerButton)
        mainView.qaButton.isSelected = (sender == mainView.qaButton)
    }
}
