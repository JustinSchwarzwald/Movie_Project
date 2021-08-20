//
//  ViewController.swift
//  MovieProject
//
//  Created by Justin on 3/14/21.
//
import CoreData
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var movieTable: UITableView!
    var movieConnect = Movies()
    var movieName = ""
    var movieDate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchMovies()

    }
    
    func fetchMovies(){
        do{
            DispatchQueue.main.async{
                self.movieTable.reloadData()
                self.movieTable.beginUpdates()
                self.movieTable.endUpdates()
            }
        }
        
        catch{
        
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieConnect.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 129
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        cell.layer.borderWidth = 1.0
        

        let movieItem = movieConnect.getMovieObj(index:indexPath.row)
        
        cell.movieTitle.text = movieItem.title
        cell.movieDate.text = dateFormatter.string(from: movieItem.date!)
        if let picture = movieConnect.getMovieObj(index:indexPath.row).picture{
            cell.moviePicture?.image = UIImage(data: picture  as Data)
        } else {
            cell.imageView?.image = nil
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    //Swipe to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, competionHandler) in
            self.movieConnect.deleteMovie(index:indexPath.row)
            self.movieTable.reloadData()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        var imageSend:Data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.dateStyle = .short
        dateFormatter.isLenient = true
        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageSend = image.pngData()! as NSData as Data
            print(type(of:dateFormatter.date(from:self.movieDate)))
            if let datepassing = dateFormatter.date(from:self.movieDate){
                movieConnect.addMovie(title: self.movieName,rDate: datepassing,image: imageSend)}
            
        }
        
        
        fetchMovies()
        picker .dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "Add Movie", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Movie Here"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Release date: MM/DD/YYYY"
        })
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/YYYY"
            // Do this first, then use method 1 or method 2
            if let name = alert.textFields?.first?.text, let text2 = alert.textFields?[1]{
                if let date = dateFormatter.date(from: text2.text!){
                    self.movieName = name
                    self.movieDate = text2.text!
                    // load image
                    let photoPicker = UIImagePickerController ()
                    photoPicker.delegate = self
                    photoPicker.sourceType = .photoLibrary
                    // display image selection view
                    self.present(photoPicker, animated: true, completion: nil)
                }
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/YYYY"
            // Do this first, then use method 1 or method 2
            if let name = alert.textFields?.first?.text, let text2 = alert.textFields?[1]{
                if let date = dateFormatter.date(from: text2.text!){
                    self.movieName = name
                    self.movieDate = text2.text!
                    // load image
                    let photoPicker = UIImagePickerController ()
                    photoPicker.delegate = self
                    photoPicker.sourceType = .camera
                    // display image selection view
                    self.present(photoPicker, animated: true, completion: nil)
                }
                
            }
            }
            else {
                print("No Camera")
            }
        }))
        
        self.present(alert, animated: true)
        
        fetchMovies()
        
    }
    

    
    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.movieTable.indexPath(for: sender as! UITableViewCell)!
         
        do{

            if(segue.identifier == "DetailViewController"){
                if let viewController: DetailViewController = segue.destination as? DetailViewController {
                    viewController.movie = movieConnect.getMovieObj(index: selectedIndex.row)
                }
            }
        }
        catch{
            
        }
            
        

    }
    
    
    
    
    
    
    
    
    
    

}

