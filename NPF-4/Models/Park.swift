import Foundation
import MapKit
import Contacts

class Park : NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    
    var name: String
    var state: String
    var desc: String
    var imgUrl: String
    var dateFormed: String
    var area: String
    var link: String
    
    var coordinate: CLLocationCoordinate2D
    var location: CLLocation
    
    init(coordinate: CLLocationCoordinate2D, parkName: String, parkLocation: String, parkDescription: String, imageUrl: String, dateFormed: String, area: String, link: String) {
        
        self.title = parkName
        self.subtitle = parkLocation
        
        self.name = parkName
        self.state = parkLocation
        self.desc = parkDescription
        self.imgUrl = imageUrl
        self.dateFormed = dateFormed
        self.area = area
        self.link = link
        
        self.coordinate = coordinate
        self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        super.init()
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
