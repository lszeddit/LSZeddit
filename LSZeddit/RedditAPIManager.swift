import Foundation

class RedditAPIManager {
    
    static let baseURL = "https:reddit.com/top.json"
    static let shared = RedditAPIManager()
    static let getNewEndpoint = "?sort=new"
    
    func getTopPosts(onComplete: @escaping(Any?) -> Void){
        guard let url = URL(string: "https://www.reddit.com/top.json?limit=50") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                let redditResponse = try? JSONDecoder().decode(RedditResponse.self, from: data)
                
                guard let successResponse = redditResponse else {
                    onComplete(nil)
                    return
                }
                onComplete(successResponse)
            }
            
        }.resume()
    }
}




