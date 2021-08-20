//
//  Movies.swift
//  MovieProject
//
//  Created by Justin on 3/14/21.
//
import UIKit
import Foundation
import CoreData

class Movies: UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    func getCount() -> Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [MovieEntity])!
        return fetchResults.count
    }
    
    func getMovieObj(index:Int) -> MovieEntity{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [MovieEntity])!
        return fetchResults[index]
    }
    
    func getMovieObjByName(name:String) -> MovieEntity{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [MovieEntity])!
        for each in fetchResults{
            if each.title! == name{
                return each
            }
        }
        return fetchResults[0]
    }
    
    func addMovie(title:String, rDate:Date, image: Data){
        let newMovie = MovieEntity(context: self.managedObjectContext)
        newMovie.title = title
        newMovie.date = rDate
        newMovie.picture = image
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
    }

    func deleteMovie(index:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [MovieEntity])!
        let movieToRemove = fetchResults[index]
        self.managedObjectContext.delete(movieToRemove)
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
    }
    
    
    
}
