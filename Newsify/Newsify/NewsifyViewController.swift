//
//  ViewController.swift
//  Newsify
//
//  Created by Daksh K on 14/03/22.
//

import UIKit

class NewsifyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var flagIcon: UIBarButtonItem!
    
    private var newsListViewModel: NewsListViewModel = NewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.newsListViewModel.delegate = self
        getNewsFromServer()
        setSettings()
    }
    
    func setSettings() {
        let countryCode = self.newsListViewModel.getCurrentCountryCode()
        self.flagIcon.title = Country(rawValue: countryCode)?.displayShortName
    }
    
    private func getNewsFromServer() {
        self.newsListViewModel.getAllNewsFromWeb()
    }
    
    @IBAction func showOptions(_ sender: Any) {
        self.performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showSettings" {
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("NavigationController not found")
            }
            
            guard let settingsTVC = nav.viewControllers.first as? SettingViewController else {
                fatalError("SettingViewController not found")
            }
            
            settingsTVC.delegate = self
        }
        
    }
    
}

extension NewsifyViewController {
    
    //MARK:- Table View Delegates and DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.newsListViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.newsListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("NewsTableViewCell not found")
        }
        let newsVM: NewsViewModel = self.newsListViewModel.NewsAtIndex(indexPath.row)
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.titleLabel.text = newsVM.title
        cell.descriptionLabel.text = newsVM.description
        
        return cell
    }

}

extension NewsifyViewController : RefreshYourViewDelegate{
    func refreshView() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
}

extension NewsifyViewController: SettingsDelegate {
    
    func settingsDone(vm: SettingsViewModel) {
        if self.newsListViewModel.lastSelectedCountry.rawValue != vm.selectedCountry.rawValue {
            newsListViewModel.updateCountry(to: vm.selectedCountry)
            setSettings()
            newsTableView.reloadData()
        }
    }
}

