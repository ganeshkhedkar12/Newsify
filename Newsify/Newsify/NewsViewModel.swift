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
        
        let url = Constants.Urls.urlNews(countryCode: countryCode)//URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=aed8a18b934f4f26ada81f57b774c0cb")!
        
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
}
