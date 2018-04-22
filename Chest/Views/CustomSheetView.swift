//
//  CustomSheetView.swift
//  Chest
//
//  Created by Ítalo Sangar on 22/04/18.
//  Copyright © 2018 iTSangar. All rights reserved.
//

import UIKit

class CustomSheetView: UIView {
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var stackButtons: UIStackView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("CustomSheet", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
