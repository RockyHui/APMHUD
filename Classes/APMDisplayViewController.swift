//
//  APMDisplayViewController.swift
//  
//
//  Created by cook on 2024/5/18.
//

import UIKit

class APMDisplayViewController: UIViewController {
    
    var rotateCallBack: ((_ size: CGSize) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            //
        } completion: { [weak self] _ in
            self?.handleRotate(size: size)
        }
    }
    
    func handleRotate(size: CGSize) {
        rotateCallBack?(size)
    }

}
