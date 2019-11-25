//
//  ViewController.swift
//  DAE Example
//
//  Created by Cedric Larrat on 31.07.17.
//  Copyright © 2017 Deep Art Effects GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var accessKey = "--INSERT YOUR ACCESS KEY--"
    var secretKey = "--INSERT YOUR SECRET KEY--"
    var apiKey = "--INSERT YOUR API KEY--"
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var client: DAEDeepArtEffectsClient!
    var styles : [DAEStyle]!
    var timer : Timer!
    var timerIsRunning : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        
        let configuration = AWSServiceConfiguration(region: AWSRegionType.EUWest1, credentialsProvider: credentialsProvider)

        client = DAEDeepArtEffectsClient.init(configuration: configuration!)
        
        client.apiKey = apiKey
        
        client.stylesV2Get().continueWith{ (task: AWSTask?) -> AnyObject? in
            if let error = task?.error {
                print("Error occurred: \(error)")
                return nil
            }
            
            if let result = task?.result {
                self.styles = result.styles
            }
            
            return nil
        }
    }

    @IBAction func createArtClicked(_ sender: Any) {
        
        if(self.timerIsRunning) {
            return
        }
        
        self.timerIsRunning = true
        
        let imageData:NSData = photoImageView.image!.pngData()! as NSData
        
        let randomStyleIndex = Int(arc4random_uniform(UInt32(styles.count)))
        let styleId = styles[randomStyleIndex].id
        
        let uploadRequest = DAEUploadRequest()
        uploadRequest?.styleId = styleId
        uploadRequest?.imageBase64Encoded = imageData.base64EncodedString()
        
        print(String(format: "Upload image using style %@", styleId!))
        
        client.uploadPost(body: uploadRequest!).continueWith{ (task: AWSTask?) -> AnyObject? in
            if let error = task?.error {
                print("Error occurred: \(error)")
                return nil
            }
            
            if let result = task?.result {
                
                print("Upload finished")
                
                DispatchQueue.main.async {
                    
                    self.timer = Timer.scheduledTimer(
                        timeInterval: 2.5,
                        target: self,
                        selector: #selector(ViewController.checkSubmissionStatus(_:)),
                        userInfo: result.submissionId,
                        repeats: true)
                }
            }
            return nil
        }
    }
    
    @objc func checkSubmissionStatus(_ timer:Timer) {
        
        print("Checking for a result")
        
        client.resultGet(submissionId: self.timer.userInfo as? String).continueWith{ (task: AWSTask?) -> AnyObject? in
            if let error = task?.error {
                print("Error occurred: \(error)")
                return nil
            }
            
            if let result = task?.result {
                if(result.status == "finished") {
                    print("Artwork is ready")
                    self.timerIsRunning = false
                    self.timer.invalidate()
                    let url = URL(string: result.url!)
                    let data = try? Data(contentsOf: url!)
                    let image: UIImage = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.photoImageView.image = image
                    }
                }
            }
            
            return nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

