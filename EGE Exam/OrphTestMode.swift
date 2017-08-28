//
//  OrphTestMode.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 20.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

class OrphTestMode: UIViewController {
    
    @IBOutlet weak var word1: UIButton!
    @IBOutlet weak var word2: UIButton!
    @IBOutlet weak var word3: UIButton!
    @IBOutlet weak var word4: UIButton!
    @IBOutlet weak var word5: UIButton!
    @IBOutlet weak var counter: UILabel!
    
    
    
    
    let rightWords = ["звонИт", "баловАть", "красИвее", "правильное1", "правильное2", "правильное3", "правильное4"]
    let wrongWords = ["звОнит", "бАловать", "красивЕе", "неправильное1", "неправильное2", "неправильное3", "неправильное4"]
    
    var rightResults = [String]()
    var wrongResults = [String]()
    
    var n = 0
    var randIndex = 0
    var rightCount = 0
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextWord()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func word1Tapped(_ sender: Any) {
        if randIndex == 0 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            rightCount += 1
        } else if randIndex != 0 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word1.currentTitle!)
        }
        nextWord()
    }
    
    
    
    
    @IBAction func word2Tapped(_ sender: Any) {
        if randIndex == 1 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            rightCount += 1
        } else if randIndex != 1 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word1.currentTitle!)
        }
        nextWord()
    }
    
    

    @IBAction func word3Tapped(_ sender: Any) {
        if randIndex == 2 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            rightCount += 1
        } else if randIndex != 2 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word1.currentTitle!)
        }
        nextWord()
    }
    
    

    @IBAction func word4Tapped(_ sender: Any) {
        if randIndex == 3 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            rightCount += 1
        } else if randIndex != 3 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word1.currentTitle!)
        }
        nextWord()
    }
    
    

    @IBAction func word5Tapped(_ sender: Any) {
        if randIndex == 4 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            rightCount += 1
        } else if randIndex != 4 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word1.currentTitle!)
        }
        nextWord()
    }
    
    func nextWord() {
        totalCount += 1
        counter.text = String(rightCount)
        randIndex = Int(arc4random()) % 6
        if randIndex == 0 {
            word1.setTitle(rightWords[n], for: .normal)
            word2.setTitle(wrongWords[n+1], for: .normal)
            word3.setTitle(wrongWords[n+2], for: .normal)
            word4.setTitle(wrongWords[n+3], for: .normal)
            word5.setTitle(wrongWords[n+4], for: .normal)
        }
        if randIndex == 1 {
            word1.setTitle(wrongWords[n], for: .normal)
            word2.setTitle(rightWords[n+1], for: .normal)
            word3.setTitle(wrongWords[n+2], for: .normal)
            word4.setTitle(wrongWords[n+3], for: .normal)
            word5.setTitle(wrongWords[n+4], for: .normal)
        }
        if randIndex == 2 {
            word1.setTitle(wrongWords[n], for: .normal)
            word2.setTitle(wrongWords[n+1], for: .normal)
            word3.setTitle(rightWords[n+2], for: .normal)
            word4.setTitle(wrongWords[n+3], for: .normal)
            word5.setTitle(wrongWords[n+4], for: .normal)
        }
        if randIndex == 3 {
            word1.setTitle(wrongWords[n], for: .normal)
            word2.setTitle(wrongWords[n+1], for: .normal)
            word3.setTitle(wrongWords[n+2], for: .normal)
            word4.setTitle(rightWords[n+3], for: .normal)
            word5.setTitle(wrongWords[n+4], for: .normal)
        }
        if randIndex == 4 {
            word1.setTitle(wrongWords[n], for: .normal)
            word2.setTitle(wrongWords[n+1], for: .normal)
            word3.setTitle(wrongWords[n+2], for: .normal)
            word4.setTitle(wrongWords[n+3], for: .normal)
            word5.setTitle(rightWords[n+4], for: .normal)
        }
        n = (n + 1) % 3
        if totalCount > 5 {
            performSegue(withIdentifier: "OrphTestToResults", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrphTestToResults" {
            let results = segue.destination as! OrphTestModeResults
            results.setResults(right: rightResults, wrong: wrongResults)
        }
    }

}
