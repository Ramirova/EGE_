//
//  УдаренияОбычный.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 17.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class EmphStdMode: UIViewController {
    
    @IBOutlet weak var word1: UIButton!
    @IBOutlet weak var word2: UIButton!
    @IBOutlet weak var counter: UILabel!
    
    let totalNumberOfQuestions = 10
    
    var rightWords = [String]()
    var wrongWords = [String]()
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
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let db = try Connection("\(path)/EGE_DB.sqlite3")
            
            let accents = Table("Accent_Words")
            let right = Expression<String>("right_word")
            let wrong = Expression<String>("wrong_word")
            let wordId = Expression<Int>("word_id")
            
            let totalWordInTable: Int = try db.scalar(accents.count)
            
            for _ in 0...totalNumberOfQuestions - 1 {
                let wordNumber = Int(arc4random_uniform(UInt32(totalWordInTable)))
                rightWords.append(try db.pluck(accents.filter(wordId == (wordNumber % totalWordInTable) + 1))![right])
                wrongWords.append(try db.pluck(accents.filter(wordId == (wordNumber % totalWordInTable) + 1))![wrong])
            }
        } catch {
            print("Error while connection to Database and reading words")
        }
        nextWord()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    @IBAction func word1Tapped(_ sender: Any) {
        if randIndex == 0 {
            //первое слово нажато правильно
            self.view.backgroundColor = UIColor.green
            answer = true
            rightResults.append(word1.currentTitle!)
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
            self.view.backgroundColor = UIColor.red
            answer = false
            wrongResults.append(word2.currentTitle!)
        }
        wordTapped = word2.currentTitle!
        wordUntapped = word1.currentTitle!
        nextWord()
    }
   
    func nextWord() {
        totalCount += 1
        counter.text = String(rightCount) + "/" + String(totalNumberOfQuestions)
        
        //Перейти к экрану eightWrong
        if totalCount > totalNumberOfQuestions {
            performSegue(withIdentifier: "EmphToResults", sender: nil)
        }
        performSegue(withIdentifier: "EmphStdRightWrong", sender: nil)
        
        randIndex = Int(arc4random()) % 2
        if randIndex == 0 {
            word1.setTitle(rightWords[n], for: .normal)
            word2.setTitle(wrongWords[n], for: .normal)
        } else {
            word2.setTitle(rightWords[n], for: .normal)
            word1.setTitle(wrongWords[n], for: .normal)
        }
        n = (n + 1) % totalNumberOfQuestions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmphToResults" {
            let results = segue.destination as! EmphStdModeResults
            results.setResults(right: rightResults, wrong: wrongResults)
        }
        if segue.identifier == "EmphStdRightWrong" {
            let results = segue.destination as! EmphStdRightWrong
            results.setResults(tapped: wordTapped, untapped: wordUntapped, right: answer)
        }
    }

}
