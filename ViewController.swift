//
//  ViewController.swift
//  BikeShare2Attempt
//
//  Created by tho dang on 2015-09-12.
//  Copyright (c) 2015 Tho Dang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate , MKMapViewDelegate {
    
var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string: "http://www.bikesharetoronto.com/stations/json")
        var data = NSData(contentsOfURL: url!)
       // print(data)
        if let json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary{
            
             var station  = Station(json: json)
            for pins in station.annotationPins{
                mapView.addAnnotation(pins as? bikeShareLocations)
            
            }
            
        }
       mapSetUp()
    }
    
    func mapSetUp() {
        self.locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.showsUserLocation = true

    
    }
        // Zoom in Locations
        var centre: CLLocationCoordinate2D = CLLocationCoordinate2DMake(43.6466,-79.3864)
        var span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        var regionToDisplay = MKCoordinateRegionMake(centre, span)
        self.mapView.setRegion(regionToDisplay, animated: true)
        
    }
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        // Step 1
        let identifier = "bikeShareLocations"
        
        // Step 2
        if annotation.isKindOfClass(bikeShareLocations.self) {
            // Step 3
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                // Step 4
                annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.canShowCallout = true
                
                // Step 5
                let btn = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
                annotationView.rightCalloutAccessoryView = btn
                let leftIconView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
                leftIconView.image = UIImage(named: "bike")
                annotationView.leftCalloutAccessoryView = leftIconView
            } else {
                // Step 6
                annotationView.annotation = annotation
            }
            
            return annotationView
        }
        
        // Step 7
        return nil
    }
 
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
        calloutAccessoryControlTapped control: UIControl!) {
            let location = view.annotation as! bikeShareLocations
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

