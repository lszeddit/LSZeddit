import Foundation
import SDWebImage

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
    
    func getCommentCount(for postData: PostData) -> String{
        let count = postData.commentCount
        if count < 1 || count > 1 {
            return "\(count) comments"
        }
        return "1 comment"
    }
    
    func getUpvoteCount(for postData: PostData) -> String {
        return "\(postData.score)"
    }
    
    func configureCell(at index: Int, cell: MediaTableViewCell) -> MediaTableViewCell {
        let postData = posts[index].data
        cell.postTitleLabel.text = postData.title
        cell.postAuthorLabel.text = postData.author
        cell.postTimeLabel.text = Date.getAge(of: postData.created)
        cell.postCommentCountLabel.text = getCommentCount(for: postData)
        cell.postUpvoteCountLabel.text = getUpvoteCount(for: postData)
        if let thumbnailString = postData.thumbnail{
            print(thumbnailString)
            //do something with thumbnail
            cell.postImageView.sd_setImage(with: URL(string: postData.url), placeholderImage: UIImage(named: "lszeddit_placeholder.png"))
        }
        return cell
    }
}

