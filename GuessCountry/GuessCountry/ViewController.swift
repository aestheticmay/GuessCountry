//
//  ViewController.swift
//  GuessCountry
//
//  Created by Майя Калицева on 15.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Public Properties

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    // MARK: - Private Properties

    private var countries = [String]()
    private var score = 0
    private var correctAnswer = 0
    private var totalTaps = 0
    
    // MARK: - Life-Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCountriesArray()
    }
    
    // MARK: - Private Methods
    
    private func setupCountriesArray() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }
    
    private func setupUI() {
        firstButton.layer.borderWidth = 1
        secondButton.layer.borderWidth = 1
        thirdButton.layer.borderWidth = 1
        
        firstButton.layer.borderColor = UIColor.lightGray.cgColor
        secondButton.layer.borderColor = UIColor.lightGray.cgColor
        thirdButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        firstButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func onButtonTap(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            totalTaps += 1
        } else {
            title = "Wrong"
            score -= 1
            totalTaps += 1
        }
        setupAlertController()
    }
    
    private func setupAlertController() {
        if totalTaps <= 9 {
        title = String("Your total score is \(totalTaps)")
        let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true)
        } else {
            let totalAlertController = UIAlertController(title: "Congratulations!", message: "Your score is \(score)", preferredStyle: .alert)
            totalAlertController.addAction(UIAlertAction(title: "Game over", style: .default, handler: askQuestion))
                present(totalAlertController, animated: true)
            score = 0
            totalTaps = 0
            correctAnswer = 0
        }
    }
}

