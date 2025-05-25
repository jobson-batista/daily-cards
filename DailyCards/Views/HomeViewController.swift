//
//  ViewController.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    public var coordinator: AppCoordinator?
    var isFlipped = false
    
    public lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    public lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Daily Cards"
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    public lazy var cardView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    public lazy var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O que é Swift?"
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        return label
    }()
    
    public lazy var answerLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uma linguagem de programação"
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        label.isHidden = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    public lazy var buttonAnswer: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Mostrar Resposta", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }()
    
    public lazy var buttonNextCard: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Próximo Card", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Rodando...")
        view.backgroundColor = .systemBackground
        
        setupHierarchy()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                 
            questionLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            questionLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            answerLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            answerLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            answerLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            buttonAnswer.heightAnchor.constraint(equalToConstant: 50),
            buttonNextCard.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    func setupHierarchy() {
        cardView.addSubview(questionLabel)
        cardView.addSubview(answerLabel)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(cardView)
        stackView.addArrangedSubview(buttonAnswer)
        stackView.addArrangedSubview(buttonNextCard)
        
        view.addSubview(stackView)
    }
    
    @objc func flipCard() {
        let fromView = isFlipped ? answerLabel : questionLabel
        let toView = isFlipped ? questionLabel : answerLabel
            
        let options: UIView.AnimationOptions = isFlipped ? .transitionFlipFromLeft : .transitionFlipFromRight
//        let options: UIView.AnimationOptions = isFlipped ? .transitionCurlDown : .transitionCurlUp
            
        UIView.transition(from: fromView, to: toView, duration: 0.8, options: [options, .showHideTransitionViews], completion: nil)
            
        isFlipped.toggle()
    }
    
    @objc func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.6
        }
    }

    @objc func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 1.0
        }
    }

}

