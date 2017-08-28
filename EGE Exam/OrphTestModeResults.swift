//
//  OrphTestModeResults.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 20.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

class OrphTestModeResults: UIViewController {
    
    
    @IBOutlet weak var rightWords: UILabel!
    @IBOutlet weak var wrongWords: UILabel!
    
    var rightRes = [String]()
    var wrongRes = [String]()
    
    override func viewDidLoad() {
        // print(rightRes.first)
        super.viewDidLoad()
        rightWords.text! += "Правильно: \n"
        wrongWords.text! += "Неправильно: \n"
        for word in rightRes {
            rightWords.text! += word
            rightWords.text! += "\n"
        }
        for word in wrongRes {
            wrongWords.text! += word
            wrongWords.text! += "\n"
        }
    }
    
    func setResults(right: [String], wrong: [String]) {
        rightRes = right
        wrongRes = wrong
    }
}

