
import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let identifier = "MainTableViewCell"

    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = AppFonts.nunito18Regular
        label.textColor = .black
        return label
    }()
    
    private let positionLabel: UILabel = {
       let label = UILabel()
        label.font = AppFonts.nunito14Regular
        label.textColor = .black.withAlphaComponent(0.6)
        return label
    }()
    
    private let emailLabel: UILabel = {
       let label = UILabel()
        label.font = AppFonts.nunito14Regular
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
       let label = UILabel()
        label.font = AppFonts.nunito14Regular
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: UsersUI) {
        avatarImageView.loadImage(from: model.photo)
        nameLabel.text = model.name
        positionLabel.text = model.position
        emailLabel.text = model.email
        phoneNumberLabel.text = model.phone
    }
    
    private func setupCell() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(positionLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneNumberLabel)
        
        avatarImageView.snp.makeConstraints { make in
                  make.size.equalTo(adapted(dimensionSize: 50, to: dimension))
                  make.top.equalToSuperview().offset(8)
                  make.leading.equalToSuperview().offset(16)
              }
              
              nameLabel.snp.makeConstraints { make in
                  make.top.equalToSuperview().offset(8)
                  make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
                  make.trailing.equalToSuperview().offset(-16)
              }
              
              positionLabel.snp.makeConstraints { make in
                  make.top.equalTo(nameLabel.snp.bottom).offset(4)
                  make.leading.equalTo(nameLabel)
                  make.trailing.equalToSuperview().offset(-16)
              }
              
              emailLabel.snp.makeConstraints { make in
                  make.top.equalTo(positionLabel.snp.bottom).offset(4)
                  make.leading.equalTo(nameLabel)
                  make.trailing.equalToSuperview().offset(-16)
              }
              
              phoneNumberLabel.snp.makeConstraints { make in
                  make.top.equalTo(emailLabel.snp.bottom).offset(4)
                  make.leading.equalTo(nameLabel)
                  make.trailing.equalToSuperview().offset(-16)
                  make.bottom.equalToSuperview().offset(-8)
              }
    }
}

