//
//  ChestViewController.swift
//  Chest
//
//  Created by Ítalo Sangar on 21/04/18.
//  Copyright © 2018 iTSangar. All rights reserved.
//

import UIKit
import UberRides
import CoreLocation

class ChestViewController: UIViewController {
  
  @IBOutlet weak private var tableView: UITableView!
  @IBOutlet weak private var stack: UIStackView!
  
  let cellIdentifier = "TrackingTableViewCell"
  var histories: [History]!
  var box: Box!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = box.chest.code
    
    setupButtons()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //view.addSubview(setupRideButton())
  }
  
  private func setupButtons() {
    if let lastHistory = histories.last {
      stack.isHidden = lastHistory.status != .chest
    }
  }
  
  private func setupRideButton(frame: CGRect) -> RideRequestButton {
    let builder = RideParametersBuilder()
    let dropoffLocation = CLLocation(latitude: box.chest.location.latitude, longitude: box.chest.location.longitude)
    builder.dropoffLocation = dropoffLocation
    builder.dropoffNickname = box.chest.code
    builder.dropoffAddress = box.chest.address
    let rideParameters = builder.build()
    
    let button = RideRequestButton(rideParameters: rideParameters)
    button.frame = frame
    return button
  }
  
  private func setupCabifyButton(frame: CGRect) -> UIButton {
    let button = UIButton(frame: frame)
    button.backgroundColor = UIColor(red: 111/255, green: 66/255, blue: 251/255, alpha: 1)
    button.setTitle("Cabify", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 5
    button.clipsToBounds = true
    return button
  }
  
}

extension ChestViewController {
  
  @IBAction func getOnChest() {
    let customView = CustomSheetView()
    customView.translatesAutoresizingMaskIntoConstraints = false
    customView.addConstraint(NSLayoutConstraint(item: customView,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: 100))
    
    let title: String = "PRA QUE ESPERAR MAIS?\nTemos alguns parceiros para te levar \naté seu Chest"
    let alert = UIAlertController(title: title,
                                  customView: customView,
                                  fallbackMessage: "",
                                  preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Eu vou retirar", style: .default))
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
    
    let frame = ((customView.contentView.subviews.first as! UIStackView).arrangedSubviews.first?.frame)!
    
    (customView.contentView.subviews.first as! UIStackView).arrangedSubviews.first?.addSubview(setupRideButton(frame: frame))
    
    (customView.contentView.subviews.first as! UIStackView).arrangedSubviews[1].addSubview(setupCabifyButton(frame: frame))

    
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func pickSchedule() {
    let customView = CustomSheetView()
    customView.translatesAutoresizingMaskIntoConstraints = false
    customView.addConstraint(NSLayoutConstraint(item: customView,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: 100))
    
    let title: String = "OPÇÕES DE AGENDAMENTO\nEscolha um parceiro para trazer seu pacote\nem um dos horários disponíveis"
    let alert = UIAlertController(title: title,
                                  customView: customView,
                                  fallbackMessage: "",
                                  preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
    
    let frame = ((customView.contentView.subviews.first as! UIStackView).arrangedSubviews.first?.frame)!
    
    (customView.contentView.subviews.first as! UIStackView).arrangedSubviews.first?.addSubview(setupRideButton(frame: frame))
    
    (customView.contentView.subviews.first as! UIStackView).arrangedSubviews[1].addSubview(setupCabifyButton(frame: frame))
    
    
    self.present(alert, animated: true, completion: nil)
  }
}

extension ChestViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 96
  }
  
}

extension ChestViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return histories.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrackingTableViewCell  else {
      fatalError("The dequeued cell is not an instance of MealTableViewCell.")
    }
    
    cell.history = histories[indexPath.row]
    
    return cell
  }
  
}


