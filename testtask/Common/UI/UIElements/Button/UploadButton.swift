
import UIKit
import SnapKit

class UploadButton: UIView {
    
    var currentFileName: String? {
        return textField.text
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = AppFonts.nunito16Regular
        return textField
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(AppColors.tabBarTintColor, for: .normal)
        button.titleLabel?.font = AppFonts.nunito16Regular
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo is required"
        label.textColor = .red
        label.font = AppFonts.nunito12Regular
        label.isHidden = true
        return label
    }()
    
    var onUploadTap: (() -> Void)?
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.textField.placeholder = placeholder
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
    
    func setImageName(_ fileName: String?) {
        textField.text = fileName
    }
    
}

extension UploadButton {
    
    private func setupView() {
       
        addSubview(textField)
        addSubview(errorLabel)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
      
        textField.rightView = uploadButton
        textField.rightViewMode = .always
        
        textField.delegate = self
        
        uploadButton.addTarget(self, action: #selector(didTapUploadButton), for: .touchUpInside)
        
        setupConstraints()
    }

    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(adapted(dimensionSize: 56, to: dimension))
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.leading.equalTo(textField.snp.leading).offset(8)
            make.trailing.equalTo(textField)
        }
    }
    
    @objc private func didTapUploadButton() {
        onUploadTap?()
    }
}




extension UploadButton: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
