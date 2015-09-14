

//
//  Created by tho dang on 2015-09-08.
//  Copyright (c) 2015 Tho Dang. All rights reserved.
//

import Foundation
import MapKit

struct Station {
    
    var availableBikes: Int?
    var availableDocks:Int?
    var latitude:Float?
    var longitude:Float?
    var stationName:String?
    
    // Create empty array for Annotations
    var annotationPins :NSMutableArray = []
    
    init (json:NSDictionary){
        if let bikeShareStations = json["stationBeanList"] as? NSArray{
            var bikeShareDepots = bikeShareStations
            
            for var i = 0; i < bikeShareDepots.count; i++ {
                var bikeShareData = bikeShareDepots[i] as? NSDictionary
                if let bikeShare = bikeShareData {
                    
                    if let availBikes = bikeShare["availableBikes"] as? Int{
                        self.availableBikes = availBikes as Int
                        print(self.availableBikes!)
                        
                    }
                    if let availDocks = bikeShare["availableDocks"] as? Int{
                        self.availableDocks = availDocks as Int
                        print(self.availableDocks!)
                    }
                    if let stationLat = bikeShare["latitude"] as? Float {
                        self.latitude = stationLat as Float
                        print(self.latitude!)
                    }
                    if let stationLong = bikeShare["longitude"] as? Float {
                        self.longitude = stationLong as Float
                        print(self.longitude!)
                    }
                    if let stations = bikeShare["stationName"] as? String {
                        self.stationName = stations as String
                        print(self.stationName!)
                    }
                    var annotationPin = bikeShareLocations(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longitude!)), title: stationName!, subtitle: "Available Bikes: \(availableBikes!) & Available Docks: \(availableDocks!) ", logo:"1.png")
                    
                    // then add  annotationPin to the empty array that we created above
                    annotationPins.addObject(annotationPin)
                }
               
            }
        }
        
    }
    
}
