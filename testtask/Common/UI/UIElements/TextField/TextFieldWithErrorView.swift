
import UIKit
import SnapKit

class TextFieldWithErrorView: UIView {
        let textField: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.font = AppFonts.nunito16Regular
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.cgColor
            return textField
        }()
        
        let errorLabel: UILabel = {
            let label = UILabel()
            label.font = AppFonts.nunito12Regular
            label.textColor = .red
            label.isHidden = true
            return label
        }()
    
    var onTextChanged: ((String?) -> Void)?
    
    init(placeholder: String, errorMessage: String, keyBoardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.textField.placeholder = placeholder
        self.textField.keyboardType = keyBoardType
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showErrorMessage(_ message: String?) {
           if let message = message {
               errorLabel.text = message
               errorLabel.textColor = .red
               errorLabel.isHidden = false
               
               textField.layer.borderColor = UIColor.red.cgColor
               textField.layer.borderWidth = 1.0
           } else {
               errorLabel.text = nil
               errorLabel.isHidden = true
               textField.layer.borderColor = UIColor.lightGray.cgColor
               textField.layer.borderWidth = 1.0
           }
       }
}

extension TextFieldWithErrorView {
    private func setupView() {
        addSubview(textField)
        addSubview(errorLabel)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        setupConstraints()
        setupActions()
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
    
    private func setupActions() {
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc private func editingDidBegin() {
        textField.layer.borderColor = AppColors.tabBarTintColor.cgColor
    }
    
    @objc private func editingDidEnd() {
        if let text = errorLabel.text, !errorLabel.isHidden, errorLabel.text != "+38 (XXX) XXX - XX - XX", !text.isEmpty {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @objc private func textChanged(){
        onTextChanged?(textField.text)
    }
    
    
}

