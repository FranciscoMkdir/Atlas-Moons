//
//  Model.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 10/24/19.
//  Copyright © 2019 Francisco Javier Delgado García. All rights reserved.
//

import UIKit
import SceneKit

struct Planet {
    let camera: Camera
    let type: TypePlanet
    
    var name: String{
        switch type {
        case .earth: return "Earth"
        case .mars: return "Mars"
        case .jupiter: return "Jupiter"
        case .saturn: return "Saturn"
        case .uranus: return "Uranus"
        case .neptune: return "Neptune"
        case .pluto: return "Pluto"
        }
    }
    
    var moonsDescription: String{
        switch type {
        case .earth: return "One Moon"
        case .mars: return "Two Moons"
        case .jupiter: return "Four Moons"
        case .saturn: return "Seven Moons"
        case .uranus: return "Five Moons"
        case .neptune: return "One Moon"
        case .pluto: return "One Moon"
        }
    }
    
    var color: UIColor{
        switch type {
        case .earth: return UIColor(hexString: "#4F86E8")
        case .mars: return UIColor(hexString: "#B93F2A")
        case .jupiter: return UIColor(hexString: "#B96E35")
        case .saturn: return UIColor(hexString: "#A1937B")
        case .uranus: return UIColor(hexString: "#4C90A1")
        case .neptune: return UIColor(hexString: "#203796")
        case .pluto: return UIColor(hexString: "#ACA19B")
        }
    }
    
    var moons: Int{
        switch type {
        case .earth: return 1
        case .mars: return 2
        case .jupiter: return 4
        case .saturn: return 7
        case .uranus: return 5
        case .neptune: return 1
        case .pluto: return 1
        }
    }
    
    var minorMoons: Int{
        switch type {
        case .jupiter: return 75
        case .saturn: return 75
        case .uranus: return 22
        case .neptune: return 13
        case .pluto: return 4
        default: return 0
        }
    }
    
    var sizeMoons: SizeMoon{
        switch type{
        case .earth: return .large
        case .mars: return .middle
        case .saturn: return .smaller
        case .jupiter: return .smaller
        case .uranus: return .smaller
        case .neptune: return .small
        case .pluto: return .large
        }
    }
    
    var distanceMoons: CGFloat{
        switch type{
        case .earth: return 3.0
        case .mars: return Bool.random() ? 3.0 : 3.6
        case .saturn: return Bool.random() ? 3.2 : 2.5
        case .jupiter: return  Bool.random() ? 3.0 : 2.5
        case .uranus: return Bool.random() ? 3.5 : 2.5
        case .neptune: return 3.5
        case .pluto: return 3.5
        }
    }
    
    var sizePlanet: CGFloat{
        switch type {
        case .earth: return CGFloat(18).dp
        case .mars: return CGFloat(15).dp
        case .jupiter: return CGFloat(26).dp
        case .saturn: return CGFloat(23).dp
        case .uranus: return CGFloat(22).dp
        case .neptune: return CGFloat(20).dp
        case .pluto: return CGFloat(10).dp
        }
    }
    
    init(type: TypePlanet) {
        self.type = type
        switch type {
        case .earth:
            camera = Camera(position: SCNVector3(0, 10, 30),
                            eulerAngle: SCNVector3(-0.4, 0, 0),
                            fieldOfView: 60)
        case .mars:
            camera = Camera(position: SCNVector3(0, 4, 9),
                            eulerAngle: SCNVector3(-0.5, 0, 0),
                            fieldOfView: 60)
        case .jupiter:
            camera = Camera(position: SCNVector3(0, 7, 16),
                            eulerAngle: SCNVector3(-0.5, 0, 0),
                            fieldOfView: 60)
        case .saturn:
            camera = Camera(position: SCNVector3(0, 13, 30),
                            eulerAngle: SCNVector3(-0.5, 0, 0),
                            fieldOfView: 60)
        case .uranus:
            camera = Camera(position: SCNVector3(0, 8, 18),
                            eulerAngle: SCNVector3(-0.5, 0, 0),
                            fieldOfView: 60)
        case .neptune:
            camera = Camera(position: SCNVector3(0, 7, 15),
                            eulerAngle: SCNVector3(-0.5, 0, 0),
                            fieldOfView: 60)
        case .pluto:
            camera = Camera(position: SCNVector3(0, 9, 19),
                            eulerAngle: SCNVector3(-0.5, 0, 0),
                            fieldOfView: 60)
        }
    }
}

extension Planet{
    struct Info {
        let title: String
        let info: String
    }
    
    func getInfo() -> Info{
        switch type {
        case .earth:
            return Info(title: "Earth System",
                        info: """
                              Among the eight major planets, Earth is the only one with a single moon. Over millennia, \
                              our planet’s celestial companion has assumed many roles: Its shifting, glowing face has inspired myths \
                              and legends; its cratered surface continues to be a prime destination for robotic and human explorers; \
                              and its gravitational heft and silvery light tangibly affect life on this planet.
                             """)
        case .mars:
            return Info(title: "Mars System",
                        info: """
                              Two dark, lumpy moons orbit Mars, and scientists suspect the planet stole \
                              them from the nearby asteroid belt. Phobos and Deimos, both discovered \
                              by the persistent moon hunter Asaph Hall, are among the smallest moons \
                              in the solar system. But in the future, they may become crucial way stations \
                              for humans attempting to establish a permanent presence on the Martian surface.
                              """)
        case .jupiter:
            return Info(title: "Jupiter System",
                        info: """
                              Jupiter’s 70 or so moons are dominated by the four Galilean satellites—Io, Europa, Ganymede, \
                              and Callisto—that were discovered by Galileo Galilei in 1610. By watching their movements over \
                              several nights, the famed Italian astronomer determined that the four prominent points of light flanking \
                              Jupiter were not distant stars, but worlds that swore gravitational allegiance to the solar system’s biggest planet.
                              """)
        case .saturn:
            return Info(title: "Saturn System",
                        info: """
                              Beautiful, ringed Saturn holds nearly seven dozen natural satellites in its gravitational \
                              clutches—a moon menagerie that includes some of the most alien worlds in the solar system. From hazy Titan \
                              to eruptive Enceladus to a swarm of small ice balls like Tethys, the Saturnian satellites are among the most \
                              varied of any planetary retinue.
                              """)
        case .uranus:
            return Info(title: "Uranus System",
                        info: """
                              Ice giant Uranus is swarmed by more than two dozen moons, five of which are notably large. \
                              These major moons were known before Voyager 2 swung by the tipped-over planet in 1986 and discovered 10 \
                              additional satellites. Since then, though, no spacecraft has visited Uranus or Neptune, meaning that imagery \
                              from these planets’ neighborhoods is sparse, and astronomers have had to rely on Earth-based telescopes
                              to study both systems.
                              """)
        case .neptune:
            return Info(title: "Neptune System",
                        info: """
                             Of the Neptunian moons, Triton is perhaps the most magnificent. This bizarre, frigid object was probably born \
                             in the Kuiper belt, a vast swath of fractured, icy worlds beyond Neptune’s orbit. But at some point in Neptune’s \
                             history, the massive planet’s gravity captured the icy giant and claimed it as a moon.
                             """)
        case .pluto:
            return Info(title: "Pluto System",
                        info: """
                              Among the solar system’s five official dwarf planets, Pluto has the most complex system of moons. \
                              Its largest companion, Charon, is so big it basically forms a binary system with Pluto. Its four smaller \
                              moons—Styx, Nix, Kerberos, and Hydra—are thought to be collisional shrapnel left over from the cataclysmic \
                              impact that made Charon. The dwarf planets Eris, Makemake, and Haumea also have known natural satellites, but \
                              these small moons are so dim and distant that they are essentially mysteries.
                              """)
        }
    }
}

extension Planet{
    struct Camera {
        let position: SCNVector3
        let eulerAngle: SCNVector3
        let fieldOfView: CGFloat
    }
}


extension Planet{
    struct Moon {
        let name: String
        let description: String
        let info: String
    }
    
    var distancePlanet: CGFloat{
        return 2
    }
    
    func getDistanceMoon(index: Int) -> CGFloat{
        switch type {
        case .earth:
            switch index {
            case 1: return 35
            default: return 0
            }
        case .mars:
            switch index {
            case 1: return 5
            case 2: return 9
            default: return 0
            }
        case .jupiter:
            switch index {
            case 1: return 6
            case 2: return 8
            case 3: return 15
            case 4: return 20
            default: return 0
            }
        case .saturn:
            switch index {
            case 1: return 4.2
            case 2: return 5
            case 3: return 7
            case 4: return 9
            case 5: return 12
            case 6: return 25
            case 7: return 38
            default: return 0
            }
        case .uranus:
            switch index {
            case 1: return 6
            case 2: return 8
            case 3: return 11
            case 4: return 16
            case 5: return 22
            default: return 0
            }
        case .neptune:
            switch index {
            case 1: return 16
            default: return 0
            }
        case .pluto:
            switch index {
            case 1: return 19
            default: return 0
            }
        }
    }
    
    func getInfoMoon(index: Int) -> Moon?{
        switch self.type {
        case .earth:
            switch index {
            case 0:
                return Moon(name: "Moon",
                            description: """
                                     Likely born from a fiery collision between Earth and a Mars-size planet, \
                                     the moon was once a quivering mass of magma. Over eons, it solidified into \
                                     the orb we see today. Whether crescent, half, or full, the moon keeps one \
                                     face perpetually pointed toward Earth. Its near-side complexion is a mottled \
                                     mix of dark patches—the sites of ancient lava seas—and gleaming, cratered \
                                     landscapes. The lunar far side is completely different, with a mix of highlands \
                                     and complex terrains.
                                     """,
                            info: """
                                     The moon has been known throughout recorded history. \
                                     The moon's largest features are named using Latin terms \
                                     describing large bodies of water.
                                     """)
            default: return nil
            }
        case .mars:
            switch index {
            case 0:
                return Moon(name: "Phobos",
                            description: """
                                         Resembling a ruddy space potato, Phobos is snuggled close to Mars, looping around the \
                                         planet three times each Martian day. But that orbital embrace won’t last forever: \
                                         Phobos is slowly falling from the sky, and in another 50 million years or so \
                                         it either will be ripped into a ring by Mars’s gravity or will crash into the \
                                         planet’s surface.
                                         """,
                            info: """
                                  Discovered in 1877 by Asaph Hall, it was named after a son of Ares. \
                                  Features are named for deceased scientists who studied Martian satellites, \
                                  as well as people and places from Jonathan Swift's Gulliver's Travels.
                                  """)
            case 1:
                return Moon(name: "Deimos",
                            description: """
                                         Smaller than Phobos and farther from Mars, irregularly shaped Deimos swings \
                                         around the planet once every 30 hours. It has two named surface features, \
                                         Swift and Voltaire, both honoring writers who hypothesized the existence \
                                         of Martian moons before they were discovered. Unlike Phobos, Deimos is \
                                         slowly drifting away from Mars and will eventually escape the planet’s gravity.
                                         """,
                            info: """
                                  Discovered in 1877 by Asaph Hall, it was named after a son of Ares. \
                                  Features are named for deceased authors who wrote about Martian satellites.
                                  """)
            default: return nil
            }
        case .jupiter:
            switch index {
            case 0:
                return Moon(name: "Io",
                            description: """
                                         The most geologically active body in the solar system, Io’s sulfuric plains \
                                         are pockmarked by an estimated 400 active volcanoes, with mountains taller than \
                                         Mount Everest. Some of these volcanoes spew exotic lavas and send fountains of gases \
                                         300 miles into space; particles launched by Io’s volcanoes also help power \
                                         Jupiter’s blazing polar auroras.
                                        """,
                            info: """
                                  Discovered in 1610 by Galileo Galilei, it was named after a lover of Zeus. \
                                  Volcanic features are named for ancient gods of fire, thunder, and sun.
                                  """)
            case 1:
                return Moon(name: "Europa",
                            description: """
                                         With a vast global ocean tucked beneath a smooth, icy shell, Europa is \
                                         considered one of the best places to look for life beyond Earth. Its ancient, alien \
                                         sea likely contains all the ingredients needed for life as we know it. Peering beneath \
                                         that crisscrossed crust is a bit tricky, but scientists recently spotted plumes of \
                                         possible seawater venting into space, which could be sampled by an orbiting craft.
                                         """,
                            info: """
                                  Discovered in 1610 by Galileo Galilei, it was named after a lover of Zeus. \
                                  Features are named for people, places, gods, or objects from Celtic myths, as \
                                  well as for people and places associated with the Greek Europa myth.
                                  """)
            case 2:
                return Moon(name: "Ganymede",
                            description: """
                                         Ganymede is the largest moon in the solar system. Bigger than the planet Mercury, \
                                         it’s the only moon with a known magnetic field. Like Europa, Ganymede is an ocean world, \
                                         meaning that an alien sea sloshes beneath its icy crust. The moon’s ancient surface is covered \
                                         in craters and peculiar grooved terrains, the source of which is not yet clear.
                                        """,
                            info: """
                                  Discovered in 1610 by Galileo Galilei, it was named after a lover of Zeus. Features are named \
                                  after characters and places in the ancient mythologies of Egypt and the Fertile Crescent and for \
                                  astronomers who discovered Jovian satellites.
                                 """)
            case 3:
                return Moon(name: "Callisto",
                            description: """
                                         The third largest moon in the solar system, Callisto is about the size of the planet Mercury. \
                                         Its icy surface is among the oldest and most cratered in the entire solar system, and scientists \
                                         suspect that a global ocean lies beneath that battered terrain. Of the Galilean satellites, Callisto \
                                         is the farthest from Jupiter and the planet’s punishing radiation, meaning that it could be an ideal \
                                         place to build a base for future exploration of the Jovian system.
                                         """,
                            info: """
                                  Discovered in 1610 by Galileo Galilei, it was named after a lover of Zeus. \
                                  Features are named for characters and places from Norse mythology.
                                  """)
            default: return nil
            }
        case .saturn:
            switch index {
            case 0:
                return Moon(name: "Mimas",
                            description: """
                                         Tiny Mimas is the smallest and innermost of Saturn’s large moons, but it’s not quite big \
                                         enough to be completely round. Instead, Mimas has a somewhat oval shape. A large 80-mile-wide \
                                         crater, named after William Herschel, dominates the Mimantean surface. \
                                         The crater’s relative size and pronounced central peak make Mimas resemble the Death \
                                         Star from Star Wars.
                                         """,
                            info: """
                                  Discovered in 1789 by William Herschel, it was named after a titan in Greek mythology. \
                                  Features are named for people and places in Sir Thomas Malory's Le Morte d'Arthur.
                                  """)
            case 1:
                return Moon(name: "Enceladus",
                            description: """
                                         Enceladus may be small, but it is a mighty world. Geysers erupting from large fractures in the moon’s \
                                         south pole spray salty water that ultimately forms one of Saturn’s rings. Those geysers are fueled \
                                         by an ocean tucked beneath the moon’s crust. Because this small world contains all the ingredients \
                                         needed for life as we know it, scientists consider Enceladus to be one of the prime places to \
                                         search for extraterrestrial life in the solar system.
                                         """,
                            info: """
                                  Discovered in 1789 by William Herschel, it was named after a titan in Greek mythology. \
                                  Features are named for people and places from the Arabian Nights collection of folktales.
                                  """)
            case 2:
                return Moon(name: "Tethys",
                            description: """
                                         Tethys is a world made almost purely of ice, and it is the second brightest Saturnian ice ball \
                                         after Enceladus. Its surface boasts two prominent features: large, shallow Odysseus Crater, \
                                         measuring some 250 miles across; and a two-mile-deep valley called Ithaca Chasma that stretches \
                                         more than 1,200 miles from end to end—or roughly 75 percent of Tethys’s circumference.
                                         """,
                            info: """
                                  Discovered in 1684 by Giovanni Domenico Cassini, it was named after a titan in Greek mythology. \
                                  Features are named after people and places in Homer's Odyssey.
                                  """)
            case 3:
                return Moon(name: "Dione",
                            description: """
                                         Dione is a heavily cratered world with an extremely tenuous oxygen atmosphere. Its trailing \
                                         hemisphere is heavily fractured by what scientists once called “wispy terrain.” \
                                         Close-up views from the Cassini spacecraft revealed those bright wisps to be chains of \
                                         immense ice cliffs reaching hundreds of feet high.
                                         """,
                            info: """
                                  Discovered in 1684 by Giovanni Domenico Cassini, it was named after a titan in Greek mythology. \
                                  Features are named after people and places from Virgil's Aeneid.
                                  """)
            case 4:
                return Moon(name: "Rhea",
                            description: """
                                         Rhea is Saturn’s second largest satellite and one of the few moons suspected to have had a \
                                         ring of its own, although the evidence for that is controversial. Its heavily cratered surface \
                                         contains several features resembling the icy cliffs on Dione, and in 2010, the Cassini \
                                         spacecraft revealed that Rhea has an extremely tenuous exosphere of oxygen and carbon dioxide.
                                         """,
                            info: """
                                  Discovered in 1672 by Giovanni Domenico Cassini, it was named after a titan in Greek mythology. \
                                  Feature names are derived from various world creation myths.
                                  """)
            case 5:
                return Moon(name: "Titan",
                            description: """
                                         The second largest moon in the solar system, Titan is one of the strangest natural satellites. \
                                         Shrouded in a thick, hazy atmosphere, the moon is covered by rock-hard ice and is the only body other \
                                         than Earth with permanent lakes, rivers, and seas dampening its surface. But on Titan, these liquids \
                                         aren’t water—they’re oily, slick hydrocarbons. Scientists consider Titan to be one of the best places \
                                         to look for truly alien life—organisms that evolved based on a completely different chemistry from our own.
                                         """,
                            info: """
                                  Discovered in 1655 by Dutch astronomer Christiaan Huygens, it was named after the race of powerful \
                                  deities descended from Gaia and Uranus. The largest surface features refer to sacred or enchanted \
                                  lands from various mythologies.
                                  """)
            case 6:
                return Moon(name: "Iapetus",
                            description: """
                                         The farthest-flung of Saturn’s major moons, two-toned Iapetus is shaped like a walnut with slightly flattened \
                                         poles. It also has a massive, still mysterious mountain ridge running straight as an arrow along 75 percent \
                                         of its equator. The moon’s back side is a bright, gleaming white, while its front half is darker than coal; \
                                         scientists recently determined that these colors are partially caused by dark dust, shed by another \
                                         Saturnian moon, sticking to Iapetus’s face.
                                         """,
                            info: """
                                  Discovered in 1671 by Giovanni Domenico Cassini, it was named after a titan in Greek mythology. \
                                  Features are named after people and places from Dorothy L. Sayers's translation of Chanson de Roland.
                                  """)
            default: return nil
            }
        case .uranus:
            switch index {
            case 0:
                return Moon(name: "Miranda",
                            description: """
                                          Miranda is the smallest of the five major Uranian moons. Its surface is a conglomerate of broken terrains \
                                          that look as though they’ve been haphazardly stitched together, including a gargantuan, 12-mile-high \
                                          cliff and a landscape of chevron-shaped ridges. One potential explanation for Miranda’s weirdness is that \
                                          at some point in its history, a giant impact nearly blew the moon apart, but gravity pieced it back together.
                                          """,
                            info: """
                                  Discovered by Gerard Kuiper in 1948, it was named after a character from Shakespeare’s \
                                  The Tempest. Features are named after people and places from The Tempest.
                                  """)
            case 1:
                return Moon(name: "Ariel",
                            description: """
                                          Ariel is one of the smallest of Uranus’s major moons—similar in size to Saturn’s moon Dione—but it is \
                                          the brightest. Its surface is a patchwork of cratered terrain, canyons, ridges, and plains, and \
                                          portions of it appear to be geologically young. The moon’s density suggests it is made of \
                                          roughly equal parts rock and ice.
                                         """,
                            info: """
                                  Discovered in 1851 by William Lassell, it was named after a character in William Shakespeare’s \
                                  The Tempest and Alexander Pope's The Rape of the Lock. Features  are named for light spirits.
                                  """)
            case 2:
                return Moon(name: "Umbriel",
                            description: """
                                         Umbriel is the darkest of Uranus’s five major moons, although the source of its shadowy color is mysterious. \
                                         Its surface is heavily cratered, suggesting that it isn’t geologically active. Umbriel’s darkness \
                                         is disrupted by several curiously bright, vaguely bluish patches, which scientists \
                                         suspect are frost deposits.
                                         """,
                            info: """
                                  Discovered in 1851 by William Lassell, it was named after a malevolent spirit in Pope’s The Rape of the Lock. \
                                  Features are named for dark spirits.
                                  """)
            case 3:
                return Moon(name: "Titania",
                            description: """
                                         Titania is the largest of the Uranian satellites and is the eighth most massive moon in the solar system. \
                                         Like its other large siblings, Titania is probably made of equal parts rock and ice. Its surface bears \
                                         fault valleys and other signs of early activity, suggesting that the moon was once a geologically active world.
                                         """,
                            info: """
                                  Discovered by William Herschel in 1787, it was named after a character in Shakespeare’s A Midsummer Night’s Dream. \
                                  Feature names are derived from female characters in Shakespearean plays.
                                  """)
            case 4:
                return Moon(name: "Oberon",
                            description: """
                                          Of Uranus’s five major moons, Oberon orbits the farthest from the planet. Its surface is the most cratered \
                                          of all its siblings, with its largest gouge marks named Hamlet, Macbeth, and Romeo. The moon’s icy face is \
                                          also riven by canyons, and it has a massive peak that stretches at least six miles high.
                                         """,
                            info: """
                                  Discovered by William Herschel in 1787, it was named after a character in Shakespeare’s A Midsummer Night’s Dream. \
                                  Features are named after heroes and places in Shakespearean tragedies.
                                  """)
            default: return nil
            }
        case .neptune:
            switch index {
            case 0:
                return Moon(name: "Triton",
                            description: """
                                          Neptune’s largest moon, Triton, is an active world, with smooth volcanic plains and evidence for geysers \
                                          erupting on its surface. It’s about twice as dense as water, which means Triton is largely rocky, \
                                          and it’s swaddled in a thin atmosphere that’s mostly made of nitrogen and methane. Unlike every \
                                          other large moon in the solar system, Triton orbits Neptune in retrograde, meaning that it moves in the \
                                          opposite direction as the planet’s spin. That strongly suggests that Neptune stole Triton, perhaps \
                                          yanking it from the nearby Kuiper belt.
                                          """,
                            info: """
                                  Discovered in 1846 by William Lassell, it was named after the son of Poseidon. Features are named \
                                  after aquatic spirits and terrestrial aquatic features.
                                  """)
            default: return nil
            }
        case .pluto:
            switch index {
            case 0:
                return Moon(name: "Charon",
                            description: """
                                          Charon is Pluto’s largest moon, and it’s so massive that the two bodies form a binary system with a shared \
                                          center of mass between them—the only such pairing known in our solar system. In contrast to Pluto, Charon is \
                                          dark and fractured, with massive canyons cracking its icy face. Its northern pole is distinctly red, \
                                          dyed by organic compounds that have migrated over from Pluto’s atmosphere.
                                          """,
                            info: """
                                   Discovered in 1978 by James Christy and Robert Harrington, it was named after the underworld’s ferryman \
                                   in Greek mythology. Features are named after people, places, and things from tales of exploration.
                                 """)
            default: return nil
            }
        }
    }
}



enum TypePlanet {
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
}

enum SizeMoon: CGFloat {
    case smaller = 0.1
    case small = 0.12
    case middle = 0.15
    case large = 0.25
}

