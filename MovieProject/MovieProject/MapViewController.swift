//
//  MapViewController.swift
//  MovieProject
//
//  Created by Justin on 3/18/21.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var map: MKMapView!
  
    var manager:CLLocationManager!
    var latFinder:CLLocationDegrees?
    var lonFinder:CLLocationDegrees?
        
    override func viewDidLoad() {
        super.viewDidLoad()
	
        DispatchQueue.main.async {
            self.manager = CLLocationManager()
        
            self.manager.delegate = self
        
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.requestWhenInUseAuthorization()
        
            self.manager.startUpdatingLocation()
        }

           
    }
    
    
    func loadMap(){
        
        
        var annotationItems:[MKPointAnnotation] = []
        for i in 0...4{
            let item = MKPointAnnotation()
            annotationItems.append(item)
        }
        if self.latFinder != nil || self.lonFinder != nil{
        // display the map
        let lat : CLLocationDegrees = self.latFinder!
        let lon : CLLocationDegrees = self.lonFinder!
        
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        
        self.map.setRegion(region, animated: true)
        

        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Moive Theater"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print( response.mapItems )
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 0...4
            {
                
                let place = matchingItems[i].placemark
                
                let latC:CLLocationDegrees = (place.location?.coordinate.latitude)!
                let lonC:CLLocationDegrees = (place.location?.coordinate.longitude)!
                
                let locationCoord = CLLocationCoordinate2D( latitude: latC, longitude: lonC)
                
                let annotationItem = annotationItems[i]
                annotationItem.coordinate = locationCoord
                annotationItem.title = place.name
                
                self.map.addAnnotation(annotationItem)
                
                print(place.location?.coordinate.latitude)
                print(place.location?.coordinate.longitude)
                print(place.name)
                
            }
        
        
            // Do any additional setup after loading the view.
        }
        }
    }
    
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //userLocation - there is no need for casting, because we are now using CLLocation object

        let userLocation:CLLocation = locations[0]
        
        self.latFinder = userLocation.coordinate.latitude
        
        self.lonFinder = userLocation.coordinate.longitude

        loadMap()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        

    }
