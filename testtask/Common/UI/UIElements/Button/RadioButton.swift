import UIKit

class RadioButton: UIButton {
    
    private let circleSize: CGFloat = 14 // outside circle
    private let innerCircleSize: CGFloat = 6 //inside
    private let circleOffset: CGFloat = 10
    
    private let selectedOuterCircleColor: UIColor = AppColors.tabBarTintColor
    private let unselectedOuterCircleColor: UIColor = UIColor.lightGray
    private let innerCircleColor: UIColor = .white
    private let backgroundCircleColor: UIColor = UIColor.white

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .left
        titleLabel?.font = AppFonts.nunito14Regular
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        // offset for circle
        let circleX = circleOffset
        let circleY = (bounds.height - circleSize) / 2
        
        // circle outside
        let outerCircleRect = CGRect(x: circleX, y: circleY, width: circleSize, height: circleSize)
        context?.setFillColor((isSelected ? selectedOuterCircleColor : unselectedOuterCircleColor).cgColor)
        context?.fillEllipse(in: outerCircleRect)
        
        //bg indise circle
        if !isSelected {
            let innerBackgroundCircleRect = outerCircleRect.insetBy(dx: 1, dy: 1)
            context?.setFillColor(backgroundCircleColor.cgColor)
            context?.fillEllipse(in: innerBackgroundCircleRect)
        }
        
        // draw circle insisde if selected
        if isSelected {
            let innerCircleRect = CGRect(
                x: circleX + (circleSize - innerCircleSize) / 2,
                y: circleY + (circleSize - innerCircleSize) / 2,
                width: innerCircleSize,
                height: innerCircleSize
            )
            context?.setFillColor(innerCircleColor.cgColor)
            context?.fillEllipse(in: innerCircleRect)
        }
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: circleOffset + circleSize + 16, bottom: 0, right: 0)
    }
    
    override var isSelected: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
}
