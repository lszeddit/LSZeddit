import Foundation

protocol HomeViewViewModelDelegate {
    func updateViews()
}

class HomeViewViewModel: NSObject{
    
    fileprivate var posts = [Post]()
    var delegate: HomeViewViewModelDelegate?
    
    override init() {
        super.init()
        self.refreshPosts()
    }
    
    fileprivate func refreshPosts(){
        RedditAPIManager.shared.getTopPosts { (response) in
            guard let response = response as? RedditResponse else {
                //showError
                return
            }
            print("RESPONSE FROM API MANAGER COMPLETION")
            print(response.data.children.count)
            
            self.posts = response.data.children
            self.delegate?.updateViews()
        }
    }
    
    func getPosts() -> [Post]{
        if posts.isEmpty{
            refreshPosts()
            return self.posts
        } else {
            return self.posts
        }
    }
    
    func getItemCount() -> Int{
        if posts.isEmpty{
            refreshPosts()
            return self.posts.count
        }
        return posts.count
    }
    
    func getSectionsCount() -> Int {
        return 1
    }
    
    func configureCell(at index: Int, cell: MediaTableViewCell) -> MediaTableViewCell {
        let postData = posts[index].data
        cell.postTitleLabel.text = postData.title
        cell.postAuthorLabel.text = postData.author
        if let thumbnailString = postData.thumbnail{
            print("HAS a thumbnail")
            //do something with thumbnail
        }
        return cell
    }
}

