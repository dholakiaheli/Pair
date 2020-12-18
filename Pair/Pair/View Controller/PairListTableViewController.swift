//
//  PairListTableViewController.swift
//  Pair
//
//  Created by Heli Bavishi on 12/18/20.
//

import UIKit

class PairListTableViewController: UITableViewController {
    
    var pair: Pair?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PairController.sharedInstance.loadPersistance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Action
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertController()
    }
    
    //MARK: - AlertController
    func presentAlertController() {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Full Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text
            else { return }
            
            if let pair = self.pair {
                PairController.sharedInstance.updateName(pair: pair, name: name)
            }
            PairController.sharedInstance.addName(name: name)
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return PairController.sharedInstance.pairs.count/2
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairController.sharedInstance.pairs.count
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pairCell", for: indexPath)
        
        let name = PairController.sharedInstance.pairs[indexPath.row]
        cell.textLabel?.text = name.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentAlertController();
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let nameTodelete = PairController.sharedInstance.pairs[indexPath.row]
            PairController.sharedInstance.removeName(pair: nameTodelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        customView.backgroundColor = UIColor.lightGray
        let button = UIButton(frame: CGRect(x: 50, y: -10, width: 300, height: 50))
        button.setTitle("Randomize", for: .normal)
        button.setTitleColor( #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        
        button.addTarget(self, action: #selector(randomizedButton), for: .touchUpInside)
        customView.addSubview(button)
        return customView
    }
    
    @objc func randomizedButton(sender:UIButton!){
        print("randomize button clicked")
       
        PairController.sharedInstance.pairs.shuffle()
            tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100.0
    }
    
}//End of class
