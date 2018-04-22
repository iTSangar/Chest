//
//  ChestTableViewCell.swift
//  Chest
//
//  Created by Ítalo Sangar on 22/04/18.
//  Copyright © 2018 iTSangar. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
}

class ChestTableViewCell: UITableViewCell {
  
  @IBOutlet weak private var trackingLabel: UILabel!
  @IBOutlet weak private var cityLabel: UILabel!
  @IBOutlet weak private var deliveredLabel: UILabel!
  @IBOutlet weak private var chestLabel: UILabel!
  @IBOutlet weak private var seeButton: UIButton!
  @IBOutlet weak private var imageChest: UIImageView!
  
  var box: Box? {
    didSet {
      setupBox()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layoutIfNeeded()
    imageChest.layer.cornerRadius = 20
    imageChest.clipsToBounds = true
    
    seeButton.layer.cornerRadius = 15
    seeButton.clipsToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func setupBox() {
    deliveredLabel.isHidden = (box?.status != BoxStatus.delivered)
    seeButton.isHidden = !deliveredLabel.isHidden
    
    trackingLabel.text = box?.codeTracking
    chestLabel.text = box?.chest.code
  }
  
}
