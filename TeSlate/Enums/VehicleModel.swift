//
//  VehicleModel.swift
//  TeSlate
//
//  Created by Nila on 26.09.20.
//

import Foundation

enum VehicleModel: String, Codable {
    static let vehicleModelCodeMap = [
        VehicleModel.ModelS: "ms",
        .Model3: "m3",
        .ModelX: "mx",
        .ModelY: "my"
    ]
    
    case ModelS = "models"
    case Model3 = "model3"
    case ModelX = "modelx"
    case ModelY = "modely"
    
    func apiCode() -> String? {
        return VehicleModel.vehicleModelCodeMap[self]
    }
    
    static func assumeModel(model: String) -> VehicleModel? {
        let m = model.lowercased()
        if m.contains("models") {
            return .ModelS
        }
        if m.contains("model3") {
            return .Model3
        }
        if m.contains("modelx") {
            return .ModelX
        }
        if m.contains("modely") {
            return .ModelY
        }
        return nil
    }
    
    static func fromApiCode(apiCode: String) -> VehicleModel? {
        return VehicleModel.vehicleModelCodeMap.someKey(forValue: apiCode)
    }
    
    static func fromVIN(vin: String) -> VehicleModel? {
        if vin.count < 4 {
            return nil
        }
        
        switch vin[3].lowercased() {
        case "s":
            return .ModelS
        case "3":
            return .Model3
        case "x":
            return .ModelX
        case "y":
            return .ModelY
        default:
            return nil
        }
    }
}
