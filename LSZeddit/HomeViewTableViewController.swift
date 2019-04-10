import UIKit
import SafariServices

class HomeViewTableViewController: UITableViewController {
    
    @IBOutlet weak var viewModel: HomeViewViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionsCount()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Strings.postCell.rawValue, for: indexPath) as! MediaTableViewCell
       
        cell = viewModel.configureCell(at: indexPath.row, cell: cell)

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.shouldOpenInSafari(with: indexPath){
            let safariView = SFSafariViewController(url: URL(string: viewModel.getItemURL(for: indexPath))!)
            self.present(safariView, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewTableViewController: HomeViewViewModelDelegate{
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
}
