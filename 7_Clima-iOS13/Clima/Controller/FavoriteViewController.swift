//
//  FavoriteViewController.swift
//  Clima
//
//  Created by 徳永勇希 on 2024/04/09.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

struct rail {
    var isShown: Bool
    var railName: String
    var stationArray: [String]
}

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let headerArray: [String] = ["EU", "アジア", "オセアニア", "アフリカ"]
    private let yamanoteArray: [String] = ["ベルリン", "アムステルダム", "ロンドン"]
    private let toyokoArray: [String] = ["東京", "バンコク"]
    private let dentoArray: [String] = ["シドニー", "メルボルン"]
    private let jobanArray: [String] = ["ケープタウン"]
    
    private lazy var courseArray = [
        rail(isShown: false, railName: self.headerArray[0], stationArray: self.yamanoteArray),
        rail(isShown: false, railName: self.headerArray[1], stationArray: self.toyokoArray),
        rail(isShown: false, railName: self.headerArray[2], stationArray: self.dentoArray),
        rail(isShown: false, railName: self.headerArray[3], stationArray: self.jobanArray)
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
        if courseArray[section].isShown {
            return courseArray[section].stationArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = courseArray[indexPath.section].stationArray[indexPath.row]
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return courseArray[section].railName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let thirdVC = ThirdViewController()
        thirdVC.searchName = courseArray[indexPath.section].stationArray[indexPath.row]
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
        courseArray[section].isShown.toggle()
        
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
}

