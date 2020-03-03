//
//  TextField.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

@IBDesignable
open class TextField: UITextField {
    
    // MARK: - Properties
    
    @IBInspectable
    public var underLineWidth: CGFloat = 1.0 {
        didSet {
            updateUnderLineFrame()
        }
    }
    
    @IBInspectable
    public var underLineColor: UIColor = .black {
        didSet {
            updateUnderLineUI()
        }
    }
    
    private lazy var underLine = CALayer()
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        applyUnderLine() 
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.borderStyle = .none
        applyUnderLine()
    }
    
    private func applyUnderLine() {
        underLine.removeFromSuperlayer()
        updateUnderLineFrame()
        updateUnderLineUI()
        layer.addSublayer(underLine)
        layer.masksToBounds = true
    }
    
    private func updateUnderLineFrame() {
        var rect = bounds
        rect.origin.y = bounds.height - underLineWidth
        rect.size.height = underLineWidth
        underLine.frame = rect
    }
    
    private func updateUnderLineUI() {
        underLine.backgroundColor = underLineColor.cgColor
    }
    
}
