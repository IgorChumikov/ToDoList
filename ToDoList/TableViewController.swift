//
//  TableViewController.swift
//  ToDoList
//
//  Created by Игорь Чумиков on 18.03.2021.
//  Copyright © 2021 Игорь Чумиков. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let uncheckImage = UIImage(named: "uncheck")
    let checkImage = UIImage(named: "check")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - UI
    
    @IBAction func pushAddAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create new item", message: "", preferredStyle: .alert)
        alertController.addTextField { (text) in
            text.placeholder = ""
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default)
        let actionCreate = UIAlertAction(title: "Create", style: .cancel) { (alert) in
            if let newItem = alertController.textFields![0].text {
                addItem(nameItem: newItem)
                self.tableView.reloadData()
            }
        }
        alertController.addAction(actionCancel)
        alertController.addAction(actionCreate)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func pushEditAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = toDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String ?? "NOOOOO"
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = checkImage
        }else{
            cell.imageView?.image = uncheckImage
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(at: indexPath.row) {
                  tableView.cellForRow(at: indexPath)?.imageView?.image = checkImage
        }else{
                    tableView.cellForRow(at: indexPath)?.imageView?.image = uncheckImage
        }
        tableView.reloadData()
        
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
