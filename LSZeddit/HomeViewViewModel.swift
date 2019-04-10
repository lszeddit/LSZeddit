import Foundation

class HomeViewViewModel: NSObject{
    
    fileprivate var posts = [Post]()
    
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
}
