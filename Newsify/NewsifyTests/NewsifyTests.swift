//
//  NewsifyTests.swift
//  NewsifyTests
//
//  Created by Daksh K on 14/03/22.
//

import XCTest
@testable import Newsify

class NewsifyTests: XCTestCase {

    private var newsListVM: NewsListViewModel = NewsListViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        newsListVM.news = [
            News(title: "This is the first news", description: "Description 1", author: "author 1", publishedAt: "2022-03-15T05:03:19Z", urlToImage: "https://image.cnbcfm.com/api/v1/image/105443700-1536666056646gettyimages-1031207326.jpeg?v=1536666116"),
            News(title: "This is the second news", description: "Description 2", author: "author 2", publishedAt: "2022-03-15T05:03:19Z", urlToImage: "https://static01.nyt.com/images/2022/03/15/us/politics/15dc-pfizer-1/15dc-pfizer-1-facebookJumbo.jpg"),
            News(title: "This is the third news", description: "Description 3", author: "author 3", publishedAt: "2022-03-15T05:03:19Z", urlToImage: "https://sportshub.cbsistatic.com/i/r/2022/03/15/f3b5ca82-14c6-4c20-976c-7c3a5ba34dd3/thumbnail/1200x675/a63e277da156603af702e7287fa73a76/kansas.jpg")
        ]
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        newsListVM.news = []
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    //MARK:- Number Of section
    func testNumberOfSection() throws {
        let numberOfSection = self.newsListVM.numberOfSections
        XCTAssertEqual(numberOfSection, 1)
    }

    //MARK:- Number Of section
    func testNumberOfRows() throws {
        let numberOfRows = self.newsListVM.numberOfRowsInSection(0)
        XCTAssertEqual(numberOfRows, self.newsListVM.news.count)
    }
    
    func testCheckTheElements() throws {
        let firstNews = self.newsListVM.NewsAtIndex(0)
        let firstNewsObject = self.newsListVM.news[0]
        XCTAssertEqual(firstNews.title, firstNewsObject.title)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
