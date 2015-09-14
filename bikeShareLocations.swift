//
//  bikeShareLocations.swift
//  BikeShare2Attempt
//
//  Created by tho dang on 2015-09-13.
//  Copyright (c) 2015 Tho Dang. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class bikeShareLocations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var logo: String
    init( coordinate: CLLocationCoordinate2D, title: String,subtitle: String ,logo:String) {
        
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.logo = logo
    }
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
