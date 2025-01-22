
import UIKit
import SnapKit

class TextFieldWithErrorView: UIView {
       private let textField: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.font = AppFonts.nunito16Regular
            return textField
        }()
        
       private let errorLabel: UILabel = {
            let label = UILabel()
            label.text = "Error"
            label.textColor = .red
            label.font = AppFonts.nunito12Regular
            label.isHidden = false
            return label
        }()
    
    init(placeholder: String, errorMessage: String, keyBoardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.textField.placeholder = placeholder
        self.textField.keyboardType = keyBoardType
        self.errorLabel.text = errorMessage
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(textField)
        addSubview(errorLabel)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(adapted(dimensionSize: 56, to: dimension))
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.leading.equalTo(textField.snp.leading).offset(16)
            make.trailing.equalTo(textField)
            make.bottom.equalToSuperview()
        }
    }
}

