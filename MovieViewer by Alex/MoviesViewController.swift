//
//  MoviesViewController.swift
//  MovieViewer by Alex
//
//  Created by Alex Stepakov on 10/18/16.
//  Copyright © 2016 Alex Stepakov. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    
    var movies: [NSDictionary] = []
    var endpoint: String = "now_playing"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession (
            configuration: URLSessionConfiguration.default ,
            delegate: nil, delegateQueue: OperationQueue.main
        )
        
        let task = session.dataTask(with: request) { (data0rNil, response, error) in
            if let data = data0rNil {
                if let responseDictionary = try!
                    JSONSerialization.jsonObject(with: data, options :[]) as? NSDictionary
                {
                    print("response:\(responseDictionary)")
                    
                    self.movies = responseDictionary["results"] as! [NSDictionary]
                    self.tableView.reloadData()
                    
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        

        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
       
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        
        if let posterPath = movie["poster_path"] as? String {
        
            let imageUrl = NSURL (string: baseUrl + posterPath)
            cell.posterView.setImageWith(imageUrl! as URL)
        }
        
        
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        
        
        
        print("row\(indexPath.row)")
        return cell
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for: cell)
        let movie = movies[indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        
        
        
        
        print("prepare for segue called")
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
