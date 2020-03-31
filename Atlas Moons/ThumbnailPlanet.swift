//
//  ThubmnailPlanet.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 10/24/19.
//  Copyright © 2019 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

class ThumbnailPlanet: UIView {
    var moons = [ViewCircle]()
    lazy var viewPlanet: ViewCircle = {
        let view = ViewCircle(frame: .zero)
        return view
    }()
    var planet: Planet
    

    public func setMoons(){
        moons.forEach { $0.removeFromSuperview() }
        moons.removeAll()
        for _ in 0..<planet.moons{
            let moon = newMoon(size: planet.sizeMoons)
            moons.append(moon)
            addSubview(moon)
            moon.center = CGPoint(x: 0, y: 0)
            let distanceMoons = planet.distanceMoons
            rotateAnimation(view: moon,
                            duration: CFTimeInterval(Float.random(in: 2.0 ... 2.5)),
                            rect: CGRect(x: distanceMoons * (frame.width * 0.1),
                                         y: distanceMoons * (frame.height * 0.1),
                                         width: frame.width - (distanceMoons * (frame.width * 0.2)),
                                         height: frame.height - (distanceMoons * (frame.height * 0.2))))
        }
    }
        
    
    init(frame: CGRect, planet: Planet) {
        self.planet = planet
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func sharedInit(){
        backgroundColor = .clear
        addSubview(viewPlanet)
        viewPlanet.backgroundColor = planet.color
        viewPlanet.translatesAutoresizingMaskIntoConstraints = false
        viewPlanet.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewPlanet.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewPlanet.widthAnchor.constraint(equalToConstant: planet.sizePlanet).isActive = true
        viewPlanet.heightAnchor.constraint(equalToConstant: planet.sizePlanet).isActive = true
    }
    
    private func newMoon(size: SizeMoon) -> ViewCircle{
        let moon = ViewCircle(frame: CGRect(x: 0,
                                            y: 0,
                                            width: viewPlanet.frame.width * size.rawValue.dp,
                                            height: viewPlanet.frame.height * size.rawValue.dp))
        moon.backgroundColor = .white
        return moon
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func rotateAnimation(view: UIView, duration: CFTimeInterval = 2.0, rect: CGRect) {
        let orbit = CAKeyframeAnimation(keyPath: "position")
        let circlePath = UIBezierPath(ovalIn: rect)
        orbit.path = circlePath.cgPath
        orbit.duration = duration
        orbit.isAdditive = true
        orbit.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        view.layer.add(orbit, forKey: "orbit")
    }
}


class ViewCircle: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit(){
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.height / 2
    }
}

