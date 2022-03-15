//
//  ViewController.swift
//  KurvX testground
//
//  Created by Trung Tran on 28.02.22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var navigationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        print("Navigation button" + sender.currentTitle!)
        
    }
    
}

