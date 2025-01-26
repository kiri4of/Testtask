
import UIKit

class MainViewController: BaseViewController<MainView> {
    private var viewModel: MainViewModel
    
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
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.reloadUsers()
    }
    
    private func setupTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        viewModel.updateMainScreenData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {

                if self.viewModel.isLoading {
                    return
                }
                
                if self.viewModel.numberOfUsers() > 0 {
                    self.mainView.tableView.backgroundView = nil
                    self.mainView.tableView.backgroundColor = .white
                } else {
                    let imageView = UIImageView(image: UIImage(named: "noNetworkBgImage"))
                    imageView.contentMode = .scaleAspectFit
                    self.mainView.tableView.backgroundView = imageView
                }
                UIView.performWithoutAnimation {
                    self.mainView.tableView.reloadData()
                }
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

//MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalCount = viewModel.numberOfUsers()
        if indexPath.row == totalCount - 1 {
            viewModel.fetchUsers()
        }
    }
    
}
