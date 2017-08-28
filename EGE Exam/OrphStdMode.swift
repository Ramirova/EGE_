//
//  OrphStdMode.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 20.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

class OrphStdMode: UIViewController {
    
    @IBOutlet weak var word1: UIButton!
    @IBOutlet weak var word2: UIButton!
    
    @IBOutlet weak var counter: UILabel!
    
    let rightWords = ["звонИт", "баловАть", "красИвее", "правильное1", "правильное2", "правильное3", "правильное4"]
    let wrongWords = ["звОнит", "бАловать", "красивЕе", "неправильное1", "неправильное2", "неправильное3", "неправильное4"]
    //    var lineFields = [String]()
    var rightResults = [String]()
    var wrongResults = [String]()
    
    var n = 0
    var randIndex = 0
    var rightCount = 0
    var totalCount = 0
    var wordTapped = ""
    var wordUntapped = ""
    var answer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextWord()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func word1Tapped(_ sender: Any) {
        if randIndex == 0 {
            //первое слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            answer = true
            rightCount += 1
        } else if randIndex == 1 {
            //первое слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            answer = false
            wrongResults.append(word1.currentTitle!)
        }
        wordTapped = word1.currentTitle!
        wordUntapped = word2.currentTitle!
        nextWord()
    }
    
    @IBAction func word2Tapped(_ sender: Any) {
        if randIndex == 1 {
            //второе слово нажато правильно
            self.view.backgroundColor = UIColor.green
            answer = true
            rightResults.append(word2.currentTitle!)
            rightCount += 1
        } else if randIndex == 0 {
            //второе слово нажато неправильно
            answer = false
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word2.currentTitle!)
        }
        wordTapped = word2.currentTitle!
        wordUntapped = word1.currentTitle!
        nextWord()
    }
    
    func nextWord() {
        totalCount += 1
        counter.text = String(rightCount)
        if totalCount > 5 {
            performSegue(withIdentifier: "OrphToResults", sender: nil)
        }
        performSegue(withIdentifier: "OrphStdRightWrong", sender: nil)

        randIndex = Int(arc4random()) % 2
        if randIndex == 0 {
            word1.setTitle(rightWords[n], for: .normal)
            word2.setTitle(wrongWords[n], for: .normal)
        } else {
            word2.setTitle(rightWords[n], for: .normal)
            word1.setTitle(wrongWords[n], for: .normal)
        }
        n = (n + 1) % 3
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrphToResults" {
            let results = segue.destination as! OrphStdModeResults
            results.setResults(right: rightResults, wrong: wrongResults)
        }
        if segue.identifier == "OrphStdRightWrong" {
            let results = segue.destination as! OrphStdRightWrong
            results.setResults(tapped: wordTapped, untapped: wordUntapped, right: answer)
        }
    }
    
}

