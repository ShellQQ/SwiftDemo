//
//  LaunchScreenViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/9.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var launchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        labelAnimation()
    }
    
    private func labelAnimation() {
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.launchLabel.transform = CGAffineTransform(rotationAngle: .pi)
                        self.launchLabel.transform = .identity
                        self.view.alpha = 0
        }) { (finished) in
            self.dismiss(animated: false)
            print("dissmiss")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
