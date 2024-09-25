//
//  APMFrameRateMonitor.swift
//  
//
//  Created by cook on 2024/5/18.
//

import Foundation

class APMFrameRateMonitor: APMBaseMonitor {

    private var displayLink: CADisplayLink?
    private var lastTimestamp: TimeInterval = 0
    private var performTimes: Int = 0
    
    override func startMonitoring() {
        guard displayLink == nil else {
            return
        }
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkTicks(link:)))
        displayLink?.add(to: RunLoop.current, forMode: .common)
        
        isRunning = true
    }
    
    override func stopMonitoring() {
        displayLink?.invalidate()
        displayLink = nil
        
        isRunning = false
    }
    
    @objc private func displayLinkTicks(link: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = link.timestamp
            return
        }
        performTimes += 1
        let interval = link.timestamp - lastTimestamp
        if interval < 1 {
            return
        }
        lastTimestamp = link.timestamp
        let avgfps = Double(performTimes)/interval
        performTimes = 0
        
        monitorCallBack?(Float(avgfps))
    }
    
}
