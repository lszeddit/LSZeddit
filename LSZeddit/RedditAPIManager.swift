//
//  RedditAPIManager.swift
//  LSZeddit
//
//  Created by Carlos Acosta on 4/9/19.
//  Copyright © 2019 LSZTech. All rights reserved.
//

import Foundation


class RedditAPIManager {
    
    let baseURL = "https:reddit.com/top.json"
    
    static let shared = RedditAPIManager()
    static let getNewEndpoint = "?sort=new"
    
    
    
    func getTopPosts(onComplete: @escaping(Any?) -> Void){
        let stringURL : String = baseURL
        
        
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
struct RedditResponse: Codable{
    var kind: String
    var data: RedditResponseData
}

struct RedditResponseData: Codable{
    var children: [Post]
}

struct Post: Codable{
    var data: PostData
}

struct PostData: Codable{
    var subreddit: String
    var title: String
    var thumbnail: String?
    var author: String
    var created: Double
    var commentCount: Int
    var score: Int
    var url: String
    
    private enum CodingKeys: String, CodingKey{
        case title
        case subreddit
        case thumbnail
        case author = "author_fullname"
        case created
        case commentCount = "num_comments"
        case score
        case url
    }
}
