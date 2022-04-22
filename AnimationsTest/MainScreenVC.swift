//
//  MainScreenVC.swift
//  AnimationsTest
//
//  Created by Jan Kučera on 16.03.2022.
//

import UIKit

final class MainScreenVC: UIViewController {
    
    var isExtended: Bool = false
    let childishVC = ChildishVC()
    
    let bottomView: UIView = {
        let v: UIView = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemMint
        return v
    }()
    // Album and time
    let albumImageView: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    let songTime: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2:27"
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .natural
        label.textColor = .label
        return label
    }()
    let albumStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    // Playback and titles
    let backButton: UIImageView = {
        let bb: UIImageView = UIImageView()
        bb.translatesAutoresizingMaskIntoConstraints = false
        bb.image = UIImage(systemName: "backward.fill")
        bb.contentMode = .scaleAspectFit
        bb.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20)
        bb.tintColor = .label
        return bb
    }()
    let playButton: UIImageView = {
        let bb: UIImageView = UIImageView()
        bb.translatesAutoresizingMaskIntoConstraints = false
        bb.image = UIImage(systemName: "play.fill")
        bb.contentMode = .scaleAspectFit
        bb.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30)
        bb.tintColor = .label
        return bb
    }()
    let forwardButton: UIImageView = {
        let bb: UIImageView = UIImageView()
        bb.translatesAutoresizingMaskIntoConstraints = false
        bb.image = UIImage(systemName: "forward.fill")
        bb.contentMode = .scaleAspectFit
        bb.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20)
        bb.tintColor = .label
        return bb
    }()
    let songTitle: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hybrid Theory - Forgotten"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .right
        label.textColor = .label
        return label
    }()
    let songSubtitle: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "©2000, Warner Records Inc."
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        return label
    }()
    let playbackControlsStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    let songTitlesStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    let playbackStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.spacing = 20
        return stack
    }()
    // Next page stack
    let nextTextLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already bored?"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    let nextButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.buttonSize = .large
        button.configuration?.cornerStyle = .medium
        button.configuration = .filled()
        button.tintColor = .systemMint
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    let nextStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    // Navigation bar buttons
    lazy var addingChildBarButton: UIBarButtonItem = {
        let barButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: .plain, target: self, action: #selector(addingChildButtonTapped))
        barButton.tintColor = .systemMint
        return barButton
    }()
    lazy var removingChildBarButton: UIBarButtonItem = {
        let barButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "minus.square"), style: .plain, target: self, action: #selector(removingChildButtonTapped))
        barButton.tintColor = .systemMint
        return barButton
    }()
    lazy var transitionBarButton: UIBarButtonItem = {
        let barButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slowmo"), style: .plain, target: self, action: #selector(transitionViews))
        barButton.tintColor = .systemMint
        return barButton
    }()
    // Trans views
    let trans: UIView = {
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemPink
        return v
    }()
    let imageView: UIImageView = {
        let iv: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "lp")
        return iv
    }()
    
    
    lazy var viewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 80)
    lazy var albumHeightConstraint = albumImageView.heightAnchor.constraint(equalToConstant: 50)

// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [addingChildBarButton, removingChildBarButton]
        navigationItem.leftBarButtonItem = transitionBarButton
        // Setup UI
        albumImageView.image = UIImage(named: "lp")
        songTitlesStack.isHidden = true
        // Subviews
        albumStack.addArrangedSubview(albumImageView)
        albumStack.addArrangedSubview(songTime)
        playbackControlsStack.addArrangedSubview(backButton)
        playbackControlsStack.addArrangedSubview(playButton)
        playbackControlsStack.addArrangedSubview(forwardButton)
        songTitlesStack.addArrangedSubview(songTitle)
        songTitlesStack.addArrangedSubview(songSubtitle)
        playbackStack.addArrangedSubview(songTitlesStack)
        playbackStack.addArrangedSubview(playbackControlsStack)
        bottomView.addSubview(albumStack)
        bottomView.addSubview(playbackStack)
        view.addSubview(bottomView)
        nextStack.addArrangedSubview(nextTextLabel)
        nextStack.addArrangedSubview(nextButton)
        view.addSubview(nextStack)
        view.addSubview(imageView)
        // Targets
        bottomView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappingBottomView2)))
        nextButton.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        // UI config
        NSLayoutConstraint.activate([
            // Transitioning views
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            // Bottom bar
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewHeightConstraint,
            // Album image
            albumHeightConstraint,
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),
            // Album stack
            albumStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            albumStack.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            // Playback stack
            playbackStack.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            playbackStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            // Next stack
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.leadingAnchor.constraint(equalTo: nextStack.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: nextStack.trailingAnchor),
            nextStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -50),
        ])
        
        view.addSubview(trans)
        
        NSLayoutConstraint.activate([
            self.trans.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            self.trans.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.trans.widthAnchor.constraint(equalToConstant: 100),
            self.trans.heightAnchor.constraint(equalTo: self.trans.widthAnchor),
        ])
        
        trans.isHidden = true
    }

}

// MARK: - Extensions

extension MainScreenVC {
    
    @objc func tappingBottomView() {
        // Animate
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            // Animations
            self.viewHeightConstraint.constant = self.isExtended ? 80 : 180
            self.albumHeightConstraint.constant = self.isExtended ? 50 : 90
            self.backButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 20 : 30)
            self.playButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 30 : 40)
            self.forwardButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 20 : 30)
            self.songTitlesStack.isHidden = self.isExtended
            self.albumStack.axis = self.isExtended ? .horizontal : .vertical
            self.songTime.text = self.isExtended ? "2:27" : "2:27 / 3:14"
            // Make it smooth
            self.view.layoutIfNeeded()
        }
        // Toggle
        isExtended.toggle()
    }
    
    @objc func tappingBottomView2() {
        let duration: TimeInterval = 0.6
        
        isExtended.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration / 3) {
            self.songTime.text = self.isExtended ? "2:27 / 3:14" : "2:27"
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .allowUserInteraction) { [weak self] in
            guard let self = self else { return }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.songTime.alpha = 0
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.6) {
                self.viewHeightConstraint.constant = self.isExtended ? 180 : 80
                self.albumHeightConstraint.constant = self.isExtended ? 90 : 50
                self.backButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 30 : 20)
                self.playButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 40 : 30)
                self.forwardButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 30 : 20)
                self.songTitlesStack.isHidden = !self.isExtended
                self.albumStack.axis = self.isExtended ? .vertical : .horizontal
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.songTime.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func addingChildButtonTapped() {
        addChild(childishVC)
        view.addSubview(childishVC.view)
        childishVC.view.translatesAutoresizingMaskIntoConstraints = false
        childishVC.didMove(toParent: self)
        NSLayoutConstraint.activate([
            childishVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            childishVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childishVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childishVC.view.heightAnchor.constraint(equalToConstant: 250)
        ])
        view.backgroundColor = .systemGray6
    }
    
    @objc func removingChildButtonTapped() {
        if childishVC.parent != nil {
            childishVC.willMove(toParent: nil)
            childishVC.removeFromParent()
            childishVC.view.removeFromSuperview()
        }
        view.backgroundColor = .systemBackground
    }
    
    @objc func transitionViews() {
        UIView.transition(from: imageView, to: trans, duration: 1, options: [.transitionFlipFromRight, .showHideTransitionViews])
    }
    
}

extension MainScreenVC {
    
    @objc func goToNextPage() {
        navigationController?.pushViewController(RandomAnimationsVC(), animated: true)
    }
    
}
