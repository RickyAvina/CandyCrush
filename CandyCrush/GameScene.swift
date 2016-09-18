//
//  GameScene.swift
//  CandyCrush
//
//  Created by Maricela Avina on 9/16/16.
//  Copyright (c) 2016 InternTeam. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var level: Level!
    
    let TileWidth : CGFloat = 32.0
    let TileHeight : CGFloat = 36.0
    
    let gameLayer = SKNode()
    let cookiesLayer = SKNode()
    
    override func didMoveToView(view: SKView) {
    
        /* Setup your scene here */
        anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        let bgImage = SKSpriteNode(imageNamed: "Background");
        bgImage.size = self.frame.size;
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.addChild(bgImage);
        
        self.addChild(gameLayer)
        
        let layerPosition = CGPoint(x: -TileWidth * CGFloat(NumColumns)/2, y: -TileHeight * CGFloat(NumRows)/2)
        cookiesLayer.position = layerPosition
        gameLayer.addChild(cookiesLayer)
    }
    
    func addSpritesForCookies(cookies: Set<Cookie>) {
        for cookie in cookies {
            let sprite = SKSpriteNode(imageNamed: cookie.cookieType.spriteName)
            sprite.size = CGSize(width: TileWidth, height: TileHeight)
            sprite.position = pointForColumn(cookie.column, row: cookie.row)
            cookiesLayer.addChild(sprite)
        }
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(x: CGFloat(column)*TileWidth + TileWidth/2,
                       y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Background")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
           
            self.addChild(sprite)
        }
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
