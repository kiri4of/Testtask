
import UIKit

class MainViewController: BaseViewController<MainView> {
    private var viewModel: MainViewModel
    var coordinator: MainCoordinator?
    
    init(mainView: MainView, viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(mainView: mainView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.viewDidLoad()
        bindViewModel()
       
    }
    
    private func setupTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        viewModel.updateMainScreenData = { [weak self] usersUI in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
        
        viewModel.displayError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(message: error)
            } 
        }
    }
    
    private func showAlert(message: String) {
        let ac = UIAlertController(title: "Something went wrong...", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        let user = viewModel.user(at: indexPath.row)
        if let user = user {
            cell.configureCell(with: user)
        } else {
            print("User with that index doesnt exist")
        }
        return cell
    }
}
