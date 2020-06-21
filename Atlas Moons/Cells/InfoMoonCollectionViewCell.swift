//
//  InfoMoonCollectionViewCell.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 05/05/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

class InfoMoonViewCell: UICollectionViewCell, AnimateCollectionViewCell {
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
    
    let footLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var indexItem: Int?
    var planet: Planet?{didSet{
    guard let planet = planet else {
        return
    }
    setupView()
    setView(planet: planet)
    }}
    
    private func setupView(){
        clipsToBounds = false
        backgroundColor = .clear
        let layoutGuide = contentView.layoutMarginsGuide
        add(titleLabel) {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(20).dp),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(20).dp),
                $0.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -CGFloat(20).dp)
            ])
        }
        add(subtitleLabel) {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(10).dp),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(20).dp),
                $0.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -CGFloat(10).dp)
            ])
        }
        add(footLabel) {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat(20).dp),
                $0.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -CGFloat(10).dp)
            ])
        }
    }
    
    
    private func setView(planet: Planet){
        guard let item = indexItem else {return}
        titleLabel.setAttributes(text: planet.getInfoMoon(index: item - 1)?.name ?? "",
                                 font: Okomito.bold(size: CGFloat(26).dp),
                                 textSpacing: 0,
                                 color: .white)
        subtitleLabel.setAttributes(text: planet.getInfoMoon(index: item - 1)?.description ?? "",
                                    font: Okomito.light(size: CGFloat(13).dp),
                                    textSpacing: 0,
                                    color: UIColor.white.withAlphaComponent(0.9))
        
        footLabel.setAttributes(text: planet.getInfoMoon(index: item - 1)?.info ?? "",
                                font: Okomito.light(size: CGFloat(10).dp),
                                textSpacing: 0,
                                color: UIColor.white.withAlphaComponent(0.55))
    }
    
    func startAnimation() {}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.removeFromSuperview()
        subtitleLabel.removeFromSuperview()
        footLabel.removeFromSuperview()
    }
}
