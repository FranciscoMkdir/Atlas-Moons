//
//  PlanetCollectionViewCell.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 26/01/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

class ThumbnailPlanetCollectionViewCell: UICollectionViewCell {
    var planet: Planet?{didSet{
        guard let planet = planet else {return}
        setupView(planet: planet)
        }}
    var planetView: ThumbnailPlanet?
    
    override func awakeFromNib() {
      super.awakeFromNib()
    }
    
    private func setupView(planet: Planet){
        planetView = ThumbnailPlanet(frame: .zero, planet: planet)
        planetView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(planetView!)
        NSLayoutConstraint.activate([
            planetView!.centerYAnchor.constraint(equalTo: centerYAnchor),
            planetView!.centerXAnchor.constraint(equalTo: centerXAnchor),
            planetView!.widthAnchor.constraint(equalToConstant: CGFloat(120).dp),
            planetView!.heightAnchor.constraint(equalToConstant: CGFloat(120).dp)
        ])
    }
    
    func animatePlanet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.planetView?.setMoons()
        }
    }
    
    func hideMoons(){
        self.planetView?.hideMoons()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        planetView?.removeFromSuperview()
        planetView = nil
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularLayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
        self.center.y += (circularLayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
    }
    
}
