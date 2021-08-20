//
//  MovieTableViewCell.swift
//  MovieProject
//
//  Created by Justin on 3/14/21.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var moviePicture: UIImageView!
    
 override func awakeFromNib() {
     super.awakeFromNib()
     // Initialization code
 }

 override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)

     // Configure the view for the selected state
 }

}
