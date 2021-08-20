//
//  CastViewController.swift
//  MovieProject
//
//  Created by Justin on 3/18/21.
//

import Foundation
import UIKit

class CastViewController: UIViewController {
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var actor1: UILabel!
    @IBOutlet weak var actor2: UILabel!
    @IBOutlet weak var actor3: UILabel!
    @IBOutlet weak var actor4: UILabel!
    
    var movieTitle:String?
    var movieIdentifier:String?
    var labels:(String,String,String,String)?
    
    let castConnect = JSON()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieIdentifier = castConnect.getMovieID(title:movieTitle!)
        TitleLabel.text = movieTitle! + " Cast"
        
        
        while (self.movieIdentifier == nil) {
            
        }
        if  self.movieIdentifier != "Could Not Locate Movie"{
            self.labels = castConnect.getMovieCast(identifer: self.movieIdentifier!)
            while (self.labels == nil){
                
            }

                actor1.text = labels?.0
                actor2.text = labels?.1
                actor3.text = labels?.2
                actor4.text = labels?.3
        }
        else{
            actor1.text = " Movie Was Not Found in Database"
            actor2.text = ""
            actor3.text = ""
            actor4.text = ""
        }
       

    
    }
    

    
    
    
}



