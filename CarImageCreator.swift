//
//  CarImageCreator.swift
//
//  Created by Ramin Rezaiifar on 11/16/20.
//

import Foundation
import TeslaSwift

protocol CarImageCreator {
    func loadVehicleImage(vehicleInfo: VehicleExtended) -> URL?

}

extension CarImageCreator {
    
    func loadVehicleImage(vehicleInfo: VehicleExtended) -> URL? {
        
        let config = vehicleInfo.vehicleConfig!
        let urlStr = "https://static-assets.tesla.com" + "/v1/compositor/?model=\(carTypeCode(config.carType))&view=STUD_3QTR&size=400&bkba_opt=1&options=\(colorCode(config.exteriorColor)),\(wheelCode(config))" + additionalOptions(carType: config.carType)
        let url = URL(string: urlStr)
        print("url for image: \(urlStr)")
        return url
        
    }
    
    func additionalOptions(carType: String?) -> String {
        guard carType != nil else {return ""}

        if carType == "models2" {
            return ",MI01"
        }
        if carType == "models3" {
            return ",MI02"
        }
        return ""
    }
    
    func carTypeCode(_ carType: String?) -> String {
        guard carType != nil else {return "m3"}
        
        if carType!.hasPrefix("model3") { return "m3" }
        if carType!.hasPrefix("modely") { return "my" }
        if carType!.hasPrefix("models") { return "ms" }
        if carType!.hasPrefix("modelx") { return "mx" }

        return "m3"
    }

 func wheelCode(_ config: VehicleConfig) -> String {
    
    let wheelType = config.wheelType
    var defaultWheel: String = "W38B"
    
    if config.carType!.hasPrefix("model3") {
        defaultWheel = "W38B"
    }
    if config.carType!.hasPrefix("models") {
        defaultWheel = "WTTB"
    }
    if config.carType!.hasPrefix("modelx") {
        defaultWheel = "WTHX"
    }
    if config.carType!.hasPrefix("modelx") {
        defaultWheel = "WTHX"
    }

    var wheel: String
     
     switch wheelType {
     case "Pinwheel18":
         wheel = "W38B"
     case "AeroTurbine20": // MODEL X
         wheel = "WT20"
     case "Sportwheel19", "Stiletto19":
         wheel = "W39B"
     case "AeroTurbine19":
         wheel = "WTAS"
     case "Turbine19":
         wheel = "WTTB"
     case "Arachnid21Grey":
         wheel = "WTAB"
         // FIXME: Too dark.
     case "Performancewheel20", "Stiletto20":
         wheel = "W32P"
     case "AeroTurbine22":
         wheel = "WT22"
     case "Super21Gray", "TwinTurbine21Carbon":
         wheel = "WTSG"
     default:
         wheel = defaultWheel
     }

     return wheel
     

 }


 
 func colorCode(_ colorName: String?) -> String {
     var color: String
     
     switch colorName {
         case "ObsidianBlack", "SolidBlack", "MetallicBlack":
             color = "PMBL"
         case "DeepBlueMetallic", "DeepBlue":
             color =  "PPSB"
         case "RedMulticoat", "Red":
             color = "PPMR"
         case "MidnightSilverMetallic", "MidnightSilver", "SteelGrey", "SilverMetallic":
             color = "PMNG"
         case "MetallicBrown", "Brown":
             color = "PMAB"
         case "Silver":
             color = "PMSS"
         case "TitaniumCopper":
             color = "PPTI"
         case "DolphinGrey":
             color = "PMTG"
         case "Green", "MetallicGreen":
             color = "PMSG"
         case "PearlWhiteMulticoat", "PearlWhite", "Pearl":
             color = "PPSW"
         case "SolidWhite", "White":
             color = "PBCW"
         case "SignatureBlue", "MetallicBlue":
             color = "PMMB"
         case "SignatureRed":
             color = "PPSR"
         default:
             color = "PBSB"
     }
     
     return color
 }
}

