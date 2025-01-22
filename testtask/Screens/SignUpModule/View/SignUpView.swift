import UIKit
import SnapKit

class SignUpView: UIView {
    
    private let headerView = CustomHeaderView(title: "Working with POST request")
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentView = UIView()
    
    //MARK: - Custom Text Fields
    private let nameFieldWithError = TextFieldWithErrorView(placeholder: "Your Name", errorMessage: "Required field",keyBoardType: .default)
    private let emailFieldWithError = TextFieldWithErrorView(placeholder: "Email", errorMessage: "Invalid email format", keyBoardType: .emailAddress)
    private let phoneFieldWithError = TextFieldWithErrorView(placeholder: "Phone", errorMessage: "Required field", keyBoardType: .phonePad)
    
    private let positonLabel: UILabel = {
        let label = UILabel()
        label.text = "Select your position"
        label.font = AppFonts.nunito18Regular
        label.textColor = .black
        return label
    }()
    
    private let positionVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        return stackView
    }()
    
    private let textFieldsVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
    }()
    
    //MARK: - Buttons
    let frontendButton = RadioButton(title: "Frontend developer")
    let backendButton = RadioButton(title: "Backend developer")
    let designerButton = RadioButton(title: "Designer")
    let qaButton = RadioButton(title: "QA")
    
    let signUpButton = CustomButton(title: "Sign up", bgColor: AppColors.buttonBgColor, font: AppFonts.nunito18SemiBold)
    
    private let uploadButton = CustomUploadButton(placeholder: "Upload your photo", errorMessage: "Photo is required")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(headerView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(textFieldsVerticalStackView)
        contentView.addSubview(positonLabel)
        contentView.addSubview(positionVerticalStackView)
        contentView.addSubview(uploadButton)
        contentView.addSubview(signUpButton)
        
        textFieldsVerticalStackView.addArrangedSubview(nameFieldWithError)
        textFieldsVerticalStackView.addArrangedSubview(emailFieldWithError)
        textFieldsVerticalStackView.addArrangedSubview(phoneFieldWithError)
        
        positionVerticalStackView.addArrangedSubview(frontendButton)
        positionVerticalStackView.addArrangedSubview(backendButton)
        positionVerticalStackView.addArrangedSubview(designerButton)
        positionVerticalStackView.addArrangedSubview(qaButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(adapted(dimensionSize: 56, to: dimension))
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        textFieldsVerticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        positonLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldsVerticalStackView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(adapted(dimensionSize: 25, to: dimension))
        }
        
        positionVerticalStackView.snp.makeConstraints { make in
            make.top.equalTo(positonLabel.snp.bottom).offset(20)
            make.leading.equalTo(positonLabel.snp.leading).offset(10)
            make.trailing.equalToSuperview()
        }
        
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(positionVerticalStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(adapted(dimensionSize: 56, to: dimension))
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(uploadButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(adapted(dimensionSize: 140, to: dimension))
            make.height.equalTo(adapted(dimensionSize: 48, to: dimension))
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension SignUpView {
     private func setupGesture() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
         self.addGestureRecognizer(tapGesture)
     }
     
     @objc private func hideKeyboard() {
         self.endEditing(true)
     }
}
