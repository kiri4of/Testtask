
import UIKit

class CustomButton: UIButton {
    private var title: String
    private var bgColor: UIColor
    private var font: UIFont
    
    init(title: String, bgColor: UIColor = AppColors.buttonBgColor, font: UIFont) {
        self.title = title
        self.bgColor = bgColor
        self.font = font
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.font = font
        let cornerRadius = self.frame.height / 2
        layer.cornerRadius = cornerRadius 
    }
    
    func setupButton(){
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        setTitleColor(.black, for: .normal)
        layer.shadowColor = bgColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
    }
}
