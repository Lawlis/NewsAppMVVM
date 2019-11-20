//
//  APIManager.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let kBaseServerURL: String = "https://newsapi.org/v2/"
let kNewsSourcesPath: String = "sources"
let kTopHeadlinesPath: String = "top-headlines?"
let kEverythingPath: String = "everything?"
let apiKeyString: String = "apiKey=419ab7ddbe46477eae199db1d1ed3135"

let defaultCountry: String = "country=us"
let defaultCategory: String = "category=business"

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let fullSourcesString = "\(kBaseServerURL)\(kNewsSourcesPath)?\(apiKeyString)"
    
    let fullArticlesString = "\(kBaseServerURL)\(kTopHeadlinesPath)&\(defaultCountry)&\(defaultCategory)&\(apiKeyString)"
    
    let selectedSourcesString = "\(kBaseServerURL)\(kTopHeadlinesPath)\(kNewsSourcesPath)"
    
    func getNewsData(completion: @escaping ([Article]) -> ()) {
        AF.request(fullArticlesString, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    print("Success! Got all the articles")
                    let responseJSON : JSON = JSON(response.value!)
                    completion(self.updateNewsData(newsJSON: responseJSON))
                case .failure(_):
                    print("Error \(String(describing: response.error))")
                }
        }
    }
    
    func getSourceData(completion: @escaping ([Sources]) -> ()) {
        AF.request(fullSourcesString, method: .get)
            .responseJSON
            { response in
                switch response.result {
                case .success:
                    print("Success! Got all the sources")
                    let responseJSON : JSON = JSON(response.value!)
                    completion(self.updateSourceData(sourceJSON: responseJSON))
                case .failure:
                    print("Error \(String(describing: response.error))")
                }
        }
    }
    
    func getSourceArticles(selectedSource: String, completion: @escaping ([Article]) -> ()) {
        let requestURL = selectedSourcesString + "=" + selectedSource + "&" + apiKeyString
        print(requestURL)
        AF.request(requestURL, method: .get)
            .responseJSON
            { response in
                switch response.result {
                case .success:
                    print("Success! Got all the sources articles")
                    let responseJSON: JSON = JSON(response.value!)
                    completion(self.updateNewsData(newsJSON: responseJSON))
                    
                case .failure:
                    print("Error \(String(describing: response.error))")

            }
        }
    }
    
    func getArticleByTitle(favouritedArticleTitles: [String], completion: @escaping ([Article]) -> ()) {
        var baseRequestURL = kBaseServerURL + kEverythingPath + "q="
        for i in 0...favouritedArticleTitles.count-1 {
            let title = favouritedArticleTitles[i]
            if i != favouritedArticleTitles.count - 1 {
                baseRequestURL = baseRequestURL + "\\" + "\"" + "\(title)" + "\\" + "\"" + " OR "
            } else {
                baseRequestURL = baseRequestURL + "\\" + "\"" + "\(title)" + "\\" + "\"" + "&" + apiKeyString
            }
        }
        print(baseRequestURL)
        let request = URL(string: baseRequestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        AF.request(request!, method: .get)
            .responseJSON
            { response in
                switch response.result {
                case .success:
                    print("Found the article that is looked for")
                    let responseJSON: JSON = JSON(response.value!)
                    completion(self.updateNewsData(newsJSON: responseJSON))
                case .failure:
                    print("Error \(String(describing: response.error))")
                }
        }
    }
    
    func updateNewsData(newsJSON : JSON) -> [Article] {
        print("Parsing the articles JSON")
        var articleList = [Article]()
        for article in newsJSON["articles"].arrayValue {
            articleList.append(Article.init(articlesJSON : article))
        }
        return articleList
    }
    
    func updateSourceData(sourceJSON : JSON) -> [Sources] {
        print("Parsing the sources JSON")
        
        var sourcesList = [Sources]()
        
        for source in sourceJSON["sources"].arrayValue {
            sourcesList.append(Sources.init(sourcesJSON: source))
        }
        return sourcesList
    }
}
