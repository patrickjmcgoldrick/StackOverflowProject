//
//  ViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchView: UISearchBar!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let urlBuilder = URLBuilder()
    let fakeData = ["patrick", "ryan", "salma"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let url = urlBuilder.getSearchURL(searchTerm: "swift DispatchGroup")
        
        let network = NetworkController()
        network.loadData(urlString: url) { (data) in
            
            print(String(data: data, encoding: .utf8)!)
            
            let parser = SearchParser()
            parser.parse(data: data) { (searchData) in
                
                print(searchData.items?[0].title) //items[0].title)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fakeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? UITableViewCell else { return UITableViewCell() }
        
        cell.textLabel?.text = fakeData[indexPath.row]
        
        return cell
    }
    
    
    
}

