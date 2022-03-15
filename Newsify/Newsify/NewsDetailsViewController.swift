//
//  NewsDetailsViewController.swift
//  Newsify
//
//  Created by Daksh K on 15/03/22.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var newsVM: NewsViewModel!
    private var newsListViewModel: NewsListViewModel = NewsListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView() {
        self.lblTitle.text = self.newsVM.title
        self.lblDescription.text = self.newsVM.description
        self.lblAuthor.text = self.newsVM.author
        self.lblDate.text = self.newsVM.publishingDate
        
        if !newsVM.photoURL.isEmpty {
            let imgURL = URL(string: newsVM.photoURL.replacingOccurrences(of: " ", with: ""))
            newsListViewModel.setImageFrom(imageURL: imgURL!) { [weak self](imgData) in
                let img: UIImage! = UIImage(data: imgData)
                self?.newsImg.image = img
            }
        }
    }
    
    @IBAction func goBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
