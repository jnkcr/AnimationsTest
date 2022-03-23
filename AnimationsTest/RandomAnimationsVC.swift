//
//  RandomAnimationsVC.swift
//  AnimationsTest
//
//  Created by Jan Kučera on 23.03.2022.
//

import UIKit

class RandomAnimationsVC: UIViewController {
    
    let slidingView: UIView = {
        let v: UIView = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemMint
        v.layer.cornerRadius = 3
        return v
    }()
    let fingerprintImageView: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "fingerprint")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    let bouncingView: UIView = {
        let v: UIView = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemMint
        v.isUserInteractionEnabled = true
        return v
    }()
    let simpleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Touch me if you dare.."
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Random"
        // Subviews
        view.addSubview(slidingView)
        view.addSubview(fingerprintImageView)
        view.addSubview(simpleLabel)
        view.addSubview(bouncingView)
        // Targets
        fingerprintImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startFingerprintAnimation)))
        bouncingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bounceThatThing)))
        // UI Config
        NSLayoutConstraint.activate([
            // Sliding thing
            slidingView.widthAnchor.constraint(equalToConstant: 40),
            slidingView.heightAnchor.constraint(equalToConstant: 6),
            slidingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            slidingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Fingerprint
            fingerprintImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fingerprintImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Label
            simpleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simpleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            // Cube
            bouncingView.widthAnchor.constraint(equalToConstant: 40),
            bouncingView.heightAnchor.constraint(equalToConstant: 40),
            bouncingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bouncingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slideThatThing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}

extension RandomAnimationsVC {
    
    @objc func slideThatThing() {
        print("Sliding sequence initiated..")
        UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: [.calculationModeCubic, .repeat, .autoreverse, .layoutSubviews]) { [weak self] in
            guard let self = self else { return }
            UIView.addKeyframe(withRelativeStartTime: 0.00, relativeDuration: 0.25) {
                self.slidingView.transform = CGAffineTransform(translationX: -100, y: 0).scaledBy(x: 0.5, y: 1.0)
                self.slidingView.layer.opacity = 0.6
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.50) {
                self.slidingView.transform = CGAffineTransform(translationX: 100, y: 0).scaledBy(x: 0.5, y: 1.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.slidingView.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 1.0, y: 1.0)
                self.slidingView.layer.opacity = 1.0
            }
        }
    }
    
    @objc func startFingerprintAnimation() {
        print("Finger tapped")
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.fingerprintImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).rotated(by: 0.4)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.fingerprintImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0).rotated(by: 0)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func bounceThatThing() {
        print("Bouncing sequence initiated..")
        
        let totalDuration: TimeInterval = 5
        let relDuration: TimeInterval = 1 / 14
        let horizontalShift: CGFloat = 100 / 3
        let verticalShift: CGFloat = 70
        let cRadius: CGFloat = bouncingView.frame.height / 2
        
        UIView.animateKeyframes(withDuration: totalDuration, delay: 0, options: [.calculationModeCubic, .layoutSubviews]) { [weak self] in
            guard let self = self else { return }
            // 1
            UIView.addKeyframe(withRelativeStartTime: 0 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 1 * -horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .systemBrown
            }
            // 2
            UIView.addKeyframe(withRelativeStartTime: 1 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 2 * -horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemRed
            }
            // 3
            UIView.addKeyframe(withRelativeStartTime: 2 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 3 * -horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .systemBlue
            }
            // 4
            UIView.addKeyframe(withRelativeStartTime: 3 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 3 * -horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemCyan
            }
            // 5
            UIView.addKeyframe(withRelativeStartTime: 4 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 2 * -horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .systemGray
            }
            // 6
            UIView.addKeyframe(withRelativeStartTime: 5 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 1 * -horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemPink
            }
            // 7
            UIView.addKeyframe(withRelativeStartTime: 6 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 0 * horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .systemTeal
            }
            // 8
            UIView.addKeyframe(withRelativeStartTime: 7 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 1 * horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemGreen
            }
            // 9
            UIView.addKeyframe(withRelativeStartTime: 8 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 2 * horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .systemIndigo
            }
            // 10
            UIView.addKeyframe(withRelativeStartTime: 9 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 3 * horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemOrange
            }
            // 11
            UIView.addKeyframe(withRelativeStartTime: 10 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 3 * horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .systemYellow
            }
            // 12
            UIView.addKeyframe(withRelativeStartTime: 11 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 2 * horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemPurple
            }
            // 13
            UIView.addKeyframe(withRelativeStartTime: 12 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 1 * horizontalShift, y: verticalShift)
                self.bouncingView.layer.cornerRadius = cRadius
                self.bouncingView.backgroundColor = .label
            }
            // 14
            UIView.addKeyframe(withRelativeStartTime: 13 * relDuration, relativeDuration: relDuration) {
                self.bouncingView.transform = CGAffineTransform(translationX: 0 * horizontalShift, y: 0)
                self.bouncingView.layer.cornerRadius = 0
                self.bouncingView.backgroundColor = .systemMint
            }
        }
    }
    
}
