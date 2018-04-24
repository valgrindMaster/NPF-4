//
//  Favorites.swift
//  NPF-4
//
//  Created by Oliver Haynes on 4/23/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class Favorites: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesManager.getFavorites().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath)
        let favorite = FavoritesManager.getFavorites()[indexPath.row]
        
        cell.textLabel?.text = favorite.name
        print(favorite.name)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let park = FavoritesManager.getFavorites()[indexPath.row]
        let parkDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ParkDetail")  as! ParkDetail
        parkDetail.park = park
        navigationController?.pushViewController(parkDetail, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoritesManager.removeFromFavorites(parkName: FavoritesManager.getFavorites()[indexPath.row].name)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
}
