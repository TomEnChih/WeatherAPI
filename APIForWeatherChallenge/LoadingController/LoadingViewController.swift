//
//  LoadingViewController.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/3/3.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    let loadingView = AnimationView(name: "loadingCat")
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel Loading", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    func cancelLabelConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: loadingView.bottomAnchor,constant: 10).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    @objc func cancelAction(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        loadingView.translatesAutoresizingMaskIntoConstraints = false
        //        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //        loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //        loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        loadingView.center = self.view.center
        loadingView.animationSpeed = 2
        loadingView.contentMode = .scaleAspectFill
        loadingView.loopMode = .autoReverse
        view.backgroundColor = UIColor(displayP3Red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
        view.addSubview(loadingView)
        view.addSubview(cancelButton)
        cancelLabelConstraints()
        loadingView.play()
        let timeBack = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cancelAction(sender:)), userInfo: nil, repeats: false)
    }
    
    
    
    
}
