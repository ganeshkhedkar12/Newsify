//
//  WebService.swift
//  Newsify
//
//  Created by Daksh K on 14/03/22.
//

import Foundation

class Webservice {
    
    func getAllNews(url: URL, completion: @escaping ([News]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                do {
                    let newsList = try JSONDecoder().decode(NewsList.self, from: data)
                    completion(newsList.articles)
                } catch let error {
                    print(error)
                    completion([])
                }
            }
            
        }.resume()
        
    }
    
}
