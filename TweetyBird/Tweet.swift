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
  
  // the dictionary passed in: STRING==KEY, ANYOBJECT==VAL
  init ( _ jsonDictionary : [String : AnyObject ] ) {
    self.text = jsonDictionary["text"] as String
    // pull ref to inner dictionary
    let userDictionary = jsonDictionary["user"] as [String: AnyObject]
    // access values in inner dictionary
    self.userName = userDictionary["name"] as String
    self.imageURL = userDictionary["profile_image_url"] as String
  }
}