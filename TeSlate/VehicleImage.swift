//
//  VehicleImage.swift
//  ControlWidgetExtension
//
//  Created by Nila on 18.09.20.
//

import Foundation
import SwiftUI

/*https://static-assets.tesla.com/configurator/compositor?&options=$W38B,$PMNG,$DV4W,$MT310,$IN3PB&view=STUD_3QTR&model=m3&size=1441&bkba_opt=1&version=v0028d202009171106*/

func GetVehicleImage(_ vehicle: TeSlateVehicleConfig?) -> String {
    guard let model = vehicle?.model?.apiCode() else {
        return "https://static-assets.tesla.com/configurator/compositor?&options=$W38B,$PMNG,$DV4W,$MT313,$IN3PB&view=STUD_3QTR&model=m3&size=1441&bkba_opt=1"
    }
    let view: String
    let size: Int
    var options: String
    switch vehicle?.model {
    case .ModelS:
        options = "$MTS07"
        size = 1241
        view = "STUD_3QTR_V2"
        if vehicle?.wheels == nil {
            vehicle?.wheels = .Silver19
        }
    case .Model3:
        options = "$MT313"
        size = 1441
        view = "STUD_3QTR"
        if vehicle?.wheels == nil {
            vehicle?.wheels = .Pinwheel18
        }
    case .ModelX:
        options = "$MTX05"
        size = 1441
        view = "STUD_3QTR_V2"
        if vehicle?.wheels == nil {
            vehicle?.wheels = .Silver20
        }
    case.ModelY:
        options = "$DV4W,$MTY03,$INYPB"
        size = 1441
        view = "STUD_3QTR"
        if vehicle?.wheels == nil {
            vehicle?.wheels = .Gemini19
        }
    default:
        return "https://static-assets.tesla.com/configurator/compositor?&options=$W38B,$PMNG,$DV4W,$MT313,$IN3PB&view=STUD_3QTR&model=m3&size=1441&bkba_opt=1"
    }
    
    if vehicle?.color == nil {
        options += ",$PMNG"
    } else {
        options += ",$" + vehicle!.color!.paintCode()!
    }
    
    if vehicle?.wheels != nil {
        options += ",$" + vehicle!.wheels!.wheelCode()!
    }
    
    return "https://static-assets.tesla.com/configurator/compositor?&options=\(options)&view=\(view)&model=\(model)&size=\(size)&bkba_opt=1"
}

