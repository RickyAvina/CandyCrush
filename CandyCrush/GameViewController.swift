//
//  GameViewController.swift
//  CandyCrush
//
//  Created by Maricela Avina on 9/16/16.
//  Copyright (c) 2016 InternTeam. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var level : Level!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            level = Level(filename: "Level_1")
            scene.level = level
            
            skView.presentScene(scene)
            
            let newCookies = level.shuffle()
            scene.addSpritesForCookies(newCookies)

        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .Portrait
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.

    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func fun1(){
        func fun2(){
            func fun3(){
                print("ayy")
            }
        }
    }
}
