//
//  Box.swift
//  Chest
//
//  Created by Ítalo Sangar on 21/04/18.
//  Copyright © 2018 iTSangar. All rights reserved.
//

import Foundation
import CoreLocation

enum BoxStatus {
  case posted
  case forwarded
  case route
  case chest
  case delivered
  
  var title: String {
    switch self {
    case .posted:
      return "Objeto postado"
    case .forwarded:
      return "Objeto encaminhado"
    case .route:
      return "Objeto saiu para entrega ao destinatário"
    case .chest:
      return "Objeto entregue no Chest"
    case .delivered:
      return "Produto entregue"
    }
  }
  
  var desc: String {
    switch self {
    case .posted:
      return "SAO PAULO / SP"
    case .forwarded:
      return "de Unidade de Tratamento em SAO PAULO / SP para Unidade BELO HORIZONTE / MG"
    case .route:
      return "BELO HORIZONTE / MG"
    case .chest:
      return "BELO HORIZONTE / MG"
    case .delivered:
      return "Produto entregue"
    }
  }
  
  func statusForCode(_ code: String) -> BoxStatus {
    switch code {
    case "PS":
      return .posted
    case "FW":
      return .forwarded
    case "RT":
      return .route
    case "CT":
      return .chest
    case "DL":
      return .delivered
    default:
      return .delivered
    }
  }
  
}

struct History {
  var day: String
  var month: String
  var status: BoxStatus
}

struct Chest {
  var code: String
  var location: CLLocationCoordinate2D
  var address: String
}

struct Box {
  var chest: Chest
  var status: BoxStatus
  var codeTracking: String
  var history: [History]
}

extension Box {
  static func boxFromDic(_ dic: [String: Any]) -> Box {
    let chestDic: [String: Any] = dic["chest"] as! [String : Any]
    let locationDic: [String: Double] = chestDic["location"] as! [String : CLLocationDegrees]
    
    let chest = Chest(code: chestDic["code"] as! String,
                      location: CLLocationCoordinate2D(latitude: Double(locationDic["lat"]!),
                                                       longitude: Double(locationDic["lon"]!)),
                      address: chestDic["address"] as! String)
    
    let historyDic: [[String: String]] = dic["history"] as! [[String : String]]
    var history: [History] = []

    for hist in historyDic {
      history.append(History(day: hist["day"]!, month: hist["month"]!, status: BoxStatus.route.statusForCode(hist["status"]!)))
    }
    
    let status = BoxStatus.route.statusForCode(dic["status"] as! String)
    let tracking = dic["tracking"] as! String
    
    let newBox: Box = Box(chest: chest, status: status, codeTracking: tracking, history: history)
    return newBox
  }
}

