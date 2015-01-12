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
    let userDictionary = jsonDictionary["user"] as [String: AnyObject]
    self.text = jsonDictionary["text"] as String
    self.userName = userDictionary["name"] as String
    self.imageURL = userDictionary["profile_image_url"] as String
    self.id = jsonDictionary["id_str"] as String
    self.userID = userDictionary["id_str"] as String
    /*
    if jsonDictionary["in_reply_to_user_id"] is NSNull {
      println("NSNull in_reply_to_user_id Tweet()")
    } */
  }
  func updateWihInfo(infoDictionary : [String : AnyObject]) {
    let favoriteNumber = infoDictionary["favorite_count"] as Int
    self.favoriteCount = "\(favoriteNumber)"
  }
}