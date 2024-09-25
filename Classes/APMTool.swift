//
//  APMTool.swift
//  
//
//  Created by cook on 2024/5/18.
//

import UIKit

public class APMTool: NSObject {
    
    /// 内存监控
    lazy private var memoryMonitor: APMMemoryMonitor = {
        let memoryMonitor = APMMemoryMonitor()
        memoryMonitor.monitorCallBack = { [weak self] memoryValue in
            self?.displayView.refreshLabel(type: .Memory, value: memoryValue)
        }
        return memoryMonitor
    }()
    
    /// CPU监控
    lazy private var cpuMonitor: APMCPUMonitor = {
        let cpuMonitor = APMCPUMonitor()
        cpuMonitor.monitorCallBack = { [weak self] cpuValue in
            self?.displayView.refreshLabel(type: .CPU, value: cpuValue)
        }
        return cpuMonitor
    }()
    
    /// 帧率监控
    lazy private var fpsMonitor: APMFrameRateMonitor = {
        let fpsMonitor = APMFrameRateMonitor()
        fpsMonitor.monitorCallBack = { [weak self] fpsValue in
            self?.displayView.refreshLabel(type: .FPS, value: fpsValue)
        }
        return fpsMonitor
    }()
    
    lazy var displayView: APMDisplayView = {
        let frame = CGRect(x: 0, y: 0, width: pmScreenWidth, height: pmLabelHeight)
        let displayView = APMDisplayView(frame: frame)
        displayView.frame = frame
        displayView.isUserInteractionEnabled = false
        displayView.backgroundColor = .clear
        return displayView
    }()
    
    lazy var displayVC: APMDisplayViewController = {
        let vc = APMDisplayViewController()
        vc.rotateCallBack = { [weak self] size in
            self?.displayView.handleRotate(size: size)
        }
        let frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        vc.view.frame = frame
        vc.view.isUserInteractionEnabled = false
        vc.view.backgroundColor = .clear
        return vc
    }()
    
    /// 显示UI配置
    public lazy var config: APMDisplayConfiguration = {
        return APMDisplayConfiguration()
    }()
    
    /// 单例对象
    public static let shared = APMTool()
    
    /// 当前性能悬浮标签是否展示出来
    private var isShowing = false
    
    public override init() {
        super.init()
    }
    
}

extension APMTool {
    
    /// 开启监控
    /// - Parameter types: 指定需要监控的指标
    public func startMointors(types: [PMToolType]) {
        for type in types {
            switch type {
            case .FPS:
                if !fpsMonitor.isRunning {
                    fpsMonitor.startMonitoring()
                }
            case .CPU:
                if !cpuMonitor.isRunning {
                    cpuMonitor.startMonitoring()
                }
            case .Memory:
                if !memoryMonitor.isRunning {
                    memoryMonitor.startMonitoring()
                }
            }
        }
    }
    
    /// 关闭监控
    /// - Parameter types: 指定需要关闭的指标
    public func stopMointors(types: [PMToolType]) {
        for type in types {
            switch type {
            case .FPS:
                if fpsMonitor.isRunning {
                    fpsMonitor.stopMonitoring()
                }
            case .CPU:
                if cpuMonitor.isRunning {
                    cpuMonitor.stopMonitoring()
                }
            case .Memory:
                if memoryMonitor.isRunning {
                    memoryMonitor.stopMonitoring()
                }
            }
        }
    }
}

extension APMTool {
    
    /// HUD标签的现实与隐藏
    /// - Parameter types: 需要显示的性能指标数组
    public func togglePMLabel(types: [PMToolType]) {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            print("Root ViewController is Nil❗️")
            return
        }
        if self.displayView.superview == nil {
            keyWindow.addSubview(self.displayView)
        }
        
        if isShowing {
            displayView.hidePMLabelsWithAnimation()
        } else {
            if self.displayVC.parent == nil {
                keyWindow.rootViewController?.addChild(self.displayVC)
            }
            displayView.showPMLabelWithAnimation(types: types)
        }
        isShowing = !isShowing
    }
}
