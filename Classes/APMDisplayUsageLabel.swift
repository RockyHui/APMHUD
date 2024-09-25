//
//  APMDisplayUsageLabel.swift
//  
//
//  Created by cook on 2024/5/18.
//

import UIKit

class APMDisplayUsageLabel: UILabel {
    
    var type: PMToolLabelType = .cpuLabel

    init(type: PMToolLabelType, frame: CGRect) {
        super.init(frame: frame)
        self.type = type
        setupDefaultViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaultViews() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.textAlignment = .center
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
    }
    
    /// 刷新label的数值
    func refreshLabel(pValue: Float) {
        switch type {
        case .fpsLabel:
            attributedText = fpsAttributedString(with: pValue)
        case .memoryLabel:
            attributedText = memoryAttributedString(with: pValue)
        case .cpuLabel:
            attributedText = cpuAttributedString(with: pValue)
        }
    }

    private func fpsAttributedString(with fps: Float) -> NSAttributedString {
        let progress: Float = fps / 60.0
        let color = UIColor(hue: 0.27 * (CGFloat(progress) - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        let totalStr = "\(round(fps)) FPS"
        let len = totalStr.count
        let attStr = NSMutableAttributedString(string: totalStr)
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: len-3))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: len-3, length: 3))
        attStr.addAttribute(NSAttributedString.Key.font, value: APMTool.shared.config.valueFont, range: NSRange(location: 0, length: len-3))
        attStr.addAttribute(NSAttributedString.Key.font, value: APMTool.shared.config.unitFont, range: NSRange(location: len-3, length: 3))
        return attStr
    }
    
    private func memoryAttributedString(with memory: Float) -> NSAttributedString {
        let progress: Float = memory / 450.0
        let color = UIColor.getLabelColorByPercent(percent: progress)
        let totalStr = String(format: "%.1f M", memory)
        let len = totalStr.count
        let attStr = NSMutableAttributedString(string: totalStr)
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: len-1))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: len-1, length: 1))
        attStr.addAttribute(NSAttributedString.Key.font, value: APMTool.shared.config.valueFont, range: NSRange(location: 0, length: len-1))
        attStr.addAttribute(NSAttributedString.Key.font, value: APMTool.shared.config.unitFont, range: NSRange(location: len-1, length: 1))
        return attStr
    }
    
    private func cpuAttributedString(with cpu: Float) -> NSAttributedString {
        let progress: Float = cpu / 100.0
        let color = UIColor.getLabelColorByPercent(percent: progress)
        let totalStr = String(format: "%d%% CPU", Int(cpu))
        let len = totalStr.count
        let attStr = NSMutableAttributedString(string: totalStr)
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: len-3))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: len-3, length: 3))
        attStr.addAttribute(NSAttributedString.Key.font, value: APMTool.shared.config.valueFont, range: NSRange(location: 0, length: len-3))
        attStr.addAttribute(NSAttributedString.Key.font, value: APMTool.shared.config.unitFont, range: NSRange(location: len-3, length: 3))
        return attStr
    }
}
