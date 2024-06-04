//
//  FavoriteViewController.swift
//  Clima
//
//  Created by 徳永勇希 on 2024/04/09.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

struct country {
    var isShown: Bool
    var continentName: String
    var countryArray: [String]
}

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let continentArray: [String] = ["EU", "アジア", "オセアニア", "アフリカ"]
    private let europeArray: [String] = ["ベルリン", "アムステルダム", "ロンドン"]
    private let asiaArray: [String] = ["東京", "バンコク"]
    private let oceaniaArray: [String] = ["シドニー", "メルボルン"]
    private let africaArray: [String] = ["ケープタウン"]
    
    private lazy var countriesArray = [
        country(isShown: false, continentName: self.continentArray[0], countryArray: self.europeArray),
        country(isShown: false, continentName: self.continentArray[1], countryArray: self.asiaArray),
        country(isShown: false, continentName: self.continentArray[2], countryArray: self.oceaniaArray),
        country(isShown: false, continentName: self.continentArray[3], countryArray: self.africaArray)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationController?.title = "navTest"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countriesArray[section].isShown {
            return countriesArray[section].countryArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = countriesArray[indexPath.section].countryArray[indexPath.row]
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countriesArray[section].continentName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let thirdVC = ThirdViewController()
        thirdVC.searchName = countriesArray[indexPath.section].countryArray[indexPath.row]
        self.navigationController?.pushViewController(thirdVC, animated: true)
     }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(headertapped(sender:)))
        headerView.addGestureRecognizer(gesture)
        headerView.tag = section
        return headerView
    }
    
    @objc func headertapped(sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else {
            return
        }
        countriesArray[section].isShown.toggle()
        
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
}

