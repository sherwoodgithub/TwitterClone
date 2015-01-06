//
//  Tweet.swift
//  TweetyBird
//
//  Created by Stephen on 1/5/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import Foundation

class Tweet {
  var text : String
  var userName : String
  init ( _ jsonDictionary : [String : AnyObject ] ) {
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String: AnyObject]
    self.userName = userDictionary["name"] as String
  }
}