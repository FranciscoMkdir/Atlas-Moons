//
//  InfoPlanetCollectionViewCells.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 01/05/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

protocol AnimateCollectionViewCell {
    func startAnimation()
    var planet: Planet? { get set }
    var indexItem: Int? {get set}
}

class InfoPlanetViewCell: UICollectionViewCell, AnimateCollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moonsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberMinorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moonsMinorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconArrow: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "arrow_bottom")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    var indexItem: Int?
    var planet: Planet?{didSet{
        guard let planet = planet else {
            return
        }
        setupView()
        setView(planet: planet)
        }}
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupView(){
        clipsToBounds = false
        backgroundColor = .clear
        let layoutGuide = contentView.layoutMarginsGuide
        add(titleLabel) {
            $0.prepareForAnimation(position: .right)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(20).dp),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(20).dp),
                $0.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -CGFloat(20).dp)
            ])
        }
        add(subtitleLabel) {
            $0.prepareForAnimation(position: .top)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(10).dp),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(20).dp),
                $0.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -CGFloat(10).dp)
            ])
        }
        add(numberLabel) {
            $0.prepareForAnimation(position: .right)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat(25).dp)
            ])
        }
        add(moonsLabel) {
            $0.prepareForAnimation(position: .right)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: CGFloat(5).dp),
                $0.topAnchor.constraint(equalToSystemSpacingBelow: numberLabel.topAnchor, multiplier: 3.5)
            ])
        }
        add(numberMinorLabel) {
            $0.prepareForAnimation(position: .right)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: moonsLabel.trailingAnchor, constant: CGFloat(20).dp),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat(25).dp)
            ])
        }
        add(moonsMinorLabel) {
            $0.prepareForAnimation(position: .right)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: numberMinorLabel.trailingAnchor, constant: CGFloat(5).dp),
                $0.topAnchor.constraint(equalToSystemSpacingBelow: numberLabel.topAnchor, multiplier: 3.5)
            ])
        }
        
        add(iconArrow) {
            $0.prepareForAnimation(position: .bottom)
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat(5).dp),
                $0.widthAnchor.constraint(equalToConstant: CGFloat(30).dp),
                $0.heightAnchor.constraint(equalToConstant: CGFloat(30).dp)
            ])
        }
    }
    
    private func setView(planet: Planet){
        titleLabel.setAttributes(text: planet.getInfo().title,
                                 font: Okomito.bold(size: CGFloat(26).dp),
                                 textSpacing: 0,
                                 color: .white)
        subtitleLabel.setAttributes(text: planet.getInfo().info,
                                    font: Okomito.light(size: CGFloat(13).dp),
                                    textSpacing: 0,
                                    color: UIColor.white.withAlphaComponent(0.9))
        numberLabel.setAttributes(text: "\(planet.moons)",
                                  font: Okomito.bold(size: CGFloat(85).dp),
                                  textSpacing: 0,
                                  color: UIColor(hexString: "#438FE8"))
        
        switch planet.type {
        case .jupiter, .saturn, .uranus, .neptune, .pluto:
            moonsLabel.setAttributes(text: planet.moons == 1 ? "MAJOR\nMOON" : "MAJOR\nMOONS",
                                     font: Okomito.regular(size: CGFloat(16).dp),
                                     textSpacing: CGFloat(-1.5).dp,
                                     color: UIColor(hexString: "#438FE8"))
            
            numberMinorLabel.setAttributes(text: "\(planet.minorMoons)",
                                          font: Okomito.bold(size: CGFloat(85).dp),
                                          textSpacing: CGFloat(-2).dp,
                                          color: UIColor(hexString: "#BEDAFC"))
            
            moonsMinorLabel.setAttributes(text: planet.minorMoons < 1 ? "MINOR\nMOON" : "MINOR\nMOONS",
                                          font: Okomito.regular(size: CGFloat(16).dp),
                                          textSpacing: CGFloat(-2).dp,
                                          color: UIColor(hexString: "#BEDAFC"))
            
        default:
            moonsLabel.setAttributes(text: planet.moons == 1 ? "MOON" : "MOONS",
                                     font: Okomito.regular(size: CGFloat(16).dp),
                                     textSpacing: CGFloat(-1.5).dp,
                                     color: UIColor(hexString: "#438FE8"))
        }
    }
    
    func startAnimation() {
        titleLabel.animateShow()
        subtitleLabel.animateShow(delay: 0.1)
        numberLabel.animateShow(delay: 0.2)
        moonsLabel.animateShow(delay: 0.3)
        numberMinorLabel.animateShow(delay: 0.2)
        moonsMinorLabel.animateShow(delay: 0.3)
        iconArrow.animateShow(delay: 0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.removeFromSuperview()
        subtitleLabel.removeFromSuperview()
        numberLabel.removeFromSuperview()
        moonsLabel.removeFromSuperview()
        numberMinorLabel.removeFromSuperview()
        moonsMinorLabel.removeFromSuperview()
        iconArrow.removeFromSuperview()
    }
}
