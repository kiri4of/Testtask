import UIKit

enum Nunito {
    static func regular(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-Regular", size: size.adaptedFontSize)!
    }
    
    static func semiBold(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-SemiBold", size: size.adaptedFontSize)!
    }
}

enum NunitoSans {
    //fix fonts
    static func regular(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-Regular", size: size.adaptedFontSize)!
    }
    
    static func semiBold(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-SemiBold", size: size.adaptedFontSize)!
    }
}

enum AppFonts {
    // Nunito Fonts

    static let nunito20Regular = Nunito.regular(size: 20)
    static let nunito18Regular = Nunito.regular(size: 18)
    static let nunito16Regular = Nunito.regular(size: 16)
    static let nunito14Regular = Nunito.regular(size: 14)
    static let nunito12Regular = Nunito.regular(size: 12)
    static let nunito10Regular = Nunito.regular(size: 10)
    
    static let nunito20SemiBold = Nunito.semiBold(size: 20)
    static let nunito18SemiBold = Nunito.semiBold(size: 18)
    static let nunito16SemiBold = Nunito.semiBold(size: 16)
    static let nunito14SemiBold = Nunito.semiBold(size: 14)
    static let nunito12SemiBold = Nunito.semiBold(size: 12)
    static let nunito10SemiBold = Nunito.semiBold(size: 10)

    // Nunito Sans Fonts
    
    static let nunitoSans20Regular = NunitoSans.regular(size: 20)
    static let nunitoSans18Regular = NunitoSans.regular(size: 18)
    static let nunitoSans16Regular = NunitoSans.regular(size: 16)
    static let nunitoSans14Regular = NunitoSans.regular(size: 14)
    static let nunitoSans12Regular = NunitoSans.regular(size: 12)
    static let nunitoSans10Regular = NunitoSans.regular(size: 10)
    
    static let nunitoSans24SemiBold = NunitoSans.semiBold(size: 24)
    static let nunitoSans18SemiBold = NunitoSans.semiBold(size: 18)
    static let nunitoSans16SemiBold = NunitoSans.semiBold(size: 16)
    static let nunitoSans14SemiBold = NunitoSans.semiBold(size: 14)
    static let nunitoSans12SemiBold = NunitoSans.semiBold(size: 12)
    static let nunitoSans10SemiBold = NunitoSans.semiBold(size: 10)
}
