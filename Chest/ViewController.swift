//
//  ViewController.swift
//  Chest
//
//  Created by Ítalo Sangar on 21/04/18.
//  Copyright © 2018 iTSangar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let cellIdentifier = "ChestTableViewCell"
  var allBox: [Box] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getBox()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  
  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "seeTracking" || segue.identifier == "trackingChester",
      let destination = segue.destination as? ChestViewController,
      let boxIndex = tableView.indexPathForSelectedRow?.row {
      destination.box = allBox[boxIndex]
      destination.histories = allBox[boxIndex].history
    }
  }
  
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 55
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
    return header
  }
  
}

extension ViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allBox.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChestTableViewCell  else {
      fatalError("The dequeued cell is not an instance of MealTableViewCell.")
    }
    
    cell.box = allBox[indexPath.row]
    
    return cell
  }
}

extension ViewController {
  private func getBox() {
    var ref: DatabaseReference!
    ref = Database.database().reference()
    
    ref.child("all").observeSingleEvent(of: .value, with: { snapshot in
      if let data = snapshot.value as? [Any],
        let array = data as? [[String: Any]] {
        var boxes: [Box] = []
        for box in array {
          boxes.append(Box.boxFromDic(box))
        }
        self.allBox = boxes
        self.tableView.reloadData()
      }
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}

