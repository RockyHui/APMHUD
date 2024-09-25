//
//  APMBaseMonitor.swift
//  
//
//  Created by cook on 2024/5/18.
//

import Foundation

class APMBaseMonitor: NSObject {
    
    private var timer: Timer?
    var isRunning = false
    
    var monitorCallBack: ((_ pValue: Float) -> Void)?
    
    func startMonitoring() {
        stopMonitoring()
        timer = Timer(timeInterval: 1, target: self, selector: #selector(refreshMonitorValue), userInfo: nil, repeats: true)
        timer?.fire()
        RunLoop.current.add(timer!, forMode: .common)
        
        isRunning = true
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
        
        isRunning = false
    }
    
    func getCurrentMonitorValue() -> Float {
        return 0
    }
    
    @objc private func refreshMonitorValue() {
        monitorCallBack?(getCurrentMonitorValue())
    }
    
}
