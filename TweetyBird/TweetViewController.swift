//
//  TweetViewController.swift
//  TweetyBird
//
//  Created by Stephen on 1/7/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
  
  var theTweet : Tweet!
  
  @IBOutlet weak var tweetTextLabel : UILabel!
  @IBOutlet weak var userNameLabel : UILabel!
  @IBOutlet weak var imageView : UIImageView!
  @IBOutlet weak var favoriteLabel : UILabel!
  
  var networkVC: NetworkController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tweetTextLabel.text = theTweet.text
    self.userNameLabel.text = theTweet.userName
    self.imageView.image = theTweet.image
    
    self.networkVC.fetchInfoForTweet (theTweet.id, completionHandler: { (infoDictionary, errorDescription) -> () in
      if errorDescription == nil {
        self.theTweet.updateWihInfo(infoDictionary!)
      }
      self.favoriteLabel.text = self.theTweet.favoriteCount
    })
  }
}