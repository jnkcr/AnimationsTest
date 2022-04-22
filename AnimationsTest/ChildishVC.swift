//
//  ChildishVC.swift
//  AnimationsTest
//
//  Created by Jan Kučera on 30.03.2022.
//

import UIKit

final class ChildishVC: UIViewController {
    
    let box: UIView = {
        let v: UIView = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemMint
        return v
    }()
    let slider: UISlider = {
        let sl: UISlider = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        return sl
    }()
    let stack: UIStackView = {
        let stc: UIStackView = UIStackView()
        stc.translatesAutoresizingMaskIntoConstraints = false
        stc.axis = .vertical
        stc.spacing = 20
        return stc
    }()
    
    lazy var propAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [weak self] in
        self?.box.layer.cornerRadius = (self?.box.frame.height ?? 0) / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Subviews
        stack.addArrangedSubview(box)
        stack.addArrangedSubview(slider)
        view.addSubview(stack)
        // Targets
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        // UI Config
        NSLayoutConstraint.activate([
            box.widthAnchor.constraint(equalToConstant: 180),
            box.heightAnchor.constraint(equalTo: box.widthAnchor),
            slider.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

extension ChildishVC {
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        propAnimator.fractionComplete = CGFloat(sender.value)
    }
    
}
