//
//  VehicleColor.swift
//  TeSlate
//
//  Created by Nila on 25.09.20.
//

import Foundation



enum VehicleColor: String, Codable {
    static let vehicleColorCodeMap = [
        VehicleColor.DolphinGrey: "PMTG",
        .MontereyBlue: "PMMB",
        .SequoiaGreen: "PMSG",
        .AnzaBrown: "PMAB",
        .SignatureRed: "PPSR",
        .SunsetRed: "PPMR",
        
        .EclipseBlack: "PBSB",
        .ShastaWhitePearl: "PPSW",
        .StarlightSilver: "PMSS",
        .DeepBlue: "PPSB",
        .MidnightSilver: "PMNG",
        .ObsidianBlack: "PMBL",
        .Red: "PPMR",
        
        .CatalinaWhite: "PBCW",
        .Titanium: "PPTI"
    ]
    
    // Model S colors
    case DolphinGrey
    case MontereyBlue
    case SequoiaGreen
    case AnzaBrown
    case SignatureRed
    case SunsetRed
    
    // Model 3 & Y colors
    case EclipseBlack
    case ShastaWhitePearl
    case StarlightSilver
    case DeepBlue
    case MidnightSilver
    case ObsidianBlack
    case Red
    
    // Model X colors
    case CatalinaWhite
    case Titanium
    
    func paintCode() -> String? {
        return VehicleColor.vehicleColorCodeMap[self]
    }
    
    static func fromPaintCode(_ paintCode: String) -> VehicleColor? {
        var code = paintCode.uppercased()
        if code.contains("$") {
            code = code.replacingOccurrences(of: "$", with: "")
        }
        return VehicleColor.vehicleColorCodeMap.someKey(forValue: code)
    }
    
    static func fromPaintCode(_ paintCodes: [String]) -> VehicleColor? {
        for paintCode in paintCodes {
            guard let vehicleColor = fromPaintCode(paintCode) else {
                continue
            }
            return vehicleColor
        }
        return nil
    }
    
    static func assumeColor(color: String) -> VehicleColor? {
        let c = color.lowercased()
        switch c {
        case "blue", "deepblue", "signatureblue":
            return .DeepBlue
        case "montereyblue":
            return .MontereyBlue
        case "midnightsilver", "grey", "steelgrey":
            return .MidnightSilver
        case "dolphingrey":
            return .DolphinGrey
        case "silvermetallic", "silver":
            return .StarlightSilver
        case "pearl", "pearlwhite", "white":
            return .ShastaWhitePearl
        case "catalinawhite":
            return .CatalinaWhite
        case "black", "solidblack":
            return .EclipseBlack
        case "metallicblack":
            return .ObsidianBlack
        case "red", "redmulticoat":
            return .Red
        case "sigred", "signaturered":
            return .SignatureRed
        case "titanium", "titaniumcopper":
            return .Titanium
        case "brown", "anzabrown":
            return .AnzaBrown
        case "green", "sequoiagreen":
            return .SequoiaGreen
        default:
            return nil
        }
    }
}
