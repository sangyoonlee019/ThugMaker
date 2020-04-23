//
//  FirstViewController.swift
//  ThugMaker
//
//  Created by 이상윤 on 2020/04/22.
//  Copyright © 2020 yoon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate , AVAudioPlayerDelegate{

    var player: AVAudioPlayer!
    
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet var uiView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var sunglassImageView: UIImageView!
    let picker = UIImagePickerController()


    var bottomChoices = [CaptionOption(emoji: "😔", caption: "Boring...", caption2: ""),CaptionOption(emoji: "😎", caption: "Woooooooooo Damn!!!!!!!", caption2: "💵 💵 💵")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializePlayer()
        bottomCaptionSegmentedControl.removeAllSegments()
        for choice in bottomChoices {
            bottomCaptionSegmentedControl.insertSegment(withTitle: choice.emoji, at: bottomChoices.count, animated: false)
        }
        
        bottomCaptionSegmentedControl.selectedSegmentIndex = 0

        updateBottomCaption(index : bottomCaptionSegmentedControl.selectedSegmentIndex)
        picker.delegate = self
        
    }
    
    func initializePlayer() {
    
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "Thug") else {
            print("음원 파일 에셋을 가져올 수 없습니다")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }
        
    }

    func updateBottomCaption(index : Int){
        bottomCaptionLabel.text=bottomChoices[index].caption
        topCaptionLabel.text=bottomChoices[index].caption2
        if index == 0{
            bottomImageView.isHidden = true
            sunglassImageView.isHidden = true
            uiView.backgroundColor = UIColor.white
            bottomCaptionLabel.textColor = UIColor.black
            topImageView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
            self.player?.pause()
//            bottomCaptionLabel.font = UIFont(name: "HoefierText-black", size: UIFont.labelFontSize)
        }else{
            bottomImageView.isHidden = false
            sunglassImageView.isHidden = false
            uiView.backgroundColor = UIColor.black
            bottomCaptionLabel.textColor = UIColor.white
            topImageView.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
            self.player?.play()
//            bottomCaptionLabel.font = UIFont(name: "HoefierText", size: UIFont.labelFontSize)
        }
    }


    func openLibrary(){

      picker.sourceType = .photoLibrary

      present(picker, animated: false, completion: nil)

    }

    func openCamera(){

      picker.sourceType = .camera

      present(picker, animated: false, completion: nil)

    }
    
    @IBAction func updateImage(_ sender: Any) {
        let alert =  UIAlertController(title: "사진", message: "사진을 업로드 합니다", preferredStyle: .actionSheet)


        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()

        }


        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera()

        }


    let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    alert.addAction(library)
    alert.addAction(camera)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
    }
    



    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        updateBottomCaption(index : bottomCaptionSegmentedControl.selectedSegmentIndex)
    }


    
}
