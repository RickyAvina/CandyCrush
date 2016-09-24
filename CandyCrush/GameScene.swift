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
    let tilesLayer = SKNode()
    
    private var swipeFromColumn: Int?
    private var swipeFromRow: Int?
    
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
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        gameLayer.addChild(cookiesLayer)
        
        swipeFromColumn = nil
        swipeFromRow = nil

    }
    
    func addTiles(){
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if level.tileAtColumn(column, row: row) != nil {
                    let tileNode = SKSpriteNode(imageNamed: "Tile")
                    tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                    tileNode.position = pointForColumn(column, row: row)
                    tilesLayer.addChild(tileNode)
                }
            }
        }
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
    
    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int){
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
            return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)    // invalid location
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.locationInNode(cookiesLayer)
        let (success, column, row) = convertPoint(location)
        if success {
            if let cookie = level.cookieAtColumn(column, row: row) {
                swipeFromColumn = column
                swipeFromRow = row
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard swipeFromColumn != nil else {return}
        guard let touch = touches.first else {return}
        let location = touch.locationInNode(cookiesLayer)
        
        let (success, column, row) = convertPoint(location)
        if success {
            var horzDelta = 0, vertDelta = 0
            if column < swipeFromColumn! {              // swipe left
                horzDelta = -1
            } else if column > swipeFromColumn! {       // swipe right
                horzDelta = 1
            } else if row < swipeFromRow! {             // swipe down
                vertDelta = -1
            } else if row > swipeFromRow! {             // swipe up
                vertDelta = 1
            }
            
            if horzDelta != 0 || vertDelta != 0 {
                trySwapHorizontal(horzDelta, vertical: vertDelta)
                swipeFromColumn = nil
            }
        }
        
    }
    
    func trySwapHorizontal(horzDelta: Int, vertical verDelta: Int) {
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + verDelta
        
        guard toColumn >= 0 && toColumn < NumColumns else {return}
        guard toRow >= 0 && toRow < NumRows else {return}
        
        if let toCookie = level.cookieAtColumn(toColumn, row: toRow),
           let fromCookie = level.cookieAtColumn(swipeFromColumn!, row: swipeFromRow!) {
            print("*** swapping \(fromCookie) with \(toCookie)")
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swipeFromColumn = nil
        swipeFromRow = nil
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let touches = touches {
            touchesEnded(touches, withEvent: event)
        }
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
