import UIKit
import SnapKit

class MainView: UIView {
    let tableView: UITableView = {
    var table = UITableView()
        table.separatorStyle = .singleLine
        table.showsVerticalScrollIndicator = false
    return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainView {
    private func setupView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
