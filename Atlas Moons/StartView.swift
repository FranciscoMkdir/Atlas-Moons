//
//  StartView.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 15/05/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

protocol StartViewDelegate: class {
    func completion()
}

class StartView: UIView {
    weak var delegate: StartViewDelegate?
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setAttributes(text: "THE\nATLAS OF\nMOONS",
                            font: Okomito.bold(size: CGFloat(65).dp),
                            textSpacing: CGFloat(-2).dp,
                            color: .white)
        label.textAlignment = .center
        label.lblShadow(color: .white,
                        radius: 2,
                        opacity: 1)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setAttributes(text: """
                                    Our solar system collectively hosts over 200 known moons, \
                                    some of which are vibrant worlds in their own right. Take a \
                                    tour of the major moons in our celestial menagerie, including \
                                    those that are among the most mystifying—or scientifically \
                                    intriguing—places in our local neighborhood.
                                    """,
                            font: Okomito.regular(size: CGFloat(18)),
                            textSpacing: 0,
                            color: .white)
        label.textAlignment = .center
        label.lblShadow(color: .white,
                        radius: 2,
                        opacity: 1)
        return label
    }()
    
    let footerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setAttributes(text: "TAP TO START",
                            font: Okomito.bold(size: CGFloat(14).dp),
                            textSpacing: CGFloat(3).dp,
                            color: .white)
        label.textAlignment = .center
        label.lblShadow(color: .white,
                        radius: 2,
                        opacity: 1)
        return label
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInit()
    }
    
    private func setupGesture(){
        let tapGestures = UITapGestureRecognizer(target: self,
                                                 action: #selector(tapGestureRecognizer(_:)))
        addGestureRecognizer(tapGestures)
    }
    
    private func setupInit(){
        backgroundColor = .black
        setupGesture()
        add(backgroundImage) {
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: centerYAnchor),
                $0.widthAnchor.constraint(equalTo: widthAnchor),
                $0.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        }
        add(titleLabel) {
            $0.prepareForAnimation(position: .top)
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat(10).dp)
            ])
        }
        add(subtitleLabel) {
            $0.prepareForAnimation(position: .bottom)
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.widthAnchor.constraint(equalToConstant: frame.width * 0.95),
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(40).dp)
            ])
        }
        add(footerLabel) {
            $0.prepareForAnimation(position: .bottom)
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.widthAnchor.constraint(equalTo: widthAnchor),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -CGFloat(20).dp)
            ])
        }
        titleLabel.animateShow()
        subtitleLabel.animateShow()
        footerLabel.animateShow()
    }
    
    @objc func tapGestureRecognizer(_ sender: UITapGestureRecognizer){
        animateDismiss()
    }
    
    private func animateDismiss(){
        titleLabel.animate(inParallel: [
            .fadeOut(),
            .applyTransform(CGAffineTransform(translationX: 0, y: -CGFloat(20).dp))
        ])
        subtitleLabel.animate(inParallel: [
            .fadeOut(),
            .applyTransform(CGAffineTransform(translationX: 0, y: CGFloat(20).dp))
        ])
        footerLabel.animate(inParallel: [
            .fadeOut(),
            .applyTransform(CGAffineTransform(translationX: 0, y: CGFloat(20).dp))
        ])
        backgroundImage.animate(inParallel: [
            .fadeOut(duration: 1, delay: 0.25),
            .applyTransform(CGAffineTransform(scaleX: 3, y: 3), duration: 1, delay: 0.25)
        ]).perform {
            self.delegate?.completion()
            self.removeFromSuperview()
        }
    }
}
