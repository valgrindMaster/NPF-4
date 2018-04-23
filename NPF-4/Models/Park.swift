import Foundation
import MapKit

class Park : NSObject, MKAnnotation {
    
    var name: String?
    var state: String?
    var desc: String?
    var link: String?
    var coordinate: CLLocationCoordinate2D
    var location: CLLocation
    
    init(coordinate: CLLocationCoordinate2D, parkName: String, parkLocation: String, parkDescription: String, link: String) {
        
        self.name = parkName
        self.state = parkLocation
        self.desc = parkDescription
        self.link = link
        self.coordinate = coordinate
        self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        super.init()
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}
