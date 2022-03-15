//
//  SettingViewController.swift
//  Newsify
//
//  Created by Daksh K on 15/03/22.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func settingsDone(vm: SettingsViewModel)
}


class SettingViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var countryTableView: UITableView!
    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func doneActionTapped(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.settingsDone(vm: settingsViewModel)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension SettingViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        let settingsItem = settingsViewModel.countries[indexPath.row]
        cell.textLabel?.text = settingsItem.displayName
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        if settingsItem == settingsViewModel.selectedCountry {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // uncheck all cells
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let country = Country.allCases[indexPath.row]
            settingsViewModel.selectedCountry = country
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
}
