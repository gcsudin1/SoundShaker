//
//  ViewController.swift
//  SoundShaker
//
//  Created by IMCS2 on 8/8/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var songsArray = ["hami yestai ta ho ni","aaja hamro vet","aakha lobi","yo kura gopya","waka waka","viral bhaidiyo","parana parana","dilko bhittama","police siren","saani narisauna"]
    var songsArrayCount = 0
    var player = AVAudioPlayer()
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    
    @IBAction func volumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let audioPath = Bundle.main.path(forResource: songsArray[songsArrayCount], ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }catch{
            print("Error playing")
        }
        myLabel.text = songsArray[0]
        playSong()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype,with event: UIEvent?){
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            let number = Int.random(in: 0 ..< 10)
            songsArrayCount = number
            myLabel.text = songsArray[songsArrayCount]
            playSong()
        }
    }
    
    func playSong(){
        let audioPath = Bundle.main.path(forResource: songsArray[songsArrayCount], ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            myLabel.text = songsArray[songsArrayCount]
        }catch{
            print("Error playing")
        }
        player.play()
    }
    
    @objc func swipped(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.right {
                songsArrayCount -= 1
                if songsArrayCount < 0 {
                    songsArrayCount = 0
                    myLabel.text = songsArray[0]
                }
                playSong()
            }else{
                songsArrayCount += 1
                if songsArrayCount == 10 {
                    myLabel.text = songsArray[0]
                    songsArrayCount = 0
                }
                playSong()
            }
            
        }
    }
    
    
}

