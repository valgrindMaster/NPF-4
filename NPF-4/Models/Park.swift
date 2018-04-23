import Foundation
import MapKit

class Park : NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var link: String?
    var coordinate: CLLocationCoordinate2D
    var location: CLLocation
    
    init(coordinate: CLLocationCoordinate2D, parkName: String, parkLocation: String, link: String) {
        
        self.title = parkName
        self.subtitle = parkLocation
        self.link = link
        self.coordinate = coordinate
        self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        super.init()
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}
