//
//  OrphTestMode.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 20.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class OrphTestMode: UIViewController {
    
    @IBOutlet weak var word1: UIButton!
    @IBOutlet weak var word2: UIButton!
    @IBOutlet weak var word3: UIButton!
    @IBOutlet weak var word4: UIButton!
    @IBOutlet weak var word5: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let db = try Connection("\(path)/EGE_DB.sqlite3")
            
            let grammar = Table("Grammar_Words")
            let startPartColumn = Expression<String>("start_part_word")
            let endPartColumn = Expression<String>("end_part_word")
            let rightLetterColumn = Expression<String>("right_letter")
            let wordId = Expression<Int>("word_id")
            
            let totalWordInTable: Int = try db.scalar(grammar.count)
            
            for _ in 0...totalNumberOfQuestions * 6 {
                let wordNumber = Int(arc4random_uniform(UInt32(totalWordInTable)))
                let startPart = try db.pluck(grammar.filter(wordId == (wordNumber % totalWordInTable) + 1))![startPartColumn]
                let endPart = try db.pluck(grammar.filter(wordId == (wordNumber % totalWordInTable) + 1))![endPartColumn]
                let rightLetter = try db.pluck(grammar.filter(wordId == (wordNumber % totalWordInTable) + 1))![rightLetterColumn]
                var wrongLetter = ""
                
                switch rightLetter {
                case "а":
                    wrongLetter = "о"
                case "о":
                    wrongLetter = "а"
                case "и":
                    wrongLetter = "е"
                case "е":
                    wrongLetter = "и"
                case "ы":
                    wrongLetter = "и"
                default:
                    wrongLetter = ""
                }
                rightWords.append(startPart + rightLetter + endPart)
                wrongWords.append(startPart + wrongLetter + endPart)
            }
        } catch {
            print("Error while connection to Database and reading words")
        }
        print(rightWords)
        print(wrongWords)
    
        
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
            rightResults.append(word2.currentTitle!)
            rightCount += 1
        } else if randIndex != 1 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word2.currentTitle!)
        }
        nextWord()
    }
    
    

    @IBAction func word3Tapped(_ sender: Any) {
        if randIndex == 2 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word3.currentTitle!)
            rightCount += 1
        } else if randIndex != 2 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word3.currentTitle!)
        }
        nextWord()
    }
    
    

    @IBAction func word4Tapped(_ sender: Any) {
        if randIndex == 3 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word4.currentTitle!)
            rightCount += 1
        } else if randIndex != 3 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word4.currentTitle!)
        }
        nextWord()
    }
    
    

    @IBAction func word5Tapped(_ sender: Any) {
        if randIndex == 4 {
            //слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word5.currentTitle!)
            rightCount += 1
        } else if randIndex != 4 {
            //слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word5.currentTitle!)
        }
        nextWord()
    }
    
    func nextWord() {
        totalCount += 1
        if totalCount > totalNumberOfQuestions {
            performSegue(withIdentifier: "OrphTestToResults", sender: nil)
        }
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
        n += 5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrphTestToResults" {
            let results = segue.destination as! OrphTestModeResults
            results.setResults(right: rightResults, wrong: wrongResults)
        }
    }

}
