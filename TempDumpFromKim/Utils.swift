func vehicleConfigToQueryString(_ vehicle_config: Vehicle_config?) -> String {
    
    #if os(iOS)
    let size = 1024
    #else
    let size = 500
    #endif

    
    let querystring = "?model=\(carTypeToCode(vehicle_config?.car_type))&view=STUD_3QTR&size=\(size)&bkba_opt=1&options=\(carTypeToOptionCode(vehicle_config?.car_type))\(colorNameToCode(vehicle_config?.exterior_color)),\(wheelTypeToCode(vehicle_config?.wheel_type, vehicle_config?.car_type))"
    return querystring
}

func carTypeToCode(_ carType: String?) -> String {
    let defaultType = ""
    
    guard carType != nil else {
        return defaultType
    }
    
    if let json = TeslaController.shared().compositorData, let models = json["models"] as? [String : Any]
    {
        if let model = models[carType!] as? String
        {
            return model
        }
        else if let model = models["default"] as? String
        {
            return model
        }
    }
    
    return defaultType
}

func carTypeToOptionCode(_ carType: String?) -> String {
    let carType = carTypeToCode(carType)

    guard carType != "" else { return "" }

    if carType == "ms" { return "MI01," }
    return ""
}

func wheelTypeToCode(_ wheelType: String?, _ carType: String?) -> String {
    let defaultType = "W38B"

    let carType = carTypeToCode(carType)

    guard carType != "" else { return defaultType }

    guard wheelType != nil else {
        if carType == "m3" { return "W39B" }
        if carType == "mx" { return "WT20" }
        if carType == "ms" { return "WTTB" }
        if carType == "my" { return "WY19B" }
        return defaultType
    }

    
    if let json = TeslaController.shared().compositorData, let models = json["wheels"] as? [String : Any]
    {
        if let wheels = models[carType] as? [String : Any]
        {
            if let wheel = wheels[wheelType!] as? String
            {
                return wheel
            }
            else if carType == "my" {
                if (wheelType?.contains("18") ?? false) { return "WY18B" }
                if (wheelType?.contains("19") ?? false) { return "WY19B" }
                if (wheelType?.contains("20") ?? false) { return "WY20P" }
                if (wheelType?.contains("21") ?? false) { return "WY21P" }
                return "WY19B"
            }
            else if let wheel = wheels["default"] as? String
            {
                return wheel
            }
        }
    }
    return defaultType
}

func colorNameToCode(_ colorName: String?) -> String {
    let defaultColor = "PBSB"
    
    guard colorName != nil else {
        return defaultColor
    }
    
    if let json = TeslaController.shared().compositorData, let colors = json["colors"] as? [String : Any]
    {
        if let color = colors[colorName!] as? String
        {
            return color
        }
        else if let color = colors["default"] as? String
        {
            return color
        }
    }
    
    return defaultColor
}

struct decodedVin {
    let carType: String
    let awd: Bool
    let year: Int
}

func decodeVIN(vin: String?) -> decodedVin?
{
    guard let vin = vin else {return nil}
    
    var year = 2010 + Int(NSString(string: vin).character(at: 9)) - Int(NSString(string: "A").character(at: 0))

    if (year > 2017)
    {
        year-=1
    }
    let modelCode = NSString(string: vin).character(at: 3)
    var model: String
    switch Character(UnicodeScalar(modelCode)!) {
    case "S":
        model = "Model S"
        break
    case "3":
        model = "Model 3"
        break
    case "X":
        model = "Model X"
        break
    case "Y":
        model = "Model Y"
        break
    default:
        model = "Model \(Character(UnicodeScalar(modelCode)!))"
    }
    
    var awd = false
    if (Character(UnicodeScalar(NSString(string: vin).character(at: 7))!) == "2" || Character(UnicodeScalar(NSString(string: vin).character(at: 7))!) == "4" || Character(UnicodeScalar(NSString(string: vin).character(at: 7))!) == "B")
    {
        awd = true
    }
    return decodedVin(carType: model, awd: awd, year: year)
}


extension UIImage {
    
    func croppedToModel(_ model: String?) -> UIImage? {
        switch model {
        case "models":
            return self.cropped(rect: CGRect(x: self.size.width * -0.1, y: self.size.height * 0.07, width: self.size.width * 0.80, height: self.size.height - self.size.height * 0.250))
        case "model3":
            return self.cropped(rect: CGRect(x: self.size.width * -0.13, y: self.size.height * 0.178, width: self.size.width * 0.72, height: self.size.height - self.size.height * 0.356))
        case "modelx":
            return self.cropped(rect: CGRect(x: self.size.width * -0.20, y: self.size.height * 0.18, width: self.size.width * 0.60, height: self.size.height - self.size.height * 0.400))
        case "modely":
            return self.cropped(rect: CGRect(x: self.size.width * -0.11, y: self.size.height * 0.107, width: self.size.width * 0.78, height: self.size.height - self.size.height * 0.213))
        default:
            return self
        }
    }

    func cropped(rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage else { return nil }

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()

        context?.translateBy(x: 0.0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.draw(cgImage, in: CGRect(x: rect.minX, y: rect.minY, width: self.size.width, height: self.size.height), byTiling: false)


        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return croppedImage
    }
}
