//
//  MainScreenVC.swift
//  AnimationsTest
//
//  Created by Jan Kučera on 16.03.2022.
//

import UIKit

class MainScreenVC: UIViewController {
    
    var isExtended: Bool = false
    
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
        label.textAlignment = .right
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
    
    lazy var viewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 80)
    lazy var albumHeightConstraint = albumImageView.heightAnchor.constraint(equalToConstant: 50)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
        // Targets
        bottomView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappingBottomView2)))
        // UI config
        NSLayoutConstraint.activate([
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
        ])
    }

}

extension MainScreenVC {
    
    @objc func tappingBottomView() {
        // Animate
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            // Animations
            self.viewHeightConstraint.constant = self.isExtended ? 80 : 180
            self.albumHeightConstraint.constant = self.isExtended ? 50 : 90
            self.backButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 20 : 33)
            self.playButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 30 : 45)
            self.forwardButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 20 : 33)
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
        UIView.animateKeyframes(withDuration: 10, delay: 0, options: .calculationModeLinear) { [weak self] in
            guard let self = self else { return }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.songTime.isHidden = true
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.6) {
                self.viewHeightConstraint.constant = self.isExtended ? 80 : 180
                self.albumHeightConstraint.constant = self.isExtended ? 50 : 90
                self.backButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 20 : 33)
                self.playButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 30 : 45)
                self.forwardButton.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: self.isExtended ? 20 : 33)
                self.songTitlesStack.isHidden = self.isExtended
                self.albumStack.axis = self.isExtended ? .horizontal : .vertical
//                self.songTime.isHidden = true
                self.view.layoutIfNeeded()

            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.songTime.text = self.isExtended ? "2:27" : "2:27 / 3:14"
                self.songTime.isHidden = false
                self.view.layoutIfNeeded()
            }
            // Make it smooth
        }
        
        // Toggle
        isExtended.toggle()
    }
    
}
