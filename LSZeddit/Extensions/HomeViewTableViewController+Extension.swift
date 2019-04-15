import Foundation

extension HomeViewTableViewController: HomeViewViewModelDelegate{
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
