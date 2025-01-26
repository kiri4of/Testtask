import UIKit

class InfoScreenViewController: BaseViewController<InfoScreenView> {
    
    private let screenType: InfoScreenType

    init(screenType: InfoScreenType) {
        self.screenType = screenType
        let model = InfoScreenModel(
            image: screenType.image,
            titleText: screenType.titleText,
            buttonTitle: screenType.buttonText
        )
        let infoView = InfoScreenView(frame: .zero, model: model)
        super.init(mainView: infoView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.onButtonTap = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
}
