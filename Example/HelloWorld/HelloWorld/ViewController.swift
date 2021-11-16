//
//  ViewController.swift
//  HelloWorld
//
//  Created by Angel Cortez on 11/15/21.
//

import UIKit
import Drip

class ViewController: UIViewController {
    
    @Inject(MainComponent.instance.get("backgroundColor"))
    var color: UIColor?
    
    @Inject(MainComponent.instance.get("ranColor"))
    var getRanColor: () -> UIColor
    
    @Inject(MainComponent.instance.get("clientID"))
    var clientID: String
    
    @IBOutlet weak var masterLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = color ?? .white
    }

    @IBAction func didTapOnMasterButton(_ sender: Any) {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.masterLabel.text = self?.clientID
            self?.view.backgroundColor = self?.getRanColor()
        }

    }
    
}

