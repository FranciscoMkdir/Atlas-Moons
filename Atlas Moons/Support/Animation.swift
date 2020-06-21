//
//  Animation.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 29/04/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

// MARK: - Framework

public enum PositonAnimation{
    case top
    case bottom
    case left
    case right
}

public struct Animation {
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let closure: (UIView) -> Void
}

public extension Animation {
    
    static func applyTransform(_ transform: CGAffineTransform,
                               duration: TimeInterval = 0.35,
                               delay: TimeInterval = 0.0) -> Animation {
        return Animation(duration: duration, delay: delay) { $0.transform = transform }
    }
    
    static func fadeIn(duration: TimeInterval = 0.35,
                       delay: TimeInterval = 0.0) -> Animation {
        return Animation(duration: duration, delay: delay) { $0.alpha = 1 }
    }

    static func fadeOut(duration: TimeInterval = 0.35,
                        delay: TimeInterval = 0.0) -> Animation {
        return Animation(duration: duration, delay: delay) { $0.alpha = 0 }
    }

    static func resize(to size: CGSize,
                       duration: TimeInterval = 0.35,
                       delay: TimeInterval = 0.0) -> Animation {
        return Animation(duration: duration, delay: delay) { $0.bounds.size = size }
    }

    static func move(byX x: CGFloat,
                     y: CGFloat,
                     duration: TimeInterval = 0.35,
                     delay: TimeInterval = 0.0) -> Animation {
        return Animation(duration: duration, delay: delay) {
            $0.center.x += x
            $0.center.y += y
        }
    }
}

public final class AnimationToken {
    private let view: UIView
    private let animations: [Animation]
    private let mode: AnimationMode
    private var isValid = true

    internal init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }

    deinit {
        perform {}
    }

    internal func perform(completionHandler: @escaping () -> Void) {
        guard isValid else {
            return
        }

        isValid = false

        switch mode {
        case .inSequence:
            view.performAnimations(animations, completionHandler: completionHandler)
        case .inParallel:
            view.performAnimationsInParallel(animations, completionHandler: completionHandler)
        }
    }
}

extension CGAffineTransform{
    public init(scaleBy value: CGFloat){
        self.init(scaleX: value, y: value)
    }
}

internal enum AnimationMode {
    case inSequence
    case inParallel
}

public func animate(_ tokens: [AnimationToken]) {
    guard !tokens.isEmpty else {
        return
    }

    var tokens = tokens
    let token = tokens.removeFirst()

    token.perform {
        animate(tokens)
    }
}

public func animate(_ tokens: AnimationToken...) {
    animate(tokens)
}

public extension UIView {
    @discardableResult func animate(_ animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inSequence
        )
    }

    @discardableResult func animate(_ animations: Animation...) -> AnimationToken {
        return animate(animations)
    }

    @discardableResult func animate(inParallel animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inParallel
        )
    }

    @discardableResult func animate(inParallel animations: Animation...) -> AnimationToken {
        return animate(inParallel: animations)
    }
}

internal extension UIView {
    func performAnimations(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHandler()
        }

        var animations = animations
        let animation = animations.removeFirst()
        
        let propertyAnimation = UIViewPropertyAnimator(duration: animation.duration, dampingRatio: 0.9) {
            animation.closure(self)
        }
        propertyAnimation.addCompletion { _ in
            self.performAnimations(animations, completionHandler: completionHandler)
        }
        propertyAnimation.startAnimation(afterDelay: animation.delay)
    }

    func performAnimationsInParallel(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHandler()
        }

        let animationCount = animations.count
        var completionCount = 0

        let animationCompletionHandler = {
            completionCount += 1

            if completionCount == animationCount {
                completionHandler()
            }
        }

        for animation in animations {
            let propertyAnimation = UIViewPropertyAnimator(duration: animation.duration,
                                                   dampingRatio: 0.9) {
                                                    animation.closure(self) }
            propertyAnimation.addCompletion { _ in animationCompletionHandler() }
            propertyAnimation.startAnimation(afterDelay: animation.delay)
        }
    }
}
