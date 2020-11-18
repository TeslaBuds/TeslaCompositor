//
//  WheelModel.swift
//  TeSlate
//
//  Created by Nila on 26.09.20.
//

import Foundation

enum WheelModel: String, Codable {
    static let wheelModelCodeMap = [
        WheelModel.Arachnid21Black: "WTAB",
        .Silver19: "WTAS",
        .SonicCarbonSlipstream19: "WTDS",
        .SilverTurbine21: "WTSS",
        .SonicCarbonTwinTurbine21: "WTTC",
        
        .Pinwheel18: "W38B",
        .Pinwheel18CapKit: "W38B",
        .Stiletto19: "W39B",
        .Stiletto20: "W32B",
        .Stiletto20DarkSquare: "W32D",
        .Stiletto20DarkStaggered: "W32D",
        .Gemini19Square: "W39P",
        .Gemini19Staggered: "W39P",
        .Ueberturbine20: "W33D",
        
        .Silver20: "WT20",
        .SilverTurbine22: "WT22",
        .SonicCarbon20: "WTSC",
        .OnixBlack22: "WTUT",
        
        .Gemini19: "WY19B",
        .Induction20: "WY20P",
        .Ueberturbine21: "WY21P",
    ]
    
    // From App
    case Base19
    case Silver21
    case Charcoal21
    case Silver21Euro
    case Aero19
    case Charcoal21Euro
    case Super21Gray
    case Super21Silver
    // Model S
    case Arachnid21Black
    case Silver19 = "AeroTurbine19"
    case SonicCarbonSlipstream19 = "Slipstream19Carbon"
    case SilverTurbine21 = "TwinTurbine21Carbon"
    case SonicCarbonTwinTurbine21 = "TwinTurbine21Silver"
    
    // Model 3
    case Pinwheel18
    case Pinwheel18CapKit
    case Stiletto19
    case Stiletto20
    case Stiletto20DarkSquare
    case Stiletto20DarkStaggered
    case Gemini19Square
    case Gemini19Staggered
    case ZeroG20Gunpowder
    case Ueberturbine20
    
    // Model X
    case Silver20 = "AeroTurbine20"
    case SilverTurbine22 = "Turbine22"
    case SonicCarbon20 = "Slipstream20Carbon"
    case OnixBlack22 = "Turbine22Dark"
    
    // Model Y
    case Gemini19 = "Apollo19"
    case Gemini19CapKit = "Apollo19CapKit"
    case Induction20 = "Induction20Black"
    case Ueberturbine21 = "UberTurbine21Black"
    
    func wheelCode() -> String? {
        return WheelModel.wheelModelCodeMap[self]
    }
    
    static func fromWheelCode(_ wheelCode: String) -> WheelModel? {
        var code = wheelCode.uppercased()
        if code.contains("$") {
            code = code.replacingOccurrences(of: "$", with: "")
        }
        return WheelModel.wheelModelCodeMap.someKey(forValue: code)
    }
    
    static func fromWheelCodes(_ wheelCodes: [String]) -> WheelModel? {
        for wheelCode in wheelCodes {
            guard let wheelModel = fromWheelCode(wheelCode) else {
                continue
            }
            return wheelModel
        }
        return nil
    }
}
