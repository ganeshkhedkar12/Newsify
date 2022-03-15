//
//  NewsViewModel.swift
//  Newsify
//
//  Created by Daksh K on 14/03/22.
//

import Foundation


protocol RefreshYourViewDelegate{
    func refreshView()
}

class NewsListViewModel: RefreshYourViewDelegate {
    var news: [News] = []
    var delegate : RefreshYourViewDelegate!
    var lastSelectedCountry: Country!
}

extension NewsListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.news.count
    }
    
    func NewsAtIndex(_ index: Int) -> NewsViewModel {
        let news = self.news[index]
        return NewsViewModel(news)
    }
    
}

extension NewsListViewModel {
    
    func getAllNewsFromWeb() {
        
        // get the default settings for temperature
        let userDefaults = UserDefaults.standard
        let countryCode = (userDefaults.value(forKey: "countryCode") as? String) ?? "us" //ca
        self.lastSelectedCountry = Country(rawValue: countryCode)
        
        let url = Constants.Urls.urlNews(countryCode: countryCode)
        Webservice().getAllNews(url: url) { [weak self] allNews in
            
            if let allNews = allNews {
                self?.news.removeAll()
                allNews.forEach { news_ in
                    self?.news.append(news_)
                }
            }
            self?.refreshView()
        }
        
    }
    
    func refreshView() {
        if let delegate_ = self.delegate {
            delegate_.refreshView()
        }
    }
    
    func setImageFrom(imageURL: URL, completionHandler: @escaping (Data) -> ()) {
        let task = URLSession.shared.downloadTask(with: imageURL, completionHandler: { (location, response, error) in
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    completionHandler(data)
                }
            }
        })
        task.resume()
    }
    
}

extension NewsListViewModel {
    
    func getCurrentCountryCode() -> String {
        let userDefaults = UserDefaults.standard
        let countryCode = (userDefaults.value(forKey: "countryCode") as? String) ?? "us"
        
        return countryCode
    }
    
    func updateCountry(to country: Country) {
        getAllNewsFromWeb()
    }
    
}

struct NewsViewModel {
    private let news: News
}

extension NewsViewModel {
    init(_ news: News) {
        self.news = news
    }
}

extension NewsViewModel {
    
    var title: String {
        return self.news.title
    }
    
    var description: String {
        return self.news.description ?? ""
    }
    
    var author : String {
        return self.news.author ?? "Unknown"
    }
    
    var publishingDate: String {
//        "2022-03-15T05:03:19Z"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        let dateString: String = self.news.publishedAt ?? ""
        var finalDateString: String = ""
        guard let dateFromString = dateFormatter.date(from: dateString) else {
            return ""
        }
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        finalDateString = dateFormatter.string(from: dateFromString)
        
        return finalDateString
    }
    
    var photoURL: String {
        return self.news.urlToImage ?? ""
    }
}
