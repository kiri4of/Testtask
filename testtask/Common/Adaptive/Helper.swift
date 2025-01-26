import UIKit
// Current dimension
var dimension: Dimension {
    UIDevice.current.orientation.isPortrait ? .width : .height
}

// adapt size to dimensions
func adapted(dimensionSize: CGFloat, to dimension: Dimension) -> CGFloat {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var ratio: CGFloat = 0.0
    var resultDimenstionSize: CGFloat = 0.0
    
    switch dimension {
    case .width:
        ratio = dimensionSize / Device.currentModel.rawValue.width
        resultDimenstionSize = screenWidth * ratio
    case .height:
        ratio = dimensionSize / Device.currentModel.rawValue.height
        resultDimenstionSize = screenHeight * ratio
    }
    
    return resultDimenstionSize
}
