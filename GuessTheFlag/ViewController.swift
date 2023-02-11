//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Regina Mayorova on 06.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var flagToFind = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        askQuestion(action: nil)
        
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        flagToFind = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = (countries[flagToFind].uppercased() + " CURRENT SCORE \(score)")
      
    }
    
    
    @IBAction func buttonTaped(_ sender: UIButton) {
        
        var title: String
        if sender.tag == flagToFind {
            title = "Correct!"
            score += 1
        } else {
            title = """
    Oh no! You're wrong.
    You've chosen
    \(countries[sender.tag].uppercased())
    """
            score -= 1
        }
        
        questionsAsked += 1
        let ac1 = UIAlertController(title: title, message: "Ten questions have been asked! Your final score is \(score)", preferredStyle: .alert)
        if questionsAsked == 10 {
            present (ac1, animated: true)
            score = 0
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    @objc func showScore() {
        let message = UIAlertController(title: "Your current score is", message: "\(score)", preferredStyle: .alert)
       present(message, animated: true)
     }
}

