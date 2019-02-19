//
//  ViewController.swift
//  LoadJsonAsync
//
//  Created by Sprinthub on 13/02/2019.
//  Copyright © 2019 Sprinthub Mobile. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parsePetitions(json: data)
                    return
                }
            }
        }
        
        showError()
    }
    
    //function to parse our json
    func parsePetitions(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()                
            }
            
        }
    }
    
    func showError(){
        DispatchQueue.main.async { [unowned self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        return cell
    }

}

