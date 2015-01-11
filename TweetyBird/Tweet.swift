//
//  Tweet.swift
//  TweetyBird
//
//  Created by Stephen on 1/5/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class Tweet {
  var text : String
  var userName : String
  var imageURL : String
  var image : UIImage?
  var id : String
  var favoriteCount : String?
  var userID : String
  
  init ( _ jsonDictionary : [String : AnyObject ] ) {
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String: AnyObject]
    self.userName = userDictionary["name"] as String
    self.imageURL = userDictionary["profile_image_url"] as String
    self.id = userDictionary["id_str"] as String
    self.userID = userDictionary["id_str"] as String
    
    println(userDictionary)
    
    if jsonDictionary["in_reply_to_user_id_str"] is NSNull {
      println("NSNull in_reply_to_user_id_str Tweet()")
    }
  }
  func updateWihInfo(infoDictionary : [String : AnyObject]) {
    let favoriteNumber = infoDictionary["favorite_count"] as Int
    self.favoriteCount = "\(favoriteNumber)"
  }
}