//
//  ViewController.swift
//  tumblerLab
//
//  Created by Memo on 1/10/19.
//  Copyright © 2019 Membriux. All rights reserved.
//

// –––––    Comment    –––––

import UIKit

class PhotosViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [[String: Any]] = []//This is called a property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getPosts()
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { ( data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                print(dataDictionary)
                
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                
                self.posts = responseDictionary["posts"] as! [[String: Any]]
            }
        }
        task.resume()
    }
    
    func getPosts() {
        API.getPosts() { (posts) in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
}


extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // –––––  TODO: Configure number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Code here
        return 5
    }
    
    
    // –––––  TODO: Configure CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Code here
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.textLabel?.text = "This is row\(indexPath.row)"
        
        return cell
    }

 
}

