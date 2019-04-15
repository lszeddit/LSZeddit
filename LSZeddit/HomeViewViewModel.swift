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
    
    
    func getItemURL(for indexPath: IndexPath) -> String{
        return posts[indexPath.row].data.url
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
        
        if !postData.isSelf{
            if let hint = PostHint(rawValue: postData.postHint!){
                
                switch hint {
                case PostHint.image:
                    cell.postSelfTextLabel.isHidden = true
                    cell.postImageView.isHidden = false
                    cell.postImageView.sd_setImage(with: URL(string: postData.url), placeholderImage: UIImage(named: "lszeddit_placeholder.png"))
                case PostHint.isSelf:
                    cell.postImageView.isHidden = true
                    cell.postSelfTextLabel.isHidden = false
                    cell.postSelfTextLabel.text = postData.selfText
                    break
                case PostHint.richVideo:
                    //TODO: Implement video
                    cell.postImageView.isHidden = true
                    cell.postSelfTextLabel.isHidden = true
                    break
                case PostHint.hostedVideo:
                    //TODO: Implement video
                    cell.postImageView.isHidden = true
                    cell.postSelfTextLabel.isHidden = true
                    break
                    
                default:
                    cell.postImageView.isHidden = true
                    cell.postSelfTextLabel.isHidden = true
                    break
                }
            }
        }else{
            cell.postImageView.isHidden = true
            cell.postSelfTextLabel.isHidden = false
            cell.postSelfTextLabel.text = postData.selfText
        }
        
        
        return cell
    }
    

    
    func shouldOpenInSafari(with indexPath: IndexPath) -> Bool {
        
        
        let postData = posts[indexPath.row].data
        if !postData.isSelf{
            if let hint = PostHint(rawValue: postData.postHint!){
                switch hint {
                case PostHint.image:
                    return false
                default:
                    return true
                }
            }
        }
        return true
    }
    
    func handleSelection(at indexPath: IndexPath){
        
    }
}

enum PostHint: String {
    case image = "image"
    case isSelf = "self"
    case hostedVideo = "hosted:video"
    case richVideo = "rich:video"
    case link = "link"
}
