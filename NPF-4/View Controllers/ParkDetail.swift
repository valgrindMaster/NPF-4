//
//  ParkDetail.swift
//  NPF-4
//
//  Created by Oliver Haynes on 4/23/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ParkDetail: UITableViewController {
    
    let dtFormatterFrom = DateFormatter()
    let dtFormatterTo = DateFormatter()
    
    var park: Park!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dtFormatterFrom.dateFormat = "yyyy-MM-dd"
        dtFormatterTo.dateFormat = "MMM dd, yyyy"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRowsInSec: Int
        switch section {
        case 0:
            numRowsInSec = 4
        default:
            numRowsInSec = 1
        }
        
        return numRowsInSec
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parkdetailcell", for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 10
        let section = indexPath.section
        
        if (section == 0) { //Header section
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = park.name
            case 1:
                cell.textLabel?.text = park.state
            case 2:
                cell.textLabel?.text = park.area
            case 3:
                let date = dtFormatterFrom.date(from: park.dateFormed)!
                cell.textLabel?.text = "Date Formed: " + dtFormatterTo.string(from: date)
            default:
                break
            }
        } else if (section == 1) { //Image section
            if let data = try? Data(contentsOf: URL(string: park.imgUrl)!) {
                cell.imageView?.image = UIImage(data: data)
            }
        } else if (section == 2) { //Description section
            cell.textLabel?.text = park.desc
        } else if (section == 3) { //Link section
            cell.textLabel?.text = park.link
        } else if (section == 4) { //Open on map section
            cell.textLabel?.text = "Show on Map"
        } else if (section == 5) { //Add to favorites section
            if (FavoritesManager.isInFavorites(parkName: park.name)) {
                cell.textLabel?.text = "Remove from Favorites"
            } else {
                cell.textLabel?.text = "Add to Favorites"
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        case 3:
            if let url = NSURL(string:park.link) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        case 4:
            self.tabBarController!.selectedIndex = 0
        case 5:
            let label = tableView.cellForRow(at: indexPath)?.textLabel
            if (label?.text == "Add to Favorites") {
                FavoritesManager.addToFavorites(park: park)
                
                let alert = UIAlertController(title: "Favorites", message: "Park has been added to your favorites!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                label?.text = "Remove from Favorites"
            } else {
                FavoritesManager.removeFromFavorites(parkName: park.name)
                label?.text = "Add to Favorites"
            }
        default:
            break
        }
    }
}
