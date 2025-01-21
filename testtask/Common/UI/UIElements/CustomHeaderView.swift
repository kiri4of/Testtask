
import SnapKit
import UIKit

class CustomHeaderView: UIView {
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.nunito20Regular
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    init(title text: String) {
        super.init(frame: .zero)
        self.mainLabel.text = text
        self.backgroundColor = .yellow
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
