import Foundation

//List of devices size
enum Device {
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhone12Mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone13
    case iPhone13Pro
    case iPhone13ProMax
    case iPhone14
    case iPhone14Plus
    case iPhone14Pro
    case iPhone14ProMax
    case iPhone15
    case iPhone15Plus
    case iPhone15Pro
    case iPhone15ProMax
    case iPad9
    case iPad10
    case iPadAir5
    case iPadPro11_3rdGen
    case iPadPro12_9_6thGen

    static let currentModel: Device = .iPhone15
}

extension Device: RawRepresentable {
    typealias RawValue = CGSize

    init?(rawValue: CGSize) {
        switch rawValue {
        case CGSize(width: 414, height: 896):
            self = .iPhoneXR
        case CGSize(width: 414, height: 896):
            self = .iPhone11
        case CGSize(width: 375, height: 812):
            self = .iPhone11Pro
        case CGSize(width: 414, height: 896):
            self = .iPhone11ProMax
        case CGSize(width: 360, height: 780):
            self = .iPhone12Mini
        case CGSize(width: 390, height: 844):
            self = .iPhone12
        case CGSize(width: 390, height: 844):
            self = .iPhone12Pro
        case CGSize(width: 428, height: 926):
            self = .iPhone12ProMax
        case CGSize(width: 390, height: 844):
            self = .iPhone13
        case CGSize(width: 390, height: 844):
            self = .iPhone13Pro
        case CGSize(width: 428, height: 926):
            self = .iPhone13ProMax
        case CGSize(width: 393, height: 852):
            self = .iPhone14
        case CGSize(width: 430, height: 932):
            self = .iPhone14Plus
        case CGSize(width: 393, height: 852):
            self = .iPhone14Pro
        case CGSize(width: 430, height: 932):
            self = .iPhone14ProMax
        case CGSize(width: 393, height: 852):
            self = .iPhone15
        case CGSize(width: 430, height: 932):
            self = .iPhone15Plus
        case CGSize(width: 393, height: 852):
            self = .iPhone15Pro
        case CGSize(width: 430, height: 932):
            self = .iPhone15ProMax
        case CGSize(width: 810, height: 1080):
            self = .iPad9
        case CGSize(width: 820, height: 1180):
            self = .iPad10
        case CGSize(width: 820, height: 1180):
            self = .iPadAir5
        case CGSize(width: 834, height: 1194):
            self = .iPadPro11_3rdGen
        case CGSize(width: 1024, height: 1366):
            self = .iPadPro12_9_6thGen
        default:
            return nil
        }
    }

    var rawValue: CGSize {
        switch self {
        case .iPhoneXR:
            return CGSize(width: 414, height: 896)
        case .iPhone11:
            return CGSize(width: 414, height: 896)
        case .iPhone11Pro:
            return CGSize(width: 375, height: 812)
        case .iPhone11ProMax:
            return CGSize(width: 414, height: 896)
        case .iPhone12Mini:
            return CGSize(width: 360, height: 780)
        case .iPhone12:
            return CGSize(width: 390, height: 844)
        case .iPhone12Pro:
            return CGSize(width: 390, height: 844)
        case .iPhone12ProMax:
            return CGSize(width: 428, height: 926)
        case .iPhone13:
            return CGSize(width: 390, height: 844)
        case .iPhone13Pro:
            return CGSize(width: 390, height: 844)
        case .iPhone13ProMax:
            return CGSize(width: 428, height: 926)
        case .iPhone14:
            return CGSize(width: 393, height: 852)
        case .iPhone14Plus:
            return CGSize(width: 430, height: 932)
        case .iPhone14Pro:
            return CGSize(width: 393, height: 852)
        case .iPhone14ProMax:
            return CGSize(width: 430, height: 932)
        case .iPhone15:
            return CGSize(width: 393, height: 852)
        case .iPhone15Plus:
            return CGSize(width: 430, height: 932)
        case .iPhone15Pro:
            return CGSize(width: 393, height: 852)
        case .iPhone15ProMax:
            return CGSize(width: 430, height: 932)
        case .iPad9:
            return CGSize(width: 810, height: 1080)
        case .iPad10:
            return CGSize(width: 820, height: 1180)
        case .iPadAir5:
            return CGSize(width: 820, height: 1180)
        case .iPadPro11_3rdGen:
            return CGSize(width: 834, height: 1194)
        case .iPadPro12_9_6thGen:
            return CGSize(width: 1024, height: 1366)
        }
    }
}
