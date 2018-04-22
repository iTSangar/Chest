//
//  TrackingTableViewCell.swift
//  Chest
//
//  Created by Ítalo Sangar on 22/04/18.
//  Copyright © 2018 iTSangar. All rights reserved.
//

import UIKit

class TrackingTableViewCell: UITableViewCell {
  
  @IBOutlet weak private var shadowView: UIView!
  @IBOutlet weak private var dayLabel: UILabel!
  @IBOutlet weak private var monthLabel: UILabel!
  @IBOutlet weak private var statusLabel: UILabel!
  @IBOutlet weak private var descriptionLabel: UILabel!
  @IBOutlet weak private var imageChest: UIImageView!
  
  var history: History? {
    didSet {
      setupHistory()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layoutIfNeeded()
    
    let shadowColor = UIColor(red: 192/255, green: 189/255, blue: 189/255, alpha: 1)
    
    shadowView.layer.applySketchShadow(color: shadowColor, alpha: 0.5, x: 0, y: 2, blur: 6, spread: 0)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func setupHistory() {
    dayLabel.text = history?.day
    monthLabel.text = history?.month.capitalized
    statusLabel.text = history?.status.title
    descriptionLabel.text = history?.status.desc
    
    if history?.status == .chest {
      imageChest.image = UIImage(named: "chestRounded")
    } else if history?.status == .delivered {
      imageChest.isHidden = true
    }
  }
  
}
