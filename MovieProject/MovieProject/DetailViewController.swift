//
//  DetailViewController.swift
//  MovieProject
//
//  Created by Justin on 3/14/21.
//
import Foundation
import UIKit

class DetailViewController: UIViewController {
    var movie:MovieEntity?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie!.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        if let date = movie?.date
        {
            movieDate.text = dateFormatter.string(from:date)
        }
        else
        {
            movieDate.text = "unknown"
        }
        
        if let picture = movie!.picture{
            movieImage?.image = UIImage(data: picture  as Data)
        } else {
            movieImage.image = nil
        }
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func Trailers(_ sender: Any) {
        let movieTitleTrailer = self.movieTitle.text! + " Trailers"
            
            let scheme = "https"
            let host = "www.google.com"
            let path = "/search"
            let queryItem = URLQueryItem(name: "q", value: movieTitleTrailer)
            
            
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = [queryItem]
            
           // let url = NSURL(string: urlComponents.url )!
            UIApplication.shared.openURL(urlComponents.url!)
    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        do{
            if(segue.identifier == "CastViewController"){
                if let CastViewController: CastViewController = segue.destination as? CastViewController {
                    CastViewController.movieTitle = movieTitle.text
                }
            }
        }
        catch{

        }


    }

}
