//
//  Parks.swift
//  NPF-4
//
//  Created by Student on 4/19/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Parks: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var locationManager = CLLocationManager()
    var parks: [Park] = []
    var myLocation = CLLocation()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func updateTableView(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                parks.sort(by: {$0.title! < $1.title!})
            case 1:
                parks.sort(by: {$0.title! > $1.title!})
            case 2:
                parks.sort(by: {$0.distance(to: myLocation) < $1.distance(to: myLocation)})
            default:
                break
        }
        
        tableView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parks = delegate.parks
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myLocation = locations.last! as CLLocation
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ParkCell(park: parks[indexPath.row], reuseIdentifier: "parkcell")
        cell.textLabel?.text = cell.getPark().title
        
        let parkLocation = CLLocation(latitude: cell.getPark().coordinate.latitude, longitude: cell.getPark().coordinate.longitude)
        
        let distanceMeters = abs(parkLocation.distance(from: myLocation))
        
        cell.detailTextLabel?.text = String(format:"Distance: %.2f miles", (distanceMeters * 0.00062))

        
        return cell
    }
    

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let park = parks[indexPath.row]
        let parkDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ParkDetail")  as! ParkDetail
        parkDetail.park = park
        navigationController?.pushViewController(parkDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }
}
