//
//  ViewController.swift
//  APMSample
//
//  Created by cook on 2024/9/25.
//

import UIKit
import APMHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


    @IBAction func clickSwitch(_ sender: UISwitch) {
        APMTool.shared.togglePMLabel(types: [.Memory, .CPU, .FPS])
    }
}

