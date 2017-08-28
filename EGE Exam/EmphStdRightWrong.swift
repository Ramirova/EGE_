//
//  EmphStdRightWrong.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 19.08.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

class EmphStdRightWrong: UIViewController {
    
    @IBOutlet weak var untapped: UILabel!
    @IBOutlet weak var tapped: UILabel!
    var bigWord = ""
    var smallWord = ""
    var ans = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapped.text! = bigWord
        untapped.text! = smallWord
        if ans {
            self.view.backgroundColor = UIColor.green
        } else {
            self.view.backgroundColor = UIColor.red
        }
        showGameView()
    }
    
    func setResults(tapped: String, untapped: String, right: Bool) {
        bigWord = tapped
        smallWord = untapped
        ans = right
    }
    
    func showGameView() {
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //Closing current view controller, by return to the one before it
            self.dismiss(animated: false, completion: nil)
        }
    }
}
