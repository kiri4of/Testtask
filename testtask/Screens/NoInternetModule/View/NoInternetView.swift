
import UIKit

class NoInternetView: UIView {
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
    
    private let tryAgainButton = CustomButton(title: "Try Again", bgColor: AppColors.buttonBgColor, font: AppFonts.nunito14Regular)
    
    var onTryAgain: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(label)
        addSubview(tryAgainButton)
        
        tryAgainButton.addTarget(self, action: #selector(didTapTryAgain), for: .touchUpInside)
        
        imageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(adapted(dimensionSize: 150, to: dimension))
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(adapted(dimensionSize: 30, to: dimension))
        }
        
        tryAgainButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(adapted(dimensionSize: 140, to: dimension))
        }
    }
}

extension NoInternetView {
    @objc private func didTapTryAgain() {
        onTryAgain?()
    }
}
