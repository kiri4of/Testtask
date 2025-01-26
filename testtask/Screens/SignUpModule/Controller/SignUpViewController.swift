
import UIKit

class SignUpViewController: BaseViewController<SignUpView> {
    private var viewModel: SignUpViewModel
    //save user image
    private var userSelectedImage: UIImage?
    private var radioButtons: [RadioButton] = []
    
    init(mainView: SignUpView, viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(mainView: mainView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetchPositions()
    }
    
    //MARK: ImagePicker Setup
    private func showImagePickerOptions() {
        let alert = UIAlertController(title: "Upload photo", message: "Please choose", preferredStyle: .actionSheet)
        
        //Camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.presentImagePicker(souceType: .camera)
            })
        }
        
        //Photo from gallery
        alert.addAction(UIAlertAction(title: "Photo library", style: .default) { [weak self] _ in
            self?.presentImagePicker(souceType: .photoLibrary)
        })
        
        //Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
        
    }
    
    private func presentImagePicker(souceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = souceType
        present(imagePicker, animated: true)
    }
    //MARK: Buttons Setup when Tapped
    
    private func bind() {
        viewModel.updatePositions = { [weak self] in
                   self?.setupRadioButtons()
        }
        
        mainView.signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
        mainView.uploadButton.onUploadTap = { [weak self] in
            self?.showImagePickerOptions()
        }
        
        //When success
        viewModel.onSignUpSucces = { [weak self] message in
            
                let vc = InfoScreenViewController(screenType: .success)
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: true)
            
        }
        //When failure
        viewModel.displayError = { [weak self] message in
                let vc = InfoScreenViewController(screenType: .failure)
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: true)
            
        }
        
        //binding text changing events
        mainView.nameFieldWithError.onTextChanged = { [weak self] _ in
            self?.updateSignUpButtonState()
        }
        
        mainView.emailFieldWithError.onTextChanged = { [weak self] _ in
            self?.updateSignUpButtonState()
        }
        
        mainView.phoneFieldWithError.onTextChanged = { [weak self] _ in
            self?.updateSignUpButtonState()
        }
        
        //signUp button not active for start(if fields is empty)
        updateSignUpButtonState()
    }
    
    private func updateSignUpButtonState() {
        let nameText = mainView.nameFieldWithError.textField.text ?? ""
        let emailText = mainView.emailFieldWithError.textField.text ?? ""
        let phoneText = mainView.phoneFieldWithError.textField.text ?? ""
        
        let isNameFilled = !nameText.isEmpty
        let isEmailFilled = !emailText.isEmpty
        let isPhoneFilled = !phoneText.isEmpty
        
        let uploadFileName = mainView.uploadButtonFileName
        let isPhotoUploaded = !(uploadFileName?.isEmpty ?? true)
        
        let allFilled = isNameFilled && isEmailFilled && isPhoneFilled && isPhotoUploaded
        
        mainView.signUpButton.isEnabled = allFilled
        mainView.signUpButton.alpha = allFilled ? 1.0 : 0.5
    }
    
    
    private func setupRadioButtons() {
           // delete all subviews
           mainView.positionVerticalStackView.arrangedSubviews.forEach {
               $0.removeFromSuperview()
           }
           radioButtons.removeAll()
           
           // list of positions from viewModel
           let positions = viewModel.positionsList
           
           for position in positions {
               let button = RadioButton(title: position.name)
               // save id in button.tag
               button.tag = position.id
               button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
               
               radioButtons.append(button)
               mainView.positionVerticalStackView.addArrangedSubview(button)
           }
        //first pos selected by default
            if !radioButtons.isEmpty {
                radioButtons[0].isSelected = true
                viewModel.selectedPositionId = radioButtons[0].tag
            }
       }
    
    
    @objc private func radioButtonTapped(_ sender: RadioButton) {
         //unselect everyone
         radioButtons.forEach { $0.isSelected = false }
         //Mark selected only just chosen button
         sender.isSelected = true
         //save to VM chosen tag
         viewModel.selectedPositionId = sender.tag
     }
    
    @objc private func didTapSignUpButton() {
        let nameText = mainView.nameFieldWithError.textField.text
        let emailText = mainView.emailFieldWithError.textField.text
        let phoneText = mainView.phoneFieldWithError.textField.text
        
        let (nameError, emailError, phoneError) = viewModel.validate(
            name: nameText,
            email: emailText,
            phone: phoneText
        )
        // hide/unhide labels with error
        mainView.nameFieldWithError.showErrorMessage(nameError)
        mainView.emailFieldWithError.showErrorMessage(emailError)
        mainView.phoneFieldWithError.showErrorMessage(phoneError)
        
        let photoName = mainView.uploadButton.textField.text
        if (photoName?.isEmpty ?? true) { //true = if found nil
            mainView.uploadButton.showErrorMessage("Photo is required")
        } else {
            mainView.uploadButton.showErrorMessage(nil)
        }
        
        //first token
        viewModel.fetchToken { [weak self] in
            guard let self = self else { return }
            if nameError == nil, emailError == nil, phoneError == nil, !(photoName?.isEmpty ?? true) {
                guard let userSelectedImage = userSelectedImage else {
                    print("No image return")
                    return
                }
                
                guard let photoData = userSelectedImage.jpegData(compressionQuality: 0.8) else {
                    print("Could not convert UIImage to Data")
                    return
                }
                //then request
                viewModel.signUpUser(
                    name: nameText ?? "",
                    email: emailText ?? "",
                    phone: phoneText ?? "",
                    photoData: photoData)
            }
        }
    }
}

//MARK: ImagePickerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            userSelectedImage = pickedImage
            let fileName = "photo.jpg"
            //settig name for TextField inside uploadButton
            mainView.uploadButton.setImageName(fileName)
            //hide the errorLabel
            mainView.uploadButton.showErrorMessage(nil)
            updateSignUpButtonState()// if we got an image, update signUp button
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

