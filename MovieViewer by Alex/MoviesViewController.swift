//
//  MoviesViewController.swift
//  MovieViewer by Alex
//
//  Created by Alex Stepakov on 10/18/16.
//  Copyright © 2016 Alex Stepakov. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    
    var movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL (string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession (
            configuration: URLSessionConfiguration.default ,
            delegate: nil, delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask (with: request,
                                 completionHandler: { (data0rNil, response, error) in
                                    if let data = data0rNil {
                                    if let responseDictionary = try!
                                        JSONSerialization.jsonObject(with: data, options :[]) as? NSDictionary
                                    {
                                        print("response:\(responseDictionary)")


self.movies = responseDictionary["results"] as! [NSDictionary]
self.tableView.reloadData()

                                        }
                }
                                 
        });
        task.resume()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

let movie = movies[indexPath.row]
let title = movie["title"] as! String

        cell.textLabel!.text = title
        print("row\(indexPath.row)")
        return cell
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
