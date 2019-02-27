//
//  ViewController.swift
//  WebBrowsery
//
//  Created by Stefan Milenkovic on 2/27/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var websites = ["apple.com","hackingwithswift.com","seanallen.co","google.com","wrongurl"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Web places"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Browser") as? BrowserViewColntroller else {return}
        
        vc.retreivedWebSite = websites[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    
    }


}

