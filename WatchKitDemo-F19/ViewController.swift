//
//  ViewController.swift
//  WatchKitDemo-F19
//
//  Created by MacStudent on 2019-10-15.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit
import WatchConnectivity  // built in library for making Phone <> Watch communication work

class ViewController: UIViewController, WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
 
    
    
    // Built-in methods for dealing with communication between Watch <> Phone
    // ------------------------------------------------
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("PHONE : I received a msg: \(message)")
        
        let name = message["name"] as! String
        let age = message["age"] as! String
        DispatchQueue.main.sync {
            sendMessageOutputLabel.text = name
            counterLabel.text = age
            
       
        }
    }

    
   
    

    // MARK: Outlets
    // ------------------------
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var sendMessageOutputLabel: UILabel!
    
   
    
    // MARK: Variables
    // ------------------------
    var phoneCounter:Int = 0
    var messageCounter:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---PHONE APP LOADED!")
        
        // @TODO: Does the phone support communication with the watch?
        if (WCSession.isSupported() == true) {
            sendMessageOutputLabel.text = "WC is supported!"
            
            // create a communication session with the watch
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else {
            sendMessageOutputLabel.text = "WC NOT supported!"
        }
    }

    
    // MARK: Custom Functions
    // ------------------------

    
    // When you press button, send a message to watch
    @IBAction func sendMessageButton(_ sender: Any) {
        print("Sending message to watch")
        // ------ SEND MESSAGE TO WATCH CODE GOES HERE
        if (WCSession.default.isReachable == true) {
            // Here is the message you want to send to the watch
            // All messages get sent as dictionaries
            let message = ["name":"Banana",
                           "color":"yellow"] as [String : Any]
            
            // Send the message
            WCSession.default.sendMessage(message, replyHandler:nil)
            messageCounter = messageCounter + 1
            sendMessageOutputLabel.text = "Message Sent \(messageCounter)"
            counterLabel.text = "Message Sent\(messageCounter)"
        }
        else {
            messageCounter = messageCounter + 1
            sendMessageOutputLabel.text = "Cannot reach watch! \(messageCounter)"
            counterLabel.text = "Cannot reach phone\(messageCounter)"
        }
        
        
        // -----------------------------------------------
        
    }
    
    
    
}

