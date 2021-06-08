//
//  NewsData.swift
//  UmoriNewsAPP
//
//  Created by umoriha on 2021/05/31.
//

import Foundation
import UIKit


struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let link: URL
    let image: UIImage
}

//Jsonデータ構造
class NewsData: ObservableObject {
    struct ResultJson: Codable {
        struct Item: Codable {
            //ニュースのタイトル
            let title: String?
            //掲載URL
            let url: URL?
            //画像用
            let urlToImage: URL?
        }
        let articles: [Item]?
    }
    //ニュースのリストを作成
    @Published var newsList: [NewsItem] = []
    func searchNews(keyword: String) {
        //print(keyword)
        let apikey = ""//APIKEYはセキュリティのため伏せています
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return
        }
        guard let req_url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword_encode)&language=jp&pageSize=10&apiKey=\(apikey)&max=10&order=r")
        else{
            return
        }
        print(req_url)
        
        let req = URLRequest(url: req_url)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: req, completionHandler: {
                                    (data, response ,error) in
                                    session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                if let items = json.articles {
                    self.newsList.removeAll()
                    for item in items {
                        if
                           let name = item.title,
                           let link = item.url,
                           let imageUrl = item.urlToImage,
                           let imageData = try? Data(contentsOf: imageUrl),
                           let image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal){
                            let News = NewsItem(title: name, link: link, image: image)
                            self.newsList.append(News)
                        }
                    }
                    //print(self.newsList)
                }
            }catch{
                print("エラー")
            }
        })
        task.resume()
    }
}
