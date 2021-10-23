//
//  GameScene.swift
//  Senac-2
//
//  Created by IOS SENAC on 10/23/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var isDragging = false
    
    var spinnerSprite: SKSpriteNode?
    
    var startPosition: CGPoint?
    
    var currentRotation: CGFloat?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        let spinnerTexture = SKTexture(imageNamed: "spinner")
        spinnerSprite = SKSpriteNode(texture: spinnerTexture)
        let spinnerPhysicsBody = SKPhysicsBody(circleOfRadius: spinnerSprite!.size.width / 2)
        spinnerPhysicsBody.pinned = true
        spinnerSprite!.physicsBody = spinnerPhysicsBody
        
        
        addChild(spinnerSprite!)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let sprite = spinnerSprite{
            if sprite.contains(touch.location(in: self)) {
                isDragging = true
                startPosition = touch.previousLocation(in: self)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch moved")
        if isDragging, let touch = touches.first, let startPosition = startPosition, let sprite = spinnerSprite{
            print("is dragging")
            let impulse: CGFloat = calculateAngleBetweenTwoPoints(p1: startPosition, p2: touch.previousLocation(in: self))
            sprite.run(SKAction.rotate(byAngle: impulse, duration: 1))
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
    }
    
    private func degreesToRadians(degrees: CGFloat) -> CGFloat{
        return .pi * degrees / 180
    }
    
    private func calculateAngleBetweenTwoPoints(p1: CGPoint, p2: CGPoint) -> CGFloat{
        let v1 = CGVector(dx: p1.x - self.anchorPoint.x, dy: p1.y - self.anchorPoint.x)
        let v2 = CGVector(dx: p2.x - self.anchorPoint.y, dy: p2.y - self.anchorPoint.y)
        
        return atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        
        
    }
}
