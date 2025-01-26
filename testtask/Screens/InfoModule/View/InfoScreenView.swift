
import UIKit

class InfoScreenView: UIView {
    private var closeButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: AppImages.noInternetImage)
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let label: UILabel = {
       let label = UILabel()
        label.text = "No Internet Connection"
        label.textAlignment = .center
        label.font = AppFonts.nunito18Regular
        return label
    }()
    
    private let button = CustomButton(title: "", bgColor: AppColors.buttonBgColor, font: AppFonts.nunito14Regular)
    
    var onButtonTap: (() -> Void)?
    
    init(frame: CGRect, model: InfoScreenModel) {
        super.init(frame: frame)
        setupView(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(model: InfoScreenModel) {
        backgroundColor = .white
        addSubview(closeButton)
        addSubview(imageView)
        addSubview(label)
        addSubview(button)
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = model.image
        
        label.text = model.titleText
        
        button.setTitle(model.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        closeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().offset(-25)
            make.height.width.equalTo(adapted(dimensionSize: 25, to: dimension))
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(adapted(dimensionSize: 150, to: dimension))
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(adapted(dimensionSize: 30, to: dimension))
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(adapted(dimensionSize: 140, to: dimension))
            make.height.equalTo(adapted(dimensionSize: 48, to: dimension))
        }
    }
}

extension InfoScreenView {
    @objc private func buttonTapped() {
        onButtonTap?()
    }
}
