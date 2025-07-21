//
//  TrayIcon.swift
//  tray_manager
//
//  Created by Lijy91 on 2022/5/15.
//

public class TrayIcon: NSView {
    public var onTrayIconMouseDown:(() -> Void)?
    public var onTrayIconMouseUp:(() -> Void)?
    public var onTrayIconRightMouseDown:(() -> Void)?
    public var onTrayIconRightMouseUp:(() -> Void)?
    
    var statusItem: NSStatusItem?
    
    public init() {
        super.init(frame: NSRect.zero)
        statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
        statusItem?.button?.addSubview(self)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame:frameRect);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(_ image: NSImage, _ imagePosition: String) {
        if let button = statusItem?.button {
            button.image = image
            setImagePosition(imagePosition)
        }


        self.frame = statusItem!.button!.frame
    }
    
    public func setImagePosition(_ imagePosition: String) {
        if let button = statusItem?.button {
            button.imagePosition = imagePosition == "right" ? NSControl.ImagePosition.imageRight : NSControl.ImagePosition.imageLeft
        }
        self.frame = statusItem!.button!.frame
    }
    
    public func removeImage() {
        statusItem?.button?.image = nil
        self.frame = statusItem!.button!.frame
    }
    
    public func setTitle(_ title: String) {
        if let button = statusItem?.button {
            button.title  = title
        }
        self.frame = statusItem!.button!.frame
    }
    
    public func setAttributedTitle(_ title: String, prefix: String?, prefixColor: String?) {
        if let button = statusItem?.button {
            let attributedString = NSMutableAttributedString()
            
            // Add colored prefix if provided
            if let prefix = prefix, let prefixColor = prefixColor {
                print("DEBUG: Trying to parse color: \(prefixColor)")
                let color = NSColor(hex: prefixColor) ?? NSColor.systemRed // Use red as obvious fallback
                print("DEBUG: Parsed color: \(color)")
                let prefixAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: color
                ]
                attributedString.append(NSAttributedString(
                    string: prefix + " ",
                    attributes: prefixAttributes
                ))
            }
            
            // Add main title with system label color
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: NSColor.labelColor
            ]
            attributedString.append(NSAttributedString(
                string: title,
                attributes: titleAttributes
            ))
            
            button.attributedTitle = attributedString
        }
        self.frame = statusItem!.button!.frame
    }
    
    public func setToolTip(_ toolTip: String) {
        if let button = statusItem?.button {
            button.toolTip  = toolTip
        }
    }
    
    public override func mouseDown(with event: NSEvent) {
        statusItem?.button?.highlight(true)
        self.onTrayIconMouseDown!()
    }
    
    public override func mouseUp(with event: NSEvent) {
        statusItem?.button?.highlight(false)
        self.onTrayIconMouseUp!()
    }
    
    public override func rightMouseDown(with event: NSEvent) {
        self.onTrayIconRightMouseDown!()
    }
    
    public override func rightMouseUp(with event: NSEvent) {
        self.onTrayIconRightMouseUp!()
    }
}

extension NSColor {
    convenience init?(hex: String) {
        let r, g, b: CGFloat
        
        let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
        let hexColor = String(hex[start...])
        
        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: 1.0)
                return
            }
        }
        
        return nil
    }
}
