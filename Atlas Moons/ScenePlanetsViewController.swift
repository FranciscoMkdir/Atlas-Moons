//
//  ScenePlanetsViewController.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 25/04/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit
import SceneKit

class ScenePlanetsViewController: UIViewController {
    @IBOutlet weak var sceneView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var planetNode: SCNNode?
    var planet: Planet?{didSet{
        guard let planet = planet else {return}
        updateScene(planet: planet)
        }}
    var currentDistanceCamera: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        setupStars()
    }
    
    private func setupView(){
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:)))
        tapGestures.name = "Tap"
        sceneView.addGestureRecognizer(tapGestures)
    }
  
    private func setupScene(){
        scnScene = SCNScene()
        sceneView.scene = scnScene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        scnScene.background.contents = UIColor.black
        guard let tapGestures = sceneView.gestureRecognizers?.filter({
            ($0 as? UITapGestureRecognizer) != nil }),
            let tapGesture = tapGestures.first(where: { $0.name == "Tap" }),
            let doubleTapGesture = tapGestures.first(where: { $0.name != "Tap" }) else {return}
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    private func setupCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.name = "Camera"
        cameraNode.position = SCNVector3(0, 0, 20)
        cameraNode.eulerAngles = SCNVector3(0, 0, 0)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    private func setupStars(){
        let sphereGeometry = SCNSphere(radius: 40)
        sphereGeometry.materials.first?.diffuse.contents = UIImage(named: "stars")
        sphereGeometry.materials.first?.isDoubleSided = true
        sphereGeometry.materials.first?.diffuse.wrapS = .repeat
        sphereGeometry.materials.first?.diffuse.wrapT = .repeat
        sphereGeometry.materials.first?.diffuse.contentsTransform = SCNMatrix4MakeScale(3, 3, 0)
        let nodeSphere = SCNNode(geometry: sphereGeometry)
        nodeSphere.name = "Stars"
        scnScene.rootNode.addChildNode(nodeSphere)
    }
    
    private func updateScene(planet: Planet){
        cleanScene()
        switch planet.type {
        case .earth:
            planetNode = createPlanet(image: "earth_texture")
            let moon = createRingWithMoon(sizeRing: 10, numberRing: 1, durationMoon: 2)
            setInfoMoon(moon, nameMoon: "Moon", namePlanet: "earth", distance: "230,00 mi", time: "27.3 days")
        case .mars:
            planetNode = createPlanet(image: "mars_texture")
            let moon = createRingWithMoon(sizeRing: 1.3, numberRing: 1, durationMoon: 2)
            setInfoMoon(moon, nameMoon: "Phobos", namePlanet: "mars", distance: "5,900 mi", time: "7.7 hours")
            
            let moon2 = createRingWithMoon(sizeRing: 2.5, numberRing: 2, durationMoon: 6)
            setInfoMoon(moon2, nameMoon: "Deimos", namePlanet: "mars", distance: "14,600 mi", time: "1.3 days")
        case .jupiter:
            planetNode = createPlanet(image: "jupiter_texture")
            let moon = createRingWithMoon(sizeRing: 1.6, numberRing: 1, durationMoon: 4)
            setInfoMoon(moon, nameMoon: "Io", namePlanet: "jupiter", distance: "263,000 mi", time: "1.8 days")
            
            let moon2 = createRingWithMoon(sizeRing: 2.4, numberRing: 2, durationMoon: 8)
            setInfoMoon(moon2, nameMoon: "Europa", namePlanet: "jupiter", distance: "413,200 mi", time: "3.6 days")
            
            let moon3 = createRingWithMoon(sizeRing: 3.9, numberRing: 3, durationMoon: 10)
            setInfoMoon(moon3, nameMoon: "Ganymede", namePlanet: "jupiter", distance: "665,700 mi", time: "7.2 days")
            
            let moon4 = createRingWithMoon(sizeRing: 6, numberRing: 4, durationMoon: 18)
            setInfoMoon(moon4, nameMoon: "Callisto", namePlanet: "jupiter", distance: "1.2 million mi", time: "16.7 days")
        case .saturn:
            planetNode = createPlanet(image: "saturn_texture")
            planetNode?.addChildNode(createRingSaturn())
            let moon = createRingWithMoon(sizeRing: 1.1, numberRing: 1, durationMoon: 2)
            setInfoMoon(moon, nameMoon: "Mimas", namePlanet: "saturn", distance: "114,400 mi", time: "22.6 hours")
            
            let moon2 = createRingWithMoon(sizeRing: 1.3, numberRing: 2, durationMoon: 3.5)
            setInfoMoon(moon2, nameMoon: "Enceladus", namePlanet: "saturn", distance: "147,900 mi", time: "1.4 days")
            
            let moon3 = createRingWithMoon(sizeRing: 1.7, numberRing: 3, durationMoon: 5)
            setInfoMoon(moon3, nameMoon: "Tethys", namePlanet: "saturn", distance: "183,300 mi", time: "1.9 days")
            
            let moon4 = createRingWithMoon(sizeRing: 2.2, numberRing: 4, durationMoon: 7)
            setInfoMoon(moon4, nameMoon: "Dione", namePlanet: "saturn", distance: "245,100 mi", time: "2.7 days")
            
            let moon5 = createRingWithMoon(sizeRing: 3, numberRing: 5, durationMoon: 9)
            setInfoMoon(moon5, nameMoon: "Rhea", namePlanet: "saturn", distance: "327,400 mi", time: "4.5 days")
            
            let moon6 = createRingWithMoon(sizeRing: 6, numberRing: 6, durationMoon: 12)
            setInfoMoon(moon6, nameMoon: "Titan", namePlanet: "saturn", distance: "740,200 mi", time: "16 days")
            
            let moon7 = createRingWithMoon(sizeRing: 10, numberRing: 7, durationMoon: 20)
            setInfoMoon(moon7, nameMoon: "Iapetus", namePlanet: "saturn", distance: "2.3 million mi", time: "79.3 days")
        case .uranus:
            planetNode = createPlanet(image: "uranus_texture")
            let moon = createRingWithMoon(sizeRing: 1.5, numberRing: 1, durationMoon: 2)
            setInfoMoon(moon, nameMoon: "Miranda", namePlanet: "uranus", distance: "80,600 mi", time: "1.4 days")
            
            let moon2 = createRingWithMoon(sizeRing: 1.9, numberRing: 2, durationMoon: 5)
            setInfoMoon(moon2, nameMoon: "Ariel", namePlanet: "uranus", distance: "118,700 mi", time: "2.5 days")
            
            let moon3 = createRingWithMoon(sizeRing: 2.6, numberRing: 3, durationMoon: 8)
            setInfoMoon(moon3, nameMoon: "Umbriel", namePlanet: "uranus", distance: "165,000 mi", time: "4.1 days")
            
            let moon4 = createRingWithMoon(sizeRing: 4, numberRing: 4, durationMoon: 15)
            setInfoMoon(moon4, nameMoon: "Titania", namePlanet: "uranus", distance: "270,900 mi", time: "8.7 days")
            
            let moon5 = createRingWithMoon(sizeRing: 5.5, numberRing: 5, durationMoon: 18)
            setInfoMoon(moon5, nameMoon: "Oberon", namePlanet: "uranus", distance: "363,100 mi", time: "13.5 days")
        case .neptune:
            planetNode = createPlanet(image: "neptune_texture")
            
            let moon = createRingWithMoon(sizeRing: 4, numberRing: 1, durationMoon: 2)
            setInfoMoon(moon, nameMoon: "Triton", namePlanet: "neptune", distance: "220,300 mi", time: "5.9 days")
        case .pluto:
            planetNode = createPlanet(image: "pluto_texture")
            
            let moon = createRingWithMoon(sizeRing: 5, numberRing: 1, durationMoon: 4)
            setInfoMoon(moon, nameMoon: "Charon", namePlanet: "pluto", distance: "12,200 mi", time: "6.4 days")
        }
        planetNode?.addSpin()
        setCamera(planet: planet)
    }
    
    
    
    private func setCamera(planet: Planet){
        view.isUserInteractionEnabled = false
        planetNode?.runAction(SCNAction.fadeIn(duration: 3))
        scnScene.rootNode.childNodes.forEach {
            if $0.name == "ring"{ $0.runAction(SCNAction.fadeIn(duration: 3)) }
        }
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        cameraNode.position = planet.camera.position
        cameraNode.eulerAngles = planet.camera.eulerAngle
        SCNTransaction.completionBlock = { self.resetCamera(duration: 0.5) {
            self.view.isUserInteractionEnabled = true
            } }
        SCNTransaction.commit()
        scnScene.rootNode.addChildNode(planetNode!)
    }
    
    private func getNodeText(_ text: String, style: StyleText) -> SCNNode{
        let nameText = SCNText(string: text, extrusionDepth: 0.0)
        switch style {
        case .headline:
            nameText.font = Okomito.bold(size: 11)
            nameText.firstMaterial?.diffuse.contents = UIColor.white
        case .infoTitle:
            nameText.font = Okomito.bold(size: 7)
            nameText.firstMaterial?.diffuse.contents = UIColor.gray
        case .infoSubtitle:
            nameText.font = Okomito.regular(size: 8)
            nameText.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.9)
        }
        let textNode = SCNNode(geometry: nameText)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = .Y
        textNode.constraints = [constraint]
        textNode.name = "text"
        return textNode
    }
    
    private func createRingSaturn() -> SCNNode{
        let ring = SCNTube(innerRadius: 0.5, outerRadius: 1.2, height: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "saturnring")
        material.isDoubleSided = true
        material.blendMode = .add
        
        ring.materials = [material]
        let ringNode = SCNNode(geometry: ring)
        return ringNode
    }
    
    private func createRingWithMoon(sizeRing: Float, numberRing: Int, durationMoon: Float) -> SCNNode{
        let ring = createRing(ringSize: sizeRing)
        scnScene.rootNode.addChildNode(ring)
        scnScene.rootNode.addChildNode(createRingHighlight(name: "ringHighlight_\(numberRing)", ringSize: sizeRing))
        
        let moon = createMoon(radius: 0.025)
        moon.position = SCNVector3(sizeRing, 0, 0)
        ring.addChildNode(moon)
        rotateObject(rotation: 0.4, planet: moon, duration: 0.4)
        rotateObject(rotation: 0.4, planet: ring, duration: durationMoon)
        return  moon
    }
    
    private func createRingWithMinorMoon(sizeRing: Float, durationMoon: Float){
        let ring = createRing(ringSize: sizeRing)
        scnScene.rootNode.addChildNode(ring)
        
        let moon = createMoon(radius: 0.01)
        moon.position = SCNVector3(sizeRing, 0, 0)
        ring.addChildNode(moon)
        rotateObject(rotation: 0.4, planet: moon, duration: 0.4)
        rotateObject(rotation: 0.4, planet: ring, duration: durationMoon)
    }
    
    private func setInfoMoon(_ moon: SCNNode, nameMoon: String, namePlanet: String, distance: String, time: String){
        let text1 = getNodeText(nameMoon, style: .headline)
        text1.position = SCNVector3(0, 0, 0)
        moon.addChildNode(text1)
        let text2 = getNodeText("\(namePlanet.uppercased()) DISTANCE", style: .infoTitle)
        text2.position = SCNVector3(0, -0.1, 0)
        moon.addChildNode(text2)
        let text3 = getNodeText(distance, style: .infoSubtitle)
        text3.position = SCNVector3(0, -0.18, 0)
        moon.addChildNode(text3)
        let text4 = getNodeText("ORBIT", style: .infoTitle)
        text4.position = SCNVector3(0, -0.28, 0)
        moon.addChildNode(text4)
        let text5 = getNodeText(time, style: .infoSubtitle)
        text5.position = SCNVector3(0, -0.36, 0)
        moon.addChildNode(text5)
    }
    
    private func createMoon(radius: Float) -> SCNNode{
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "moon_texture")
        planet.materials = [material]
        let node = SCNNode(geometry: planet)
        node.name = "moon"
        return node
    }
    
    private func createPlanet(image: String) -> SCNNode{
        let planet = SCNSphere(radius: 0.4)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: image)
        planet.materials = [material]
        let planetNode = SCNNode(geometry: planet)
        planetNode.name = "planet"
        planetNode.opacity = 0
        return planetNode
    }
    
    func createRing(ringSize: Float) -> SCNNode {
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.003)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white.withAlphaComponent(0.05)
        material.blendMode = .add
        ring.materials = [material]
        let ringNode = SCNNode(geometry: ring)
        ringNode.name = "ring"
        ringNode.opacity = 0
        return ringNode
    }
    
    func createRingHighlight(name: String, ringSize: Float) -> SCNNode {
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.015)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(hexString: "#438FE8")
        material.blendMode = .add
        ring.materials = [material]
        let node = SCNNode(geometry: ring)
        node.opacity = 0.0
        node.name = name
        let gaussianBlur = CIFilter(name: "CIGaussianBlur")
        gaussianBlur?.name  = "blur"
        gaussianBlur?.setValue(2, forKey: "inputRadius")
        node.filters = [gaussianBlur] as? [CIFilter]
        return node
    }
    
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float){
        let rotation = SCNAction.rotateBy(x:0,y:CGFloat(rotation),z:0, duration: TimeInterval(duration))
        planet.runAction(SCNAction.repeatForever(rotation))
    }
    
    private func cleanScene(){
        scnScene.rootNode.childNodes.forEach {
            if $0.name != "Camera" && $0.name != "Stars"{
                $0.removeAllActions()
                $0.removeFromParentNode()
            }
        }
    }
    
    @objc func tapGestureRecognizer(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(location,
                                               options: [.searchMode: SCNHitTestSearchMode.all.rawValue])
        guard let objectNode = hitTestResults.first?.node,
            let nameNode = objectNode.name,
            nameNode != "Stars",
            let planet = planet else {
                return
        }
        presentInfoPlanet(planet)
    }
    
    func presentInfoPlanet(_ planet: Planet){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoPlanetViewController") as? InfoPlanetViewController else {
            return
        }
        vc.planet = planet
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        (parent as? HomeViewController)?.showCollectionPlanets(false)
        feedbackTap()
        resetCamera {
            self.hightlightPlanet() {}
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    private func resetCamera(duration: CFTimeInterval = 1, completion: @escaping() -> ()){
        guard let planet = planet else { return }
        SCNTransaction.begin()
        SCNTransaction.animationDuration = duration
        sceneView.defaultCameraController.pointOfView?.constraints = []
        sceneView.defaultCameraController.pointOfView?.position = planet.camera.position
        sceneView.defaultCameraController.pointOfView?.eulerAngles = planet.camera.eulerAngle
        sceneView.defaultCameraController.pointOfView?.camera?.fieldOfView = planet.camera.fieldOfView
        sceneView.defaultCameraController.frameNodes(scnScene.rootNode.childNodes.filter({
            ($0.name ?? "").contains("ringHighlight_")
        }))
        SCNTransaction.completionBlock = { completion() }
        SCNTransaction.commit()
    }
    
    private func feedbackTap(){
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    private func cleanHighlightMoon(){
        scnScene.rootNode.childNodes.forEach {
            if let name = $0.name, name.contains("ringHighlight_") {
                $0.opacity = 0
            }
        }
    }
    
    private func hightlightPlanet(distance: CGFloat = 2, duration: TimeInterval = 3, completion: @escaping() -> ()){
        guard let planet = planetNode else { return }
        currentDistanceCamera = distance
        let distanceConstraint = SCNDistanceConstraint(target: planet)
        distanceConstraint.minimumDistance = distance
        distanceConstraint.maximumDistance = distance
        let lookAtConstraint = SCNLookAtConstraint(target: planet)
        lookAtConstraint.isGimbalLockEnabled = true
        SCNTransaction.begin()
        SCNTransaction.animationDuration = duration
        SCNTransaction.completionBlock = {
            completion()
        }
        sceneView.defaultCameraController.pointOfView?.constraints = [lookAtConstraint, distanceConstraint]
        SCNTransaction.commit()
    }
    
    private func hightlightMoon(item: Int, distance: CGFloat){
        guard let ringNode = scnScene.rootNode.childNodes.first(where: {  $0.name == "ringHighlight_\(item)" }) else {
            return
        }
        ringNode.opacity = 1
        currentDistanceCamera = distance
        let distanceConstraint = SCNDistanceConstraint(target: ringNode)
        distanceConstraint.minimumDistance = distance
        distanceConstraint.maximumDistance = distance
        let lookAtConstraint = SCNLookAtConstraint(target: ringNode)
        lookAtConstraint.isGimbalLockEnabled = false
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 3
        sceneView.defaultCameraController.pointOfView?.constraints = [lookAtConstraint, distanceConstraint]
        SCNTransaction.commit()
    }
}

extension ScenePlanetsViewController: InfoPlanetDelegate {
    func highlightMoon(item: Int) {
        guard let planet = planet else {return}
        cleanHighlightMoon()
        switch item {
        case 0: hightlightPlanet(distance: planet.distancePlanet) {}
        default: hightlightMoon(item: item, distance: planet.getDistanceMoon(index: item))
        }
    }
    
    func infoDismiss() {
        cleanHighlightMoon()
        hightlightPlanet(distance: currentDistanceCamera, duration: 0.1) {
            self.resetCamera {}
        }
        (parent as? HomeViewController)?.showCollectionPlanets(true)
    }
}

enum StyleText {
    case headline
    case infoTitle
    case infoSubtitle
}
