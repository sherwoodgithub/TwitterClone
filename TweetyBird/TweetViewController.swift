//
//  TweetViewController.swift
//  TweetyBird
//
//  Created by Stephen on 1/7/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
  
  var tweet : Tweet!
  
  @IBOutlet weak var tweetTextLabel : UILabel!
  @IBOutlet weak var userNameLabel : UILabel!
  @IBOutlet weak var imageView : UIImageView!
  @IBOutlet weak var favoriteLabel : UILabel!
  
  var networkVC: NetworkController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tweetTextLabel.text = tweet.text
    self.userNameLabel.text = tweet.userName
    self.imageView.image = tweet.image
    
    self.networkVC.fetchInfoForTweet (tweet.id, completionHandler: { (infoDictionary, errorDescription) -> () in
      if errorDescription == nil {
        self.tweet.updateWihInfo(infoDictionary!)
        self.favoriteLabel.text = self.tweet.favoriteCount
      }
    })
  }
}