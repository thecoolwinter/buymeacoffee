//
//  BMCButton.swift
//
//  Created by François Boulais on 26/06/2020.
//  Copyright © 2020 App Craft Studio. All rights reserved.
//

#if !os(macOS)
import UIKit
#endif

@IBDesignable
public class BMCButton: UIButton {
    public struct Configuration {
        let color: BMCColor
        let font: BMCFont
        let title: String
        
        public init(color: BMCColor, font: BMCFont, title: String = "Buy me a coffee") {
            self.color = color
            self.font = font
            self.title = title
        }
        
        public static let `default`: Self = .init(color: .default, font: .default)
    }
    
    public var configuration: Configuration = .default {
        didSet {
            configure(with: configuration)
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.85 : 1
        }
    }
    
    convenience init(configuration: Configuration) {
        self.init(type: .custom)
        
        self.configuration = configuration
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: - Interface Builder
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    // MARK: - Private functions
    
    private func setup() {
        layer.shadowOffset = .init(width: 4, height: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2
        layer.cornerRadius = 5

        contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        titleEdgeInsets = .init(top: 0, left: 6, bottom: 0, right: -6)
        imageEdgeInsets = .init(top: 0, left: -6, bottom: 0, right: 6)
        
        imageView?.contentMode = .scaleAspectFit
        let image = UIImage(named: "cup", in: .module, compatibleWith: nil)
        setImage(image, for: .normal)
        
        registerFonts()
        
        adjustsImageWhenHighlighted = false
        
        addTarget(BMCManager.shared, action: #selector(BMCManager.shared.start), for: .touchUpInside)
        
        configure(with: configuration)
    }
    
    private func configure(with configuration: Configuration) {
        titleLabel?.font = configuration.font.value
        setTitle(configuration.title, for: .normal)
        setTitleColor(configuration.color.title, for: .normal)
        backgroundColor = configuration.color.background
    }
    
    private func registerFonts() {
        if let url = Bundle.module.url(forResource: "Cookie-Regular", withExtension: "ttf") {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
        
        if let url = Bundle.module.url(forResource: "Lato-Regular", withExtension: "ttf") {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
