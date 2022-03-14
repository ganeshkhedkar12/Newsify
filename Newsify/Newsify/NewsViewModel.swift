//
//  NewsViewModel.swift
//  Newsify
//
//  Created by Daksh K on 14/03/22.
//

import Foundation

struct NewsListViewModel {
    let news: [News]
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
        return self.news.description
    }
}
