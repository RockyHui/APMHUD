//
//  APMTool.swift
//  
//
//  Created by cook on 2024/5/18.
//

import UIKit

/// 标签类型
public enum PMToolLabelType: Int {
    case fpsLabel
    case memoryLabel
    case cpuLabel
}

/// 性能指标
public enum PMToolType: Int {
    case FPS    = 1
    case CPU    = 2
    case Memory = 3
}

let pmScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let pmScreenHeight: CGFloat = UIScreen.main.bounds.size.height
let pmLabelWidth: CGFloat = 60
let pmLabelHeight: CGFloat = 15
let pmMargin: CGFloat = 40

public typealias MemoryUsage = (used: UInt64, total: UInt64)

extension UIScreen {
    
    /// 屏幕显示安全区
    static var safeAreaInset: UIEdgeInsets {
        get {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        }
    }
}

extension UIColor {
    
    /// 根据占用的百分比来生成对应的色彩颜色
    /// - Parameter percent: 性能百分比
    /// - Returns: 对应的色彩值
    class func getLabelColorByPercent(percent: Float) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        let one: CGFloat = 255 + 255
        if (percent < 0.5) {
            r = one * CGFloat(percent)
            g = 255
        }
        if (percent >= 0.5) {
            g = 255 - ((CGFloat(percent) - 0.5 ) * one)
            r = 255
        }
        return UIColor(red: r/255.0, green: g/255.0, blue: 0, alpha: 1)
    }
}
