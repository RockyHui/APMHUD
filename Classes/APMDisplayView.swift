//
//  APMDisplayView.swift
//  APMHUD
//
//  Created by Hui Linchao on 2024/9/25.
//

import UIKit

public class APMDisplayView: UIView {
    
    lazy private var memoryLabel: APMDisplayUsageLabel = {
        let label = APMDisplayUsageLabel(type: .memoryLabel, frame: CGRect(x: 0, y: 0, width: pmLabelWidth, height: pmLabelHeight))
        return label
    }()

    lazy private var fpsLabel: APMDisplayUsageLabel = {
        let label = APMDisplayUsageLabel(type: .fpsLabel, frame: CGRect(x: 0, y: 0, width: pmLabelWidth, height: pmLabelHeight))
        return label
    }()
    
    lazy private var cpuLabel: APMDisplayUsageLabel = {
        let label = APMDisplayUsageLabel(type: .cpuLabel, frame: CGRect(x: 0, y: 0, width: pmLabelWidth, height: pmLabelHeight))
        return label
    }()
    
    /// 显示的悬浮标签
    private var displayLabels = [APMDisplayUsageLabel]()
    private var inAnimating = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !inAnimating {
            handleRotate()
        }
        
    }
    
    private func adjustSelfFrame() {
        guard let superview = self.superview else {
            return
        }
        let size = superview.bounds.size
        var frame = self.frame
        let w = size.width
        frame.size.width = w
        let offsetY = UIScreen.safeAreaInset.top
        frame.origin.y = offsetY < 1 ? 1 : offsetY
        self.frame = frame
    }
    
    private func handleRotate() {
        adjustSelfFrame()
        guard !displayLabels.isEmpty else { return }
        layoutLabels()
    }
    
}

extension APMDisplayView {
    
    /// 刷新HUD标签
    /// - Parameters:
    ///   - type: 需要刷新的指标
    ///   - value: 展示的数值
    func refreshLabel(type: PMToolType, value: Float) {
        switch type {
        case .FPS:
            fpsLabel.refreshLabel(pValue: value)
        case .CPU:
            cpuLabel.refreshLabel(pValue: value)
        case .Memory:
            memoryLabel.refreshLabel(pValue: value)
        }
    }
    
    /// 显示性能HUD标签
    /// - Parameter types: 需要显示的性能指标类型数组
    func showPMLabelWithAnimation(types: [PMToolType]) {
        clearUpLabels()
        setDebugWindow()
    
        for type in types {
            switch type {
            case .FPS:
                if !displayLabels.contains(fpsLabel) {
                    displayLabels.append(fpsLabel)
                }
            case .CPU:
                if !displayLabels.contains(cpuLabel) {
                    displayLabels.append(cpuLabel)
                }
            case .Memory:
                if !displayLabels.contains(memoryLabel) {
                    displayLabels.append(memoryLabel)
                }
            }
        }
        showConsoleLabel(labels: displayLabels)
        
        var offsetY = UIScreen.safeAreaInset.top
        offsetY = offsetY < 1 ? 1 : offsetY
        let topOffset: CGFloat = offsetY
        var frame = self.frame
        frame.origin.y = -frame.size.height
        self.frame = frame
        frame.origin.y = topOffset
        self.inAnimating = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.frame = frame
        } completion: { [weak self] _ in
            self?.inAnimating = false
        }
    }
    
    /// 隐藏性能HUD标签
    func hidePMLabelsWithAnimation() {
        var frame = self.frame
        frame.origin.y = -frame.size.height
        self.inAnimating = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.frame = frame
        } completion: { [weak self] _ in
            self?.clearUpLabels()
            self?.inAnimating = false
        }
    }
    
    /// 清除标签
    private func clearUpLabels() {
        cpuLabel.removeFromSuperview()
        memoryLabel.removeFromSuperview()
        fpsLabel.removeFromSuperview()
        
        displayLabels.removeAll()
    }
    
    func setDebugWindow() {
        guard self.superview == nil else {
            return
        }
        UIApplication.shared.keyWindow?.addSubview(self)
    }

    private func showConsoleLabel(labels: [APMDisplayUsageLabel]) {
        guard labels.count > 0 else {
            return
        }
        
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for oneLabel in labels {
            if oneLabel.superview == nil {
                self.addSubview(oneLabel)
            }
        }
        layoutLabels()
    }
    
    private func layoutLabels() {
        let subViews = self.subviews
        let labelCount = subViews.count
        let lrPadding = (self.frame.width - (CGFloat(labelCount) * pmLabelWidth ) - (CGFloat(labelCount - 1) * pmMargin)) / 2
        for (index, oneView) in subViews.enumerated() {
            var frame = oneView.frame
            frame.origin.y = 0
            frame.origin.x = lrPadding + (pmLabelWidth + pmMargin) * CGFloat(index)
            oneView.frame = frame
        }
    }
}
