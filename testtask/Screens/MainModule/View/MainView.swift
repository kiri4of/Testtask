import UIKit
import SnapKit

class MainView: UIView {
    
    let tableView: UITableView = {
    var table = UITableView()
        table.separatorStyle = .singleLine
        table.showsVerticalScrollIndicator = false
    return table
    }()
    
    private let headerView = CustomHeaderView(title: "Workng with GET request")
    
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
        addSubview(headerView)
        addSubview(tableView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(adapted(dimensionSize: 56, to: dimension))
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}
