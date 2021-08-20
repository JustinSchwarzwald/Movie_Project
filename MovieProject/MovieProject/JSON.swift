//
//  JSON.swift
//  MovieProject
//
//  Created by Justin on 3/20/21.
//

import Foundation
import UIKit

class JSON{
    
   
    

    
    
    
    func getMovieID(title:String) -> String{
        struct idObj: Decodable {
            let page: Int?
            let results: [result]?
            let total_results:Int?
            let total_pages:Int?
        }

        struct result: Decodable{
            let poster_path:String?
            let adult:Bool?
            let overview:String?
            let release_date:String?
            let genre_ids:[Int]?
            let id:Int?
            let original_title:String?
            let original_language:String?
            let title:String?
            let backdrop_path:String?
            let popularity:Float?
            let vote_count:Int?
            let video:Bool?
            let vote_average:Float?
        }

        // data structure that store movie objs
        var MovieIDS:[idObj]?
        
        //"https://api.themoviedb.org/3/search/movie?api_key=af77d26bcee44ecbfb03131f77351b54&language=en-US&query=QUERYHERE&page=1&include_adult=false"
        
        var returnVal:String?
        
        var urlAsString1 = "https://api.themoviedb.org/3/search/movie?api_key=af77d26bcee44ecbfb03131f77351b54&language=en-US&query="
        let mID = title.replacingOccurrences(of: " ", with: "%20")
        urlAsString1 = urlAsString1 + mID + "&page=1&include_adult=false"
        
        let url1 = URL(string: urlAsString1)!
        
        let urlSession1 = URLSession.shared
        
        
        let jsonQuery1 = urlSession1.dataTask(with: url1, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            let decoder1 = JSONDecoder()
            let jsonResult1 = try! decoder1.decode(idObj.self, from: data!)
            
            //var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult1)

                if(jsonResult1.total_results != 0){
            
                let var1 = jsonResult1.results![0].id
                   returnVal = String(var1!)
                }
                else
                {
                    returnVal = "Could Not Locate Movie"
                }
                
            

            
        })
        
        
        
        jsonQuery1.resume()
        while(returnVal == nil)
        {
            
        }
        return returnVal!
    }
    
    func getMovieCast(identifer:String)-> (String, String, String, String){
        
        
        struct MovieObj: Decodable {
            let id: Int?
            let cast: [Mcast]?
            let crew: [Mcrew]?
        }

        struct Mcast: Decodable{
            let adult:Bool?
            let gender:Int?
            let id:Int?
            let known_for_department:String?
            let name:String?
            let original_name:String?
            let popularity:Float?
            let profile_path:String?
            let cast_id:Int?
            let character:String?
            let credit_id:String?
            let order:Int?
        }
        
        struct Mcrew: Decodable {
            let adult: Bool
            let gender: Int?
            let id: Int
            let known_for_department: String
            let name: String
            let original_name: String
            let popularity: Float
            let profile_path: String?
            let credit_id: String
            let department: String
            let job: String
        }
        
        var returnVals:(String, String, String, String)?
        
        var urlAsString = "https://api.themoviedb.org/3/movie/"
        let movieID = identifer
        urlAsString = urlAsString + movieID + "/credits?api_key=af77d26bcee44ecbfb03131f77351b54&language=en-US"
        
        let url = URL(string: urlAsString)!
        
        let urlSession = URLSession.shared
        
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(MovieObj.self, from: data!)
            
            //var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult)
            if(jsonResult.cast!.count > 4){
            let text1 = jsonResult.cast![0].name! + " playing as " + jsonResult.cast![0].character!
            let text2 = jsonResult.cast![1].name! + " playing as " + jsonResult.cast![1].character!
            let text3 = jsonResult.cast![2].name! + " playing as " + jsonResult.cast![2].character!
            let text4 = jsonResult.cast![3].name! + " playing as " + jsonResult.cast![3].character!
            let labelVals = (text1,text2,text3,text4)
            returnVals = labelVals
            }
            else{
                returnVals = ("Could not find cast","","","")
            }
            
        })

        jsonQuery.resume()
        while(returnVals == nil){
            
        }
        return returnVals!
        
    }
    
}
